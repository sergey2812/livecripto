{include file='elements/main/header.tpl'}

{include file='elements/main/breadcrubms.tpl'}

{if empty($new_chat)}
    <script src="{$template}/js/dashboard/chat.js"></script>
{/if}

<script>   
    $(function()
        {

            $('div.href_div').on('click', function()
            {         
                let href_chat = $(this).data('link');

                if (href_chat !== null) location.href = href_chat;  

            });

            $(".chat-user").css("border", "1.25px solid #abb9cd");
               
        });
</script>

<script>   
    $(function()
        {
            $('#save').on('click', function() {
                var $tmp = $("<input>");
                $("body").append($tmp);
                $tmp.val($("#text1").val()).select();
                document.execCommand("copy");
                $tmp.remove();
alert('Скопировано!');                
            });
               
        });
</script>

<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                <div class="lk-top_menu">
                    <div class="row">
                        <div class="col-xs-4">
                            <span>Сообщения</span>
                        </div>

                        
                        <div class="col-xs-4 chattt-hidden">
                            <a href="/dashboard.php?page=chat&type=sell" {if empty($_GET['type']) OR $_GET['type'] == 'sell'}class="active"{/if}>
                                {$sellMessagesCount = $Users->getMessagesCount($user->getId(), 'sell')}
                                {if $sellMessagesCount > 0}<i></i>{/if}
                            Продажа {$Users->getSellsCount($user->getId(), '0,1,2,3,4,5,6,7,8')}                         
                            </a>
                        </div>
                        <div class="col-xs-4 chattt-hidden">
                            <a href="/dashboard.php?page=chat&type=buy" {if !empty($_GET['type']) AND $_GET['type'] == 'buy'}class="active"{/if} style="position: relative;left: -4px;">
                                            
                                {$buyMessagesCount = $Users->getMessagesCount($user->getId(), 'buy')}
                                {if $buyMessagesCount > 0}<i></i>{/if}
                            
                            Покупка {$Users->getBuyCount($user->getId(), '0,1,2,3,4,5,6,7,8')}
                            </a>
                        </div>

                    </div>
                </div>
                
                <div class="lk-chat">
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="chat-theme">
                            {if isset($chats)}
                                {foreach from=$chats item=$chat}
                                    {$to = $chat->GetTo()}
                                    {$from = $chat->getFrom()}
                                    {if $to->getId() != $user->getId()}
                                        {$chat_user = $to}
                                    {else}
                                        {$chat_user = $from}
                                    {/if}

                                    {$last_message = $chat->getMessages()}
                                    {$last_message = end($last_message)}

                                    {$advert = $chat->getAdvert()}
                            
                            
                                    <div class="chat-theme_item href_div {if !empty($_GET['chat_id']) AND $_GET['chat_id'] == $chat->getId()}active{/if}" data-link="/dashboard.php?page=chat&chat_id={$chat->getId()}&type={if $to->getId() != $user->getId()}buy{else}sell{/if}" data-chat-id="{$chat->getId()}">
                    
                                        <div class="chat-theme_item-head">
                                            
                                            <div class="chat-theme_item-title">{$advert->getName()}</div>
                                            
                                            <div class="chat-theme_item-date">
                                                {if !empty($last_message)}
                                                    {$Chats->getBeautifulDate($last_message->getDate())}
                                                {/if}
                                            </div>
                                        </div>
                                        
                                        <div class="chat-theme_item-info">
                                            <div class="chat-theme_item-avatar"  style="background-color: #{$chat_user->getColor()}">
                                                <img src="/files/{$chat_user->getAvatar()}">
                                            </div>
                                            <div class="chat-theme_item-name">{$chat_user->getLogin()}</div>
                                            {if !empty($last_message)}
                                                {if $chat->hasUnread($user->getId())}
                                                    <div class="chat-theme_item-att"></div>
                                                {/if}
                                            {/if}
                                        </div>
                                        <div class="chat-theme_item-text">
                                            {if !empty($last_message)}
                                                {urldecode($last_message->getText())}
                                            {/if}
                                        </div>
                                    </div>
                                {foreachelse}
                                {/foreach}
                            {/if}
                            </div>
                        </div>
               
                        {if !empty($chat) && $chat_fierst != 0}
                            <div id="chat-hidden" class="col-xs-8">
                                {$to = $chat->GetTo()}
                                {$from = $chat->getFrom()}
                                {if $to->getId() != $user->getId()}
                                    {$chatUser = $to}
                                {else}
                                    {$chatUser = $from}
                                {/if}

                                {$advert = $chat->getAdvert()}

                                <div class="chat-user">

                                    {if $chat->getId()}
                                    <a href="#report" class="open-forms chat-report" data-deal-id="{$chat->getId()}" data-user-to="{$from->getId()}" data-user-from="{$to->getId()}"></a>    
                                    {/if}
                                    <div class="chat-user_left text-center">
                                        
                                        <div class="chat-user_title">
                                            {if $user->getId() == $to->getId()}
                                                Покупатель
                                            {else}
                                                Продавец
                                            {/if}
                                        </div>
                                        <div class="chat-user_stars">
                                            {include file='elements/advert/rating.tpl' rating=$chatUser->getRating()}
                                        </div>
                                        
                            <!-- Часть кода для получения цвета фона аватара в чате -->
                                    <div class="chat-user_av" style="background-color: #{$chatUser->getColor()}">
                                        <img src="/files/{$chatUser->getAvatar()}" alt="">
                                    </div>
                                        
                                        <div class="chat-user_name">
                                            <a href="http://liveincrypto.com/dashboard.php?page=my_adverts&user_id={$chatUser->getId()}">
                                                {$chatUser->getLogin()}
                                            </a>
                                        </div>
                                         
                                        <div class="chat-user_score">
                                            <div>
                                                <i class="icon-like"></i>
                                                <span>{$chatUser->getLikes()}</span>
                                            </div>
                                            <div>
                                                <i class="icon-dislike"></i>
                                                <span>{$chatUser->getDislikes()}</span>
                                            </div>
                                            <div>
                                                <a href="#chat-reviews" class="open-forms">Отзывы</a>
{*                                                <a href="#">Отзывы</a>*}
                                            </div>
                                        </div>

                                        {include file='elements/user_reviews.tpl' user=$chatUser id='chat-reviews'}

