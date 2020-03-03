<div class="col-xs-2 admin">
    <div class="product-item">
        {$photos = $advert->getPhotos()}
        <div class="product-item_image" style="background: url(/files/{$photos[0]});">
            <div class="product-item_photos">
                <i></i><span>&nbsp;{count($photos)}</span>
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
        </div>
        <div class="product-info">
            <a href="/admin/adverts.php?type=single&id={$advert->getId()}" class="product-info_title">
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
                            <ul class="product-info_price">
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
</div>