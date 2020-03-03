<div class="product-views clearfix">
    <div>
        <i class="icon-view"></i>
        <span>{$advert->getViews()}</span>
    </div>
    <div>
        <i class="icon-fav"></i>
        
                        {if $user != false && $user->getFavorites() != '' && $user->getFavorites() != NULL && $user->getFavorites() != false}

                                <span>{$Adverts->getAdvertFavoritesCount($advert->getId())}</span>

                        {else}
                        <span>0</span>
                        {/if}
    </div>
</div>
<div class="product-views_menu">
    <ul>
        <li><a href="/advert.php?id={$advert->getId()}">Открыть</a></li>
        
        <li><a href="/edit_advert.php?id={$advert->getId()}">Редактировать</a></li>

        <li><a href="#update" class="open-forms update{if $update_prices->GetAdvertStatusInUpdate($user->getId(), $advert->getId()) == 1} save_clients_history_top4{/if}" data-mfp-src="#update" data-section-id="{$advert->getSection()->getId()}" data-category-id="{$advert->getCategory()->getId()}" data-subcategory-id="{$advert->getSubcategory()->getId()}" data-country-id="{$advert->getLocation()->getId()}" data-city-id="{if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}{foreach from=$country->GetCitiesOfCountry($advert->getLocation()->getId()) item=$city}{if $city->getName() == $advert->getLocationName()}{$city->getId()}{/if}{/foreach}{else}0{/if}" data-advert-id="{$advert->getId()}">Обновить</a></li>

        <li><a href="#top4" class="open-forms top{if $top_4_prices->GetAdvertStatusInTop4($user->getId(), $advert->getId()) == 1} save_clients_history_top4{/if}" data-mfp-src="#top4" data-section-name="{$advert->getSection()->getName()}" data-category-name="{$advert->getCategory()->getName()}" data-subcategory-name="{$advert->getSubcategory()->getName()}" data-section-id="{$advert->getSection()->getId()}" data-category-id="{$advert->getCategory()->getId()}" data-subcategory-id="{$advert->getSubcategory()->getId()}" data-country-id="{$advert->getLocation()->getId()}" data-city-id="{if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}{foreach from=$country->GetCitiesOfCountry($advert->getLocation()->getId()) item=$city}{if $city->getName() == $advert->getLocationName()}{$city->getId()}{/if}{/foreach}{else}{/if}" data-advert-id="{$advert->getId()}">В ТОП</a></li>

        <li>
            <a href="#in_archive" class="open-forms archive" data-advert_id="{$advert->getId()}" data-type="{if !empty($_GET['type']) AND $_GET['type'] == 'close'}0{else}1{/if}">
                {if !empty($_GET['type']) AND $_GET['type'] == 'close'}
                    Из архива
                {else}
                    В архив
                {/if}
            </a>
        </li>
    </ul>
</div>