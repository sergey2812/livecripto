{include file='elements/main/header.tpl'}

{$wallets = $advert->getAuthor()->getWallets()}

{if $user != false}
    {$user_wallets = $user->getWallets()}
<script>
    let author_wallets = {
        {if !empty($wallets['btc'])}
            btc: '{$wallets['btc']}',
        {/if}
        {if !empty($wallets['eth'])}
            eth: '{$wallets['eth']}',
        {/if}
        {if !empty($wallets['ltc'])}
            ltc: '{$wallets['ltc']}',
        {/if}
        {if !empty($wallets['xrp'])}
            xrp: '{$wallets['xrp']}',
        {/if}
    };
        let user_wallets = {
            {if !empty($user_wallets['btc'])}
                btc: '{$user_wallets['btc']}',
            {/if}
            {if !empty($user_wallets['eth'])}
                eth: '{$user_wallets['eth']}',
            {/if}
            {if !empty($user_wallets['ltc'])}
                ltc: '{$user_wallets['ltc']}',
            {/if}
            {if !empty($user_wallets['xrp'])}
                xrp: '{$user_wallets['xrp']}',
            {/if}
    };
</script>

<script src="{$template}/js/helpers/advert.js"></script>
{/if}

<script src="{$template}/js/functions/show_hide_info.js"></script>

{include file='elements/main/breadcrubms.tpl'}

<div class="product-single_content">
    <div class="container">
        <div class="row">
            <div class="col-xs-10" style="padding-left: 5px">
                <h1 class="product-single_title">{$advert->getName()} {if $advert->isSecureDeal()}<img src="{$template}/img/safe_icon_bg.png" alt="">{/if}</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2">
                <div class="contvert-widget" style="width: 100%; height:335px; background-color: #FAFAFA; overflow:hidden; box-sizing: border-box; border: 1px solid #56667F; border-radius: 4px; text-align: right; line-height:14px; block-size:335px; font-size: 12px; box-sizing:content-box; font-feature-settings: normal; text-size-adjust: 100%; box-shadow: inset 0 -20px 0 0 #56667F;margin: 0;width: 193px;padding:1px;padding: 0px; margin: 0 0 35px;"><div style="height:315px;"><iframe src="https://widget.coinlib.io/widget?type=converter&theme=light" width="250" height="310" scrolling="auto" marginwidth="0" marginheight="0" frameborder="0" border="0" style="border:0;margin:0;padding:0;"></iframe></div><div style="color: #FFFFFF; line-height: 14px; font-weight: 400; font-size: 11px; box-sizing:content-box; margin: 3px 6px 10px 0px; font-family: Verdana, Tahoma, Arial, sans-serif;">powered by&nbsp;<a href="https://coinlib.io" target="_blank" style="font-weight: 500; color: #FFFFFF; text-decoration:none; font-size: 11px;">Coinlib</a></div></div>

                    <div class="advertising-item">
                        {if !empty($adsBlock7)}
                            {$adsBlock7}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
                    <div class="advertising-item">
                        {if !empty($adsBlock8)}
                            {$adsBlock8}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
            </div>
            <div class="col-xs-6">
                <div class="owl-carousel product-single_gallery">
                    {foreach from=$advert->getPhotos() item=$photo key=$i}
                        {if $i == 0}
                            <div class="product-single-gallery_item">
                                <img src="/files/{$photo}">
                                <a href="/files/{$photo}" class="product-single-gallery_l">
                                    <svg version="1.1" id="Слой_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                         viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">
                                    <polygon fill="#FFFFFF" points="39.2,146.2 0,255.5 110.5,217.4 83,190 189,83.8 216.3,111.2 254.7,0.7 145.3,40.3 171.6,66.5
                                    65.6,172.6 "/>
                                    </svg>
                                </a>
                            </div>
                        {else}
                            <div class="product-single-gallery_item">
                                <img src="/files/{$photo}">
                                <a href="/files/{$photo}" class="product-single-gallery_l">
                                    <svg version="1.1" id="Слой_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                         viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve">
                                    <polygon fill="#FFFFFF" points="39.2,146.2 0,255.5 110.5,217.4 83,190 189,83.8 216.3,111.2 254.7,0.7 145.3,40.3 171.6,66.5
                                    65.6,172.6 "/>
                                    </svg>
                                </a>
                            </div>
                        {/if}
                    {/foreach}
                </div>
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Размещено
                    </div>
                    <div class="product-single-info_block product-views">
                        <div class="date">{date('d.m.Y', strtotime($advert->getDate()))}</div>
                        <div class="views">
                            <i></i>
                            <span>{$advert->getViews()}</span>
                        </div>


                        <div class="likes add_to_favorites" data-advert_id="{$advert->getId()}" style="margin-right: 13em; margin-top: 2.5px;">
                            {if $user == false}
                            <a href="#login" class="head-item_buttons open-forms" data-tab="panel1">
                            {/if}

                        {if $user != false && $advert->getAuthor()->getId() != $user->getId()}
        <i{if !empty($user) AND in_array($advert->getId(), $user->getFavorites())} class="filled"{/if}></i><span class="counter">{$Adverts->getAdvertFavoritesCount($advert->getId())}</span>
                        {else}               
                            <span></span>
                        {/if}
                        {if $user == false}</a>{/if}
                        </div>