{*                                      <div class="chat-user_att">
                                            <div class="chat-user_att-button">Перевод совершен</div>
                                            <div>
                                                <i class="form-info" data-toggleAll="tooltip" title="{$advert->getName()}"></i>
                                            </div>
                                        </div>*}
                                        <div class="chat-user_att">
                                            {if $user->getId() != $to->getId()}
                                                {if $chat->isAccept() && $chat->getDeal() == null}
                                                    {if !empty($user->getWallets())}

                                                        {$hasWallets = false}
                                                        {$sellerWallets = $chat->getTo()->getWallets()}
                                                        {$advertPrices = $chat->getAdvert()->getPrices()}
                                                        {foreach from=$user->getWallets() item=$wallet key=$type}
                                                            {if (!empty($sellerWallets[$type]) OR $chat->getAdvert()->isSecureDeal()) AND !empty($advertPrices[mb_strtoupper($type)])}
                                                                {$hasWallets = true}
                                                                {break}
                                                            {/if}
                                                        {/foreach}
                                                        {if $hasWallets}
                                                            <a href="#per" class="chat-user_att-button blue open-forms">Совершить перевод</a>
                                                        {else}
                                                            <a href="#" class="chat-user_att-button blue" disabled="">У продавца(покупателя) не указан кошелёк для перевода</a>
                                                        {/if}
                                                    {else}
                                                        <a href="/dashboard.php?page=wallets" class="chat-user_att-button blue">Добавьте кошельки, чтобы совершить сделку</a>
                                                    {/if}
                                                    <div class="form-info_container">
                                                        <i class="form-info" data-toggleAll="tooltip" title="<br> <p>Для приобретения товара или получения услуги - совершите перевод на кошелек Продавца в удобной для Вас криптовалюте</p>"></i>
                                                    </div>
                    
    <form method="post" action="/ajax/chat/pay.php" id="per" class="mfp-hide per-popup">
        <input type="hidden" name="chat_id" value="{$chat->getId()}">
        <input type="hidden" name="to_wallet" value="">
        <input type="hidden" name="seller_wallet" value="">
        <input type="hidden" name="from_wallet" value="">
        <input type="hidden" name="type" value="">
        <div class="row">
            <div class="col-xs-8">
                <div class="tab-content">
                    <div id="panel0" class="tab-pane fade in active text-center {if $chat->getAdvert()->isSecureDeal()}secure-deal{/if}">
                        <div class="per-popup_text">
                            Выберите криптовалюту для совершения<br> перевода
                        </div>
                        <div class="per-popup_logo">
                            <img src="{$template}/img/head-logo.png" alt="">
                        </div>
                        <div class="per-popup_text">
                            Выбрать можно только криптовалюту из<br>
                            внесенных в Ваш <a href="/dashboard.php?page=wallets">Адрес кошельков</a>
                        </div>
                    </div>
                    <div id="panel1" class="tab-pane fade tab-main {if $chat->getAdvert()->isSecureDeal()}secure-deal{/if}">
                        <div class="per-popup_t text-center">
                            {if $chat->getAdvert()->isSecureDeal()}
                                Безопасная сделка
                            {else}
                                Прямая сделка
                            {/if}
                        </div>
                        <div class="form-row">
                            <div class="per-popup_left clearfix">
                                <div class="per-popup_left-av" style="background-color: #{$chat->getFrom()->getColor()}">
                                    <img src="/files/{$chat->getFrom()->getAvatar()}" alt="">
                                </div>
                                <div class="per-popup_left-text">
                                    <span>Покупатель</span>
                                    <div>{$chat->getFrom()->getLogin()}</div>
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
                                {if $chat->getAdvert()->isSecureDeal()}
                                    <div class="secure-deal">
                                        <img src="{$template}/img/product-item-safe_icon.png" alt="">
                                    </div>
                                {else}
                                    <div class="per-popup_left-av" style="background-color: #{$chat->getTo()->getColor()}">
                                        <img src="/files/{$chat->getTo()->getAvatar()}" alt="">
                                    </div>
                                {/if}
                                <div class="per-popup_left-text">
                                    {if $chat->getAdvert()->isSecureDeal()}
                                        <div class="secure-deal-text">Безопасная сделка</div>
                                    {else}
                                        <span>Продавец</span>
                                        <div>{$chat->getTo()->getLogin()}</div>
                                    {/if}
                                </div>
                            </div>
                            <div class="per-popup_right">
                                <label>
                                    {if $chat->getAdvert()->isSecureDeal()}
                                        Адрес кошелька Безопасной сделки
                                    {else}
                                        Адрес кошелька Продавца
                                    {/if}
                                </label>
                                {if $chat->getAdvert()->isSecureDeal()}
                                <div class="per-popup_right-input">
                                    <input id="text1" type="text" name="address_purse" readonly value="" class="service_wallet">
                                    <a href="#" class="save" id="save">Копировать</a>
                                </div>
                                {else}
                                <div class="per-popup_right-input">
                                    <input id="text1" type="text" name="address_purse" readonly value="" class="seller_wallet">
                                    <a href="#" class="save" id="save">Копировать</a>
                                </div>
                                {/if}
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="per-popup_left clearfix"></div>
                            <div class="per-popup_right">
                                <div class="recaptcha-container" data-callback="readyCaptchaChatAccept"></div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="per-popup_left clearfix"></div>
                            <div class="per-popup_right">
                                <button class="btn-submit pay_is_over{if $chat->getAdvert()->isSecureDeal()} secure-deal{/if}" type="submit" data-chat-id="{$chat->getId()}" disabled>Перевод совершен? Да!</button>
                            </div>
                        </div>
                        <div class="per-popup_info">
                            <ul>
                                {if $chat->getAdvert()->isSecureDeal()}
                                    <li>Не совершайте перевод за услуги, недвижимость, товары и авто до получения подтверждения о его наличии и готовности к передаче от "Продавца"</li>
                                    <li>Не забывайте про комиссию майнеров</li>
                                    <li>При совершении перевода Вы подтверждаете, что согласны с условиями <a href="#">сервиса Безопасной сделкой</a> и <a href="#">Арбитража Безопасной сделки</a>, <a href="#">Правилами</a> и <a href="#">Политикой</a> сайта ZaCrypto</li>
                                    <li>В QR-коде зафиксирован адрес кошелька <a href="#">Безопасной сделки</a> и сумма для перевода</li>
                                    <li>После успешного перевода нажмите на кнопку "Перевод совершен"</li>
                                {else}
                                    <li>Не совершайте перевод за услуги, недвижимость, товары и авто до получения подтверждения о его наличии и готовности к передаче от "Продавца"</li>
                                    <li>Не забывайте про комиссию майнеров</li>
                                    <li>При совершении перевода Вы подтверждаете, что согласны с <a href="#">Правилами</a> и <a href="#">Политикой</a> сайта ZaCrypto</li>
                                    <li>В QR-коде зафиксирован адрес кошелька Продавца и сумма для перевода</li>
                                    <li>После успешного перевода нажмите на кнопку "Перевод совершен"</li>
                                {/if}
                            </ul>
                            <img src="/" class="qr_code">
                            <div style="clear: both;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-4">
                <ul class="nav nav-tabs">
                    {$sellerWallets = $chat->getTo()->getWallets()}
                    {$advertPrices = $chat->getAdvert()->getPrices()}


                    {foreach from=$user->getWallets() item=$wallet key=$type}
    
                    {if (!empty($sellerWallets[$type]) OR $chat->getAdvert()->isSecureDeal()) AND !empty($advertPrices[mb_strtoupper($type)])}
                        
                            <li>
                                <a data-toggle="tab" href="#panel1" data-seller-wallet="{if (!empty($sellerWallets[$type]))}{$sellerWallets[$type]}{else}Нет кошелька с такой криптой{/if}" data-service-wallet="{$cryptos->GetCryptoByCode($type)->getWalletsAddress()}" data-type-deal="{if $chat->getAdvert()->isSecureDeal()}1{else}0{/if}" data-amount="{$advertPrices[mb_strtoupper($type)]}" data-buyer-wallet="{$wallet}" data-type="{$type}" class="select-payment-wallet {if $chat->getAdvert()->isSecureDeal()}secure-deal{/if}">
                                    <div class="nav-val">
                                        <img src="{$template}/img/{mb_strtolower($type)}.png" alt="">
                                        <span>{$type}</span>
                                    </div>
                                    {$advertPrices[mb_strtoupper($type)]}
                                </a>
                            </li>                                                      
                        {/if}

                    {/foreach}
                </ul>
            </div>
        </div>
    </form>
                                                {elseif $chat->getDeal() != null && $chat->getDeal()->getStatus() < 1}
                                                    <a href="#" class="chat-user_att-button" disabled="">
                                                        Перевод совершён
                                                    </a>
                                                {elseif $chat->getDeal() != null && $chat->getDeal()->getStatus() == 1}
                                                    <a href="#" class="chat-user_att-button" disabled="">
                                                        Перевод подтверждён
                                                    </a>
                                                    <div class="form-info_container">
                                                        <i class="form-info" data-toggleAll="tooltip" title="<br> <p>Перевод криптовалюты на Ваш адрес подтвержден</p>"></i>
                                                    </div>
                                                {elseif $chat->getDeal() != null && $chat->getDeal()->getStatus() == 2}
                                                    <a href="#" class="chat-user_att-button" disabled="">
                                                        Сделка в процессе
                                                    </a>
                                                    <div class="form-info_container">
                                                        <i class="form-info" data-toggleAll="tooltip" title="<br> <p>Отправление товара в Ваш адрес подтверждено</p>"></i>
                                                    </div>
                                               {elseif $chat->getDeal() != null && $chat->getDeal()->getStatus() == 3}
                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                       Сделка в процессе 
                                                    </a>
                    <!-- Сделка завершена для покупателя -->                                                     
                                                {elseif $chat->getDeal() != null && $chat->getDeal()->getStatus() >= 4}
                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                       Сделка завершена 
                                                    </a>     
                                                {/if}


                                            {else}
 
