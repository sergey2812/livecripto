    <div class="product-item">
        {$photos = $advert->GetPhotos()}
        <div class="product-item_image" style="background: url({$files_dir}{$photos[0]});">
            <div class="product-item_photos">
                <i></i> <span>{count($photos)}</span>
            </div>

            {if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}
            <div class="product-item_city">{$advert->getCity()}</div>
            {elseif $advert->GetLocation()->getId() > 0 AND $advert->GetLocation()->getName() != 'Весь МИР' AND empty($advert->getCity())}
            <div class="product-item_city">{$advert->GetLocation()->getName()}</div> 
            {else}           
            <div class="product-item_city">Передача через сеть</div>           
            {/if}

            <div class="product-item_safe">
            {if $advert->getSecureDeal()}
                <img src="{$template}/img/product-item-safe_icon.png" alt="">
            {/if}
            </div>

            <div class="product-item_fav add_to_favorites{if $user == false} open-register{/if}" data-advert_id="{$advert->getId()}">

            {if $user != false && $advert->getAuthor()->getId() != $user->getId()}
                <i{if !empty($user) AND in_array($advert->getId(), $user->getFavorites())}class="filled"{/if}></i>
            {/if}
            </div>
        </div>
        <div class="product-info">
            <a href="/advert.php?id={$advert->getId()}" class="product-info_title" data-toggle="tooltip" title="{htmlspecialchars($advert->getName())}">
                {$advert->getName()}
            </a>
            <div class="product-info_price">
                <ul>
                    <li class="current">
                        {$price = $advert->getFirstPrice()}
                        <div>
                            <img src="{$template}/img/{mb_strtolower($price['type'])}.png" alt="{$price['type']}">
                            <span>{$price['type']}</span>
                        </div>
                        <div class="price {if count($advert->getPrices()) <= 1}one-price{/if}">
                            {substr($price['value'], 0, 8)}
                        </div>
                        {if count($advert->getPrices()) > 1}
                            {$i = 0}
                            <ul>
                                {foreach from=$advert->getPrices() item=$price key=$type}
                                    {if $i != 0}
                                        <li>
                                            <div>
                                                <img src="{$template}/img/{mb_strtolower($type)}.png" alt="">
                                                <span>{$type}</span>
                                            </div>
                                            <div class="price">{substr($price, 0, 8)}</div>
                                        </li>
                                    {/if}
                                    {$i = $i + 1}
                                {/foreach}
                            </ul>
                        {/if}
                    </li>
                </ul>
            </div>
        </div>
    </div>