{*                        {if $user != false && $advert->getAuthor()->getId() == $user->getId()}
                            <div style="margin-right: 10em; margin-top: -23px;">
                            {if $user != false && $advert->getAuthor()->getId() == $user->getId()}    
                                <i class="icon-fav"></i>

                                <span>{$Adverts->getAdvertFavoritesCount($advert->getId())}</span>

                            {else}
                                <span></span>
                            {/if}
                            </div>
                        {/if}
*}
                    </div>
                </div>
                {if $advert->getConditionType() > 0}
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Состояние
                    </div>
                    <div class="product-single-info_block">
                        {if $advert->getConditionType() == 1}
                            Новое
                        {else}
                            Б/У
                        {/if}
                    </div>
                </div>
                {/if}
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Описание
                    </div>
                    <div class="product-single-info_block">
                        {$advert->getDescription()}
                    </div>
                </div>

                    <div class="product-single_info">
                        <div class="product-single-info_label">
                            Место сделки
                        </div>

                        {if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}
                        <div class="product-single-info_block">
                            {$advert->getLocation()->getName()}, {$advert->getCity()}
                        </div>
                        {else}
                        <div class="product-single-info_block">
                            Передача через сеть
                        </div>
                        {/if}
                    </div>
{*        
            {if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}
            <div class="product-item_city">{$advert->getCity()}</div>
            {elseif $advert->GetLocation()->getId() > 0 AND $advert->GetLocation()->getName() != 'Весь МИР' AND empty($advert->getCity())}
            <div class="product-item_city">{$advert->GetLocation()->getName()}</div> 
            {else}           
            <div class="product-item_city">Передача через сеть</div>           
            {/if}
*}

                <div class="product-single_info product-single_info__social">
                    <div class="product-single-info_label">
                        Поделиться
                    </div>
                    <div class="product-single-info_block">

                        <script src="//yastatic.net/es5-shims/0.0.2/es5-shims.min.js"></script>
                        <script src="//yastatic.net/share2/share.js"></script>
                        <div class="ya-share2" data-services="vkontakte,facebook,odnoklassniki,twitter,reddit,whatsapp,telegram,email"></div>

                        <style>
                            .ya-share2__counter:before{
                                display: none;
                            }
                            .ya-share2 a.ya-share2__link{
                                display: inline;
                            }
                            .ya-share2 .ya-share2__icon{
                                display: inline-block;
                                margin: 0;
                                width: 100%;
                                background-position: 50% 50%;
                                height: 40px;
                                background-repeat: no-repeat;
                            }
                            .ya-share2 .ya-share2__badge{
                                width: 40px !important;
                                height: 40px !important;
                                border-radius: 50%;
                            }
                            .ya-share2 .ya-share2__badge:hover{
                                opacity: 0.6;
                            }                            
                        </style>
                    </div>
                </div>
            </div>
            <div class="col-xs-4 {if !$advert->isSecureDeal()}not-secure{/if}">
                {$prices = $advert->getPrices()}
                {foreach from=$prices item=$price key=$type}
                    <div class="product-single_price">
                        <div class="product-single-price_icon">
                            <img src="{$template}/img/{mb_strtolower($type)}.png" alt="">
                            <p>{mb_strtoupper($type)}</p>
                        </div>
                        <span>{$price}</span>
                    </div>
                {/foreach}
            

        {if $user != false AND $advert->getAuthor()->getId() != $user->getId()}

        <a href="/dashboard.php?page=chat&new_chat={$advert->getAuthor()->getId()}&subject={urlencode($advert->getName())}&advert={$advert->getId()}"
            class="message-seller">
                                        {t}Написать в чат{/t}
        </a>
        
        {elseif $user != false AND $advert->getAuthor()->getId() == $user->getId()}

        <a href="/edit_advert.php?id={$advert->getId()}" 
            class="message-seller">

                                        {t}Редактировать{/t}
        </a>
        
        {elseif $user == false}

        <a href="#login" 
            class="message-seller head-item_buttons head-item_register open-forms" 
            data-tab="panel2">

                                        {t}Написать в чат{/t}
        </a>
        {/if}

                <div class="product-single_seller text-center">
                    <div class="seller">Продавец</div>
                    {include file='elements/advert/rating.tpl' rating=$advert->getAuthor()->getRating()}

                    {if !empty($advert->getAuthor()->getAvatar())}
                        <div class="user-icon" style="background: #{$advert->getAuthor()->getColor()}">
                            <img src="/files/{$advert->getAuthor()->getAvatar()}">
                        </div>
                    {/if}
                    {if $user == false}
                        <a href="#login" class="user-name head-item_buttons head-item_register open-forms" data-tab="panel2">{$advert->getAuthor()->getLogin()}</a>
                    {else}
                        <a href="/dashboard.php?page=my_adverts&user_id={$advert->getAuthor()->getId()}" class="user-name">{$advert->getAuthor()->getLogin()}</a>
                    {/if}
                    <div class="user-likes">
                        <div>
                            <i class="user-like"></i>{$advert->getAuthor()->getLikes()}
                        </div>
                        <div>
                            <i class="user-dislike"></i>{$advert->getAuthor()->getDislikes()}
                        </div>
                    </div>
                    <div class="user-links">
                        <div class="row">
                            <div class="col-xs-12">
                                {if $user == false}
                                    <a href="#login" class="user-links_in_sell head-item_buttons head-item_register open-forms" data-tab="panel2">Объявлений в продаже: <span>{$Users->getAdvertsCount($advert->getAuthor()->getId())}</span></a>
                                {else}
                                    <a href="/dashboard.php?page=my_adverts&user_id={$advert->getAuthor()->getId()}" class="user-links_in_sell">Объявлений в продаже: <span>{$Users->getAdvertsCount($advert->getAuthor()->getId())}</span></a>
                                {/if}
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                {if $user == false}
                                    <a href="#login" class="user-links_in_sell green head-item_buttons head-item_register open-forms" data-tab="panel2">Продал: <span>{$Users->getSells($advert->getAuthor()->getId())}</span></a>
                                {else}
                                    <a href="/dashboard.php?page=my_sells&user_id={$advert->getAuthor()->getId()}" class="user-links_in_sell green">Продал: <span>{$Users->getSells($advert->getAuthor()->getId())}</span></a>
                                {/if}
                            </div>
                            <div class="col-xs-6">
                                <a href="#" class="user-links_in_sell green-light">Купил: <span>{$Users->getBuys($advert->getAuthor()->getId())}</span></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                {if $user == false}
                                    <a href="#login" class="user-links_in_sell purple open-forms head-item_buttons head-item_register open-forms" data-tab="panel2">Отзывы о продавце</a>
                                {else}
                                    <a href="#reviews" class="user-links_in_sell purple open-forms">Отзывы о продавце</a>
                                {/if}

                                {include file='elements/user_reviews.tpl' user=$advert->getAuthor()}

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                <a href="#" class="user-links_in_sell gray"><img src="{$template}/img/head-logo.png" alt="" width="40"><span>{if $user != false}{date('d.m.Y', strtotime($advert->getAuthor()->getRegisterDate()))}{/if}</span></a>
                            </div>
                            <div class="col-xs-6">
                                {if $user == false}
                                    <a href="#login" data-tab="panel2" class="user-links_in_sell red head-item_buttons head-item_register open-forms">Сообщить<br> о нарушении</a>
                                {else}
                                    <a href="#report" class="user-links_in_sell red open-forms advert-report" data-advert-id="{$advert->getId()}" data-user-from="{$user->getId()}" data-user-to="{$advert->getAuthor()->getId()}">Сообщить<br> о нарушении</a>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {if $user != false}
        <form method="post" id="report" class="report-popup mfp-hide no-ajax" action="/ajax/bannedusers/create_cause_user_banned.php">
            <div class="report-popup_head text-center">Сообщить о нарушении</div>
            <div class="report-popup_body">
                <div class="form-row">
                    <input type="radio" id="report-type-1" name="report" value="Мошенничество" checked>
                    <label for="report-type-1">Мошенничество</label>
                </div>
                <div class="form-row">
                    <input type="radio" id="report-type-2" name="report" value="Спам">
                    <label for="report-type-2">Спам</label>
                </div>
                <div class="form-row">
                    <input type="radio" id="report-type-3" name="report" value="Запрещенный товар">
                    <label for="report-type-3">Запрещенный товар</label>
                </div>
                <div class="form-row">
                    <input type="radio" id="report-type-4" name="report" value="Нецензурное обращение">
                    <label for="report-type-4">Нецензурное обращение</label>
                </div>
                <div class="form-row">
                    <input type="radio" id="report-type-5" name="report" value="Товар продан">
                    <label for="report-type-5">Товар продан</label>
                </div>
                <div class="form-row">
                    <input type="radio" id="report-type-6" name="report" value="Неверное место сделки">
                    <label>Неверное место сделки</label>
                </div>
                <div class="form-row">
                    <script src="https://www.google.com/recaptcha/api.js?hl=ru" async defer></script>
                    <div class="recaptcha-container" data-callback="readyCaptchaReport"></div>
                </div>
                <input type="hidden" name="function" value="advert">
                <input type="hidden" name="idadvert" value="{$advert->getId()}">
                <input type="hidden" name="idfrom" value="{$user->getId()}">
                <input type="hidden" name="idto" value="{$advert->getAuthor()->getId()}">
                <button class="btn-submit" type="submit" disabled>Подтвержаю нарушение</button>
            </div>
        </form>
    {/if}
        {if !empty($adverts)}
            <div class="recently-products" style="overflow: hidden;">
                <div class="recently-products_title">Похожие объявления</div>
                <div class="owl-carousel recently__gallery">
                    {foreach from=$adverts item=$advert}
                        <div class="recently-products_item">
                            {include file='elements/advert/advert.tpl' withoutWrapper=true}
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
    </div>
</div>

{include file='elements/main/footer.tpl'}