<!-- Сделка завершена для продавца -->
                                                {if $chat->getDeal() != null}
{*                                                   {if $chat->getDeal()->getStatus() < 1 && $chat->getDeal()->getSecureDeal() == 0}
                                                        
                                                            <form action="/ajax/chat/get_pay.php" method="POST">
                                                                <input type="hidden" name="chat_id" value="{$chat->getId()}">
                                                             <button class="chat-user_att-button" type="submit">
                                                                    Перевод получен
                                                                </button> 
                                                            </form>
                                                    {/if} *}
                                                    {if $chat->getDeal()->getStatus() < 1 && $chat->getDeal()->getSecureDeal() == 1}
                                                            <a href="#" class="chat-user_att-button blue">Ожидаем получения перевода</a>
                                                    {/if}
                                                    {if $chat->getDeal()->getStatus() == 0 && $chat->getDeal()->getSecureDeal() == 0}

                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                        Подтвердить перевод
                                                    </a> 
                                                    {/if}
                                                    {if $chat->getDeal()->getStatus() == 1}

                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                        Отправить товар
                                                    </a> 
                                                    {/if}  
                                                    {if $chat->getDeal()->getStatus() > 1 && $chat->getDeal()->getStatus() < 4}

                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                        Сделка в процессе 
                                                    </a> 
                                                    {/if}
                                                    {if $chat->getDeal()->getStatus() >= 4}

                                                    <a href="#" class="chat-user_att-button blue" disabled="">
                                                        Сделка завершена 
                                                    </a> 
                                                    {/if}

                                                {else}
                                                    <a href="#" class="chat-user_att-button red accept-chat" data-chat-id="{$chat->getId()}" data-chat-mode="{if $chat->isAccept()}Запретить перевод{else}Разрешить перевод{/if}">
                                                        {if $chat->isAccept()}
                                                            Запретить перевод
                                                        {else}
                                                            Разрешить перевод
                                                        {/if}
                                                    </a>
                                                    <div class="form-info_container">
                                                        <i class="form-info" data-toggleAll="tooltip" title="<br> <p>Если Вы готовы продать товар или услугу данному пользователю, разрешите ему сделать перевод на Ваш кошелек</p>"></i>
                                                    </div>
                                                {/if} 
                                            {/if}
                                        </div>
                                    </div>
                                
                                    <div class="chat-user_right">
                                        <div class="product-item">
                                            {$photos = $advert->GetPhotos()}
                                            <div class="product-item_image" style="background: url({$files_dir}{$photos[0]});">
                                                <div class="product-item_photos">
                                                    <i></i> <span>{count($photos)}</span>
                                                </div>
                                                {if !empty($advert->getLocationName())}
                                                     <div class="product-item_city">{$advert->getLocationName()}</div>
                                                {/if}
                                                {if $advert->getSecureDeal()}
                                                    <div class="product-item_safe"><img src="{$template}/img/product-item-safe_icon.png" alt=""></div>
                                                {/if}

                                                {if $user->getId() != $to->getId()}
                                                <div class="product-item_fav add_to_favorites" data-advert_id="{$advert->getId()}">
                                                    <i {if !empty($user) AND in_array($advert->getId(), $user->getFavorites())}class="filled"{/if}></i>
                                                </div>
                                                {/if}

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
                                    </div>
                                
                                    <div class="clearfix"></div>
                                </div>
                                <div class="chat-message">
                                    <div class="chat-message_body">
                                    </div>
                                    <div class="chat-message_foot">
                                        <textarea name="message" class="emoji twemoji-textarea" id="message_text_area"></textarea>
                                        <button class="send_message" data-chat_id="{$chat->getId()}" data-color_to="{if $user->getId() == $to->getId()}{$to->getColor()}{else}{$from->getColor()}{/if}" data-color_from="{if $user->getId() == $to->getId()}{$from->getColor()}{else}{$to->getColor()}{/if}">

                                            <img src="{$template}/img/chat-button.svg" alt="">
                                        </button>

                                            {if $user->getId() == $to->getId()}
                                                Покупатель
                                            {else}
                                                Продавец
                                            {/if}
                                    </div>
                                </div>
                            </div>
                        {/if}                                          
                   
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

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
        <input type="hidden" name="function" value="deal">
        
        <input type="hidden" name="iddeal" value="{if $chat->getId()}{$chat->getId()}{/if}">
        
        <input type="hidden" name="idfrom" value="{if $user->getId() == $to->getId()}{$to->getId()}{else}{$from->getId()}{/if}">
        <input type="hidden" name="idto" value="{if $user->getId() == $to->getId()}{$from->getId()}{else}{$to->getId()}{/if}">
        <button class="btn-submit" type="submit" disabled>Подтвержаю нарушение</button>
    </div>
</form>

<script src="{$template}/js/dashboard/update_wallets.js"></script>


{include file='elements/main/footer.tpl'}
