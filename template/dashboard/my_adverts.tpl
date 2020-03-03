{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/get_categories.js"></script>
<script src="{$template}/js/functions/top4.js"></script>
<script src="{$template}/js/functions/update.js"></script>
<script src="{$template}/js/functions/show_more.js"></script>

{include file='elements/main/breadcrubms.tpl'}

<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                {if empty($_GET['user_id'])}
                    <div class="lk-top_menu">
                        <div class="row">
                            <div class="col-xs-4" id="advert-open">
                                <a href="/dashboard.php?page=my_adverts&type=open{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'open'} class="active"{/if}>
                            {if $notifications['adverts'] > 0}
                                <i></i>
                            {/if}                         
                            {t}Активные{/t} {$Users->getAdvertsCount($user->getId(), 2)}
                                </a>
                            </div>
                            <div class="col-xs-4" id="advert-moderation">
                                <a href="/dashboard.php?page=my_adverts&type=moderation{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'moderation'} class="active"{/if}>
                            {if $notifications['adverts-moderation'] > 0}
                                <i></i>
                            {/if} 
                            {t}На модерации{/t} {$Users->getAdvertsCount($user->getId(), 1)}
                                </a>
                            </div>
                            <div class="col-xs-4" id="advert-close">
                                <a href="/dashboard.php?page=my_adverts&type=close{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'close'} class="active"{/if}>
                            {if $notifications['adverts-close'] > 0}
                                <i></i>
                            {/if}                        
                            {t}Архив{/t} {$Users->getAdvertsCount($user->getId(), 3)}
                                </a>
                            </div>
                        </div>
                    </div>
                {/if}
                <div class="lk-border lk-block_products lk-myobj_open">
                    {if !empty($adverts)}
                        <div class="row items-append-here">
                            {foreach from=$adverts item=$advert}
                                <div class="col-xs-3">
                                <div class="product-item" data-advert_id="{$advert->getId()}">
                                    {$photos = $advert->GetPhotos()}
                                    <div class="product-item_image" style="background: url({$files_dir}{$photos[0]});">
                                        <a href="/advert.php?id={$advert->getId()}">
                                            <div class="product-item_photos">
                                                <i></i> <span>{count($photos)}</span>
                                            </div>
                                <!-- Добавлено: Сергей Показ места сделки в карточке товара -->                                            
                                            {if $advert->GetLocation()->getId() > 0 AND !empty($advert->getCity())}
                                            <div class="product-item_city">{$advert->getCity()}</div>
                                            {elseif $advert->GetLocation()->getId() > 0 AND $advert->GetLocation()->getName() != 'Весь МИР' AND empty($advert->getCity())}
                                            <div class="product-item_city">{$advert->GetLocation()->getName()}</div> 
                                            {else}           
                                            <div class="product-item_city">Передача через сеть</div>           
                                            {/if}
                                <!-- Добавлено: Сергей Показ места сделки в карточке товара -->                                            
                                            
                                            {if $advert->getSecureDeal() == 1}                                            
                                            <div class="product-item_safe"><img src="template/img/product-item-safe_icon.png" alt=""></div>
                                            {/if}
                                        </a>
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
                                {if empty($_GET['user_id'])}
                                    {include file='elements/advert/advert_admin.tpl'}
                                {/if}
                            </div>
                            {/foreach}
                        </div>

                        {if $type == 'open'}
                            {if $Users->getAdvertsCount($user->getId(), 2) > 16}
                                <div class="text-center">
                                    <form class="no-ajax show_more" style="margin-bottom: 30px;">
                                        <input type="hidden" name="type" value="adverts">
                                        <input type="hidden" name="page" value="1">
                                        {if empty($_GET['user_id'])}
                                            <input type="hidden" name="user_id" value="{$user->getId()}">
                                            <input type="hidden" name="style" value="admin">
                                        {else}
                                            <input type="hidden" name="user_id" value="{$_GET['user_id']}">
                                            <input type="hidden" name="style" value="normal">
                                        {/if}
                                        <button type="submit" class="lk-favourite_more">Показать еще</button>
                                    </form>
                                </div>
                            {/if}
                        {/if}

                        {if $type == 'moderation'}
                            {if $Users->getAdvertsCount($user->getId(), 1) > 16}
                                <div class="text-center">
                                    <form class="no-ajax show_more" style="margin-bottom: 30px;">
                                        <input type="hidden" name="type" value="adverts">
                                        <input type="hidden" name="page" value="1">
                                        {if empty($_GET['user_id'])}
                                            <input type="hidden" name="user_id" value="{$user->getId()}">
                                            <input type="hidden" name="style" value="admin">
                                        {else}
                                            <input type="hidden" name="user_id" value="{$_GET['user_id']}">
                                            <input type="hidden" name="style" value="normal">
                                        {/if}
                                        <button type="submit" class="lk-favourite_more">Показать еще</button>
                                    </form>
                                </div>
                            {/if}
                        {/if}

                        {if $type == 'close'}
                            {if $Users->getAdvertsCount($user->getId(), 3) > 16}
                                <div class="text-center">
                                    <form class="no-ajax show_more" style="margin-bottom: 30px;">
                                        <input type="hidden" name="type" value="adverts">
                                        <input type="hidden" name="page" value="1">
                                        {if empty($_GET['user_id'])}
                                            <input type="hidden" name="user_id" value="{$user->getId()}">
                                            <input type="hidden" name="style" value="admin">
                                        {else}
                                            <input type="hidden" name="user_id" value="{$_GET['user_id']}">
                                            <input type="hidden" name="style" value="normal">
                                        {/if}
                                        <button type="submit" class="lk-favourite_more">Показать еще</button>
                                    </form>
                                </div>
                            {/if}
                        {/if}                                        

                    {else}
                        <h3 style="display: block; margin: 0px auto 10px; text-align: center;">Нет объявлений</h3>
                    {/if}
                {if empty($_GET['user_id'])}
                    <form id="update" method="post" class="lk-myobj_open-update mfp-hide">
                        <div class="title text-center">Обновить</div>
                        <div class="form-row">
                            <label>Раздел</label>
                            <span class="section"></span>
                        </div>
                        <div class="form-row">
                            <label>Категория</label>
                            <span class="category"></span>
                        </div>
                        <div class="form-row">
                            <label>Подкатегория</label>
                            <span class="subcategory"></span>
                        </div>
                        <div class="form-row capcha text-center">
                            <div class="recaptcha-container" data-callback="readyCaptchaUpdate"></div>
                        </div>
                        <div class="form-row">                          
                            <button href="#per" class="btn-submit open-forms update">Совершить перевод</button>
                        </div>
                    </form>

                    <form id="top4" method="post" class="lk-myobj_open-update mfp-hide">
                        <div class="title text-center">Разместить в ТОП</div>
                        <div class="form-row">
                            <label>Раздел</label>
                            <select name="section" id="section" class="required-field filter_select_objects selectSomething nosearch section_select" data-target="#category" data-type="categories">
                                <option value="" selected>Не выбрано</option>
                                {foreach from=$sections item=$section}
                                    <option value="{$section->getId()}"{if $section->getId() == $advert->getSection()->getId()} selected{/if}>{$section->getName()}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-row">
                            <label>Категория</label>
                            <select name="category" class="required-field filter_select_objects selectSomething category_select" id="category" data-target="#subcategory" data-type="subcategories" disabled>
                                <option value="" disabled selected>Не выбрано</option>
                                {foreach from=$all_categories_top item=$category}
                                    <<option value="{$category->getId()}"{if $category->getId() == $advert->getCategory()->getId()} selected{/if}>{$category->getName()}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-row">
                            <label>Подкатегория</label>
                            <select name="subcategory" class="required-field filter_select_objects selectSomething" id="subcategory" disabled>
                                <option value="" disabled selected>Не выбрано</option>
                                {foreach from=$all_subcategories_top item=$subcategory}
                                    <<option value="{$subcategory->getId()}"{if $subcategory->getId() == $advert->getSubcategory()->getId()} selected{/if}>{$subcategory->getName()}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-row">
                            <label>Кол-во дней</label>
                            <select name="nm_day">
                                <option value="0" disabled selected>Не выбрано</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="15">15</option>
                                <option value="30">30</option>
                            </select>
                        </div>
                        <div class="form-row">
                            <label>Выбор страницы</label>
                            <select name="str">
                                <option value="0" disabled selected>Не выбрано</option>
                                <option value="1">Главная Весь Мир</option>
                                <option value="2">Главная по стране</option>
                                <option value="3">Главная по городу</option>
                            </select>
                        </div>
                        <div class="form-row">
                            <label>Место в топе</label>
                            <select name="top4" style="text-align: center;">
                                <option value="0" disabled selected>Не выбрано</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                        <div class="form-row capcha text-center">
                            <div class="recaptcha-container" data-callback="readyCaptchaTop4"></div>
                        </div>
                        <div class="form-row">                        
                        <input type="hidden" name="top_world_id" value="{$country->GetCountryIdByName('Весь МИР')}">
                        <input type="hidden" name="top_country_id" value="">
                        <input type="hidden" name="top_city_id" value="">
                        <input type="hidden" name="top_section_id" value="">
                        <input type="hidden" name="top_category_id" value="">
                        <input type="hidden" name="top_subcategory_id" value="">
                        <input type="hidden" name="top_days_num" value="">
                        <input type="hidden" name="top_page_type" value=""> 
                        <input type="hidden" name="top_position_num" value="">
                        <input type="hidden" name="top_calculate_price" value="">
                            <button href="#per" class="btn-submit open-forms top">Совершить перевод</button>
                        </div>
                    </form>


                    <form id="per" method="POST" action="/ajax/top4/clients_data_top4_to_db.php" class="mfp-hide per-popup no-ajax">
                        <input type="hidden" name="top_user_id" value="{$user->getId()}">
                        <input type="hidden" name="top_advert_id" value="">
                        <input type="hidden" name="top_client_country_id" value="">
                        <input type="hidden" name="top_client_city_id" value="">
                        <input type="hidden" name="top_client_section_id" value="">
                        <input type="hidden" name="top_client_category_id" value="">
                        <input type="hidden" name="top_client_subcategory_id" value="">
                        <input type="hidden" name="top_client_days_num" value="">
                        <input type="hidden" name="top_client_page_type" value=""> 
                        <input type="hidden" name="top_client_position_num" value="">
                        <input type="hidden" name="top_calculate_price" value="">
                        <input type="hidden" name="clients_wallets_top4_prices" value=""> 
                        
                        <input type="hidden" name="clients_wallet_address" value="">
                        <input type="hidden" name="admins_wallet_address" value="">
                        <input type="hidden" name="clients_pay_sum" value="">
                        <input type="hidden" name="clients_crypto_code" value="">
                        
                        <div class="row">
                            <div class="col-xs-8">
                                <div class="tab-content">
                                    <div id="panel0" class="tab-pane fade in active text-center secure-deal">
                                        <div class="per-popup_text">Выберите криптовалюту для совершения<br> перевода</div>
                                        <div class="per-popup_logo">
                                            <img src="{$template}/img/head-logo.png" alt="">
                                        </div>
                                        <div class="per-popup_text">Выбрать можно только криптовалюту из<br>
                                            внесенных в Ваш <a href="/dashboard.php?page=wallets">Адрес кошельков</a>
                                        </div>
                                    </div>
                                    <div id="panel1" class="tab-pane fade tab-main secure-deal">
                                        <div class="per-popup_t text-center">Оплата за размещение в ТОП</div>
                                        <div class="form-row">
                                            <div class="per-popup_left clearfix">
                                                <div class="per-popup_left-av" style="background-color: #{$user->getColor()}">
                                                    <img src="/files/{$user->getAvatar()}" alt="">
                                                </div>
                                                <div class="per-popup_left-text">
                                                    <span>Покупатель</span>
                                                    <div>{$user->getLogin()}</div>
                                                </div>
                                            </div>
                                            <div class="per-popup_right">
                                                <label>Адрес кошелька Покупателя</label>
                                                <div>
                                                    <input type="text" name="address_purse" readonly value="" class="buyer_wallet">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="per-popup_left clearfix">
                                                
                                                    <div class="secure-deal">
                                                        <img src="{$template}/img/product-item-safe_icon.png" alt="">
                                                    </div>
                                                
                                                <div class="per-popup_left-text">
                                                    
                                                        <div class="secure-deal-text">Безопасная сделка</div>
                                                    
                                                </div>
                                            </div>
                                            <div class="per-popup_right">
                                                <label>Адрес кошелька Администрации</label>
                                                
                                                <div class="per-popup_right-input">
                                                    <input id="text1" type="text" name="address_purse" readonly value="" class="service_wallet">
                                                    <a href="#" class="save" id="save">Копировать</a>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="per-popup_left clearfix"></div>
                                            <div class="per-popup_right">
                                                <div class="recaptcha-container" data-callback="readyCaptchaTop4Client"></div>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="per-popup_left clearfix"></div>
                                            <div class="per-popup_right">
                                            <button class="btn-submit pay_is_over secure-deal no-ajax" type="submit" disabled>Перевод совершен? Да!</button>
                                            </div>
                                        </div>
                                        <div class="per-popup_info">
                                            <ul>
                                                <li>Не совершайте перевод за услуги, недвижимость, товары и авто до получения подтверждения о его наличии и готовности к передаче от "Продавца"</li>
                                                <li>Не забывайте про комиссию майнеров</li>
                                                <li>При совершении перевода Вы подтверждаете, что согласны с условиями <a href="#">сервиса Безопасной сделкой</a> и <a href="#">Арбитража Безопасной сделки</a>, <a href="#">Правилами</a> и <a href="#">Политикой</a> сайта ZaCrypto</li>
                                                <li>В QR-коде зафиксирован адрес кошелька <a href="#">Безопасной сделки</a> и сумма для перевода</li>
                                                <li>После успешного перевода нажмите на кнопку "Перевод совершен"</li> 
                                            </ul>
                                            <img src="/" class="qr_code">
                                            <div style="clear: both;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-4">
                                <ul class="nav nav-tabs">
                                    {foreach from=$user->getWallets() item=$wallet key=$type}
                                            <li>
                                                <a data-toggle="tab" href="#panel1" data-seller-wallet="NO SELLER WALLET" data-service-wallet="{$cryptos->GetCryptoByCode($type)->getWalletsAddress()}" data-type-deal="1" data-buyer-wallet="{$wallet}" data-type="{mb_strtoupper($type)}" class="select-payment-wallet secure-deal">
                                                    <div class="nav-val">
                                                        <img src="{$template}/img/{mb_strtolower($type)}.png" alt="">
                                                        <span>{$type}</span>
                                                    </div>
                                                    <span class="calculate_price_top" style="font-size: 44px;"></span>
                                                </a>
                                            </li>                                                      
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                    </form>


                    <form id="in_archive" class="arch-popup mfp-hide" action="/ajax/adverts/add_to_archive.php" method="POST">
                        <input type="hidden" name="advert_id">
                        <input type="hidden" name="type">
                        <div class="title text-center">
                            {if !empty($_GET['type']) AND $_GET['type'] == 'close'}
                                Убрать из архива?
                            {else}
                                Отправить в архив?
                            {/if}
                        </div>
                        <div class="form-row">
                            <input type="submit" name="in_archive" value="Да">
                        </div>
                        <div class="form-row">
                            <a href="#" class="arch-popup_close">Отмена</a>
                        </div>
                    </form>
                {/if}


                </div>
            </div>
        </div>
    </div>
</div>

{if empty($_GET['user_id'])}
    <script>
        $(function () {   

            $('.open-forms.archive').on('click', function () {
                let advert_id = $(this).data('advert_id');
                let type = $(this).data('type');

                $('#in_archive').find('input[name="advert_id"]').val(advert_id);
                $('#in_archive').find('input[name="type"]').val(type);
            });
        });
    </script>
{/if}

{include file='elements/main/footer.tpl'}