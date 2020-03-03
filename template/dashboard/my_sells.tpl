
{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/adverts_dashboard_status_update.js"></script>
<script src="{$template}/js/dashboard/advert_feedback.js"></script>
<script>   
    $(function payOperation()
        {
            $('.input-pay-resive-yes').on('click', function () 
                {
                    if ($('.assent-pay-resive').hasClass('pay_yes'))
                        {
                            $('.assent-pay-resive').removeClass('pay_yes');                  
                        }
                    else
                        {
                            $('.assent-pay-resive').addClass('pay_yes');
                            $('.assent-pay-resive').removeClass('pay_no');                  
                        }  
                });

            $('.input-pay-resive-no').on('click', function () 
                {
                    if ($('.assent-pay-resive').hasClass('pay_no'))
                        {
                            $('.assent-pay-resive').removeClass('pay_no');                   
                        }
                    else
                        {
                            $('.assent-pay-resive').addClass('pay_no');
                            $('.assent-pay-resive').removeClass('pay_yes');                  
                        }                   
                });

            $('.assent-pay-resive').on('click', function () 
                {
                    let chatId = $('.assent-pay-resive').data('chat-id');

                    let text = "";

                    if ($('.assent-pay-resive').hasClass('pay_yes'))
                        {
                            text = "Перевод ПОЛУЧЕН. Ожидайте отправки товара!";
                            $('.assent-pay-resive').removeClass('pay_yes');                 
                        }

                    if ($('.assent-pay-resive').hasClass('pay_no'))
                        {
                            text = "Перевод НЕ ПОЛУЧЕН. Давайте проверим причину с обеих сторон!";
                            $('.assent-pay-resive').removeClass('pay_no');                  
                        }                                                    

                        $.ajax({
                                url: '/ajax/chat/send_message.php',
                                type: 'POST',
                                dataType: 'json',
                                data: { chat_id: chatId, message: text },
                            })
                        .done(function() {
                                console.log('sending message', text);        
                            })
                        .fail(function() {
                                console.log("error");
                            })
                        .always(function(data) {
                                console.log(data);
                            });                   
                });

        });
</script>

<script>   
    $(function productOperation()
        {
            $('.input-product-send-yes').on('click', function () 
                {
                    if ($('.assent-product-send').hasClass('product_yes'))
                        {
                            $('.assent-product-send').removeClass('product_yes');                  
                        }
                    else
                        {
                            $('.assent-product-send').addClass('product_yes');
                            $('.assent-product-send').removeClass('product_no');                  
                        }  
                });

            $('.input-product-send-no').on('click', function () 
                {
                    if ($('.assent-product-send').hasClass('product_no'))
                        {
                            $('.assent-product-send').removeClass('product_no');                   
                        }
                    else
                        {
                            $('.assent-product-send').addClass('product_no');
                            $('.assent-product-send').removeClass('product_yes');                  
                        }                   
                });

            $('.assent-product-send').on('click', function () 
                {
                    let chatId = $('.assent-product-send').data('chat-id');

                    let text = "";

                    if ($('.assent-product-send').hasClass('product_yes'))
                        {
                            text = "Товар отправлен. Подтвердите получение!";
                            $('.assent-product-send').removeClass('product_yes');                  
                        }

                    if ($('.assent-product-send').hasClass('product_no'))
                        {
                            text = "Товар НЕ ОТПРАВЛЕН. Причину выясню, и сообщу позже!";
                            $('.assent-product-send').removeClass('product_no');                   
                        }                                                    

                        $.ajax({
                                url: '/ajax/chat/send_message.php',
                                type: 'POST',
                                dataType: 'json',
                                data: { chat_id: chatId, message: text },
                            })
                        .done(function() {
                                console.log('sending message', text);        
                            })
                        .fail(function() {
                                console.log("error");
                            })
                        .always(function(data) {
                                console.log(data);
                            });                   
                });

        });
</script>


{include file='elements/main/breadcrubms.tpl'}




<form id="review" class="add-review mfp-hide" action="/ajax/reviews/send.php" method="POST"></form>

<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                {if empty($_GET['user_id'])}
                    <div class="lk-top_menu">
                        <div class="row">
                            <div class="col-xs-4">
                                <a href="/dashboard.php?page=my_sells&type=moderation{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'moderation'} class="active"{/if}>
                            {if $notifications['sells-moderation'] > 0}
                                <i></i>
                            {/if}
                                     На проверке {$Users->getSellsCount($user->getId(), '0')}
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a href="/dashboard.php?page=my_sells&type=open{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'open'} class="active"{/if}>
                            {if $notifications['sells-open'] > 0}
                                <i></i>
                            {/if} 
                                    Открытые {$Users->getSellsCount($user->getId(), '1,2,3')}
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a href="/dashboard.php?page=my_sells&type=close{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'close'} class="active"{/if}>
                            {if $notifications['sells-close'] > 0}
                                <i></i>
                            {/if}                               
                                    Закрытые {$Users->getSellsCount($user->getId(), '4,6,7,8')}
                                </a>
                            </div>
                        </div>
                    </div>
                {/if}
                {if !empty($deals)}
                    {if empty($_GET['user_id'])}
                        {foreach from=$deals item=$deal}
                            {$advert = $deal->getAdvert()}
                            {$seller = $advert->getAuthor()}
                            {$buyer = $deal->getBuyer()}
                           
                            <div class="lk-p-close lk-border">
                                <div class="row">
                                    {include file='elements/advert/advert.tpl'}
                                    <div class="col-xs-9">
                                        <div class="llk-p-close_row llk-p-close_row-width">
                                            <div>Покупатель:</div>
                                            <div><a href="/dashboard.php?page=my_adverts&user_id={$buyer->getId()}">{$buyer->getLogin()}</a></div>
                                        </div>
                                        <div class="llk-p-close_row llk-p-close_row-width">
                                            <div>Номер кошелька покупателя:</div>
                                            <div class="llk-p-close_row__wallet">{$deal->getBuyerWallet()}</div>
                                        </div>
                                        <div class="llk-p-close_row llk-p-close_row-width">
                                            <div>Сумма перевода:</div>
                                            <div class="llk-p-close_purse">
                                                <div>
                                                    <img src="{$template}/img/{$deal->getBuyerType()}.png" alt="">
                                                    <span>{$deal->getBuyerType()}</span>
                                                </div>
                                                <div>{$deal->getPrice()}</div>
                                            </div>
                                            <div class="lk-p-on_chat">
                                                <a href="/dashboard.php?page=chat&chat_id={$deal->getChat()}"><i></i>Чат по товару</a>
                                            </div>
                                        </div>
                                        {if $deal->getSecureDeal() == 1}
                                            <div class="llk-p-close_row llk-p-close_row-width">
                                                <div>Время перевода:</div>
                                                <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                            </div>
                                            <div class="llk-p-close_row llk-p-close_row-width">
                                                <div>Безопасная сделка:</div>
                                                {if $deal->getStatus() == 0}
                                                    <div class="llk-p-open_moderation">На проверке</div>
                                                {elseif $deal->getStatus() >= 1}
                                                    <div class="paid">
                                                        ПЕРЕВОД ПОДТВЕРЖДЕН АДМИНИСТРАЦИЕЙ
                                                    </div>
                                                {/if}
                                            </div>
                                        {else}
                                            {if $deal->getStatus() == 0}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Время перевода:</div>
                                                    <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                                    <div class="clearfix" style="display: block; margin-bottom: 0.5em; margin-top: 0.2em;"></div>                                         
                                                    <div>Перевод получен?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                                                    <div>
                                                        <form class="lk-p-close_get" action="/ajax/chat/get_pay.php" method="POST">
                                                            <input type="hidden" name="chat_id" value="{$deal->getChat()}">
                                                            <div>
                                                                <input type="radio" name="product_get" value="Да" data-status="1" class="input-pay-resive-yes" onclick="payOperation()" data-chat-id="{$deal->getChat()}">
                                                                <label>Да</label>
                                                            </div>
                                                            <div>
                                                                <input type="radio" name="product_get" value="Нет" data-status="0" class="input-pay-resive-no" onclick="payOperation()" data-chat-id="{$deal->getChat()}">
                                                                <label>Нет</label>
                                                            </div>
                                                            <div>
                                                                <button class="assent-pay-resive" data-chat-id="{$deal->getChat()}" onclick="payOperation()" disabled>Подтвердить</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            {/if}
                                            {if !empty($deal->getPayDate()) && $deal->getStatus() != 0 && $deal->getStatus() < 5}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Время перевода:</div>
                                                    <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                                    <div class="paid">
                                                        ПЕРЕВОД ПОДТВЕРЖДЁН
                                                    </div>
                                                    {if $deal->getStatus() >= 1 && $deal->getStatus() < 5}
                                                        <div class="paid">ПОЛУЧЕН</div>
                                                    {/if}
                                                </div>
                                            {/if}
                                            {if !empty($deal->getPayDate()) && $deal->getStatus() != 0 && $deal->getStatus() == 6}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Время перевода:</div>
                                                    <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                                    <div class="no-paid" style="color: red; margin-top: 0px;">
                                                        ПЕРЕВОД НЕ ПОДТВЕРЖДЁН
                                                    </div>
                                                </div>
                                            {/if}  
                                            {if !empty($deal->getPayDate()) && $deal->getStatus() != 0 && $deal->getStatus() == 7}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Время перевода:</div>
                                                    <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                                    <div class="paid">
                                                        ПЕРЕВОД ПОДТВЕРЖДЁН
                                                    </div>
                                                </div>
                                            {/if}    
                                            {if !empty($deal->getPayDate()) && $deal->getStatus() == 8}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Время перевода:</div>
                                                    <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                                    <div class="paid">
                                                        ПЕРЕВОД ПОДТВЕРЖДЁН
                                                    </div>
                                                    {if $deal->getStatus() >= 1 && $deal->getStatus() < 5}
                                                        <div class="paid">ПОЛУЧЕН</div>
                                                    {/if}
                                                </div>
                                            {/if} 
                                        {/if}                                                                                                                             
                                            {if $deal->getStatus() == 1}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Товар отправлен?</div>
                                                    <div>
                                                        <form class="lk-p-close_get" action="/ajax/chat/get_delivered.php" method="POST">
                                                            <input type="hidden" name="chat_id" value="{$deal->getChat()}">
                                                            <div>
                                                                <input type="radio" name="product_get" value="Да" data-status="1" class="input-product-send-yes" onclick="productOperation()" data-chat-id="{$deal->getChat()}">
                                                                <label>Да</label>
                                                            </div>
                                                            <div>
                                                                <input type="radio" name="product_get" value="Нет" data-status="0" class="input-product-send-no" onclick="productOperation()" data-chat-id="{$deal->getChat()}">
                                                                <label>Нет</label>
                                                            </div>
                                                            <div>
                                                                <button class="assent-product-send" data-chat-id="{$deal->getChat()}" onclick="productOperation()" disabled>Подтвердить</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            {/if}
                                            {if $deal->getStatus() >= 2 && $deal->getStatus() < 5 || $deal->getStatus() == 8}

                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    
                                                    <div>Статус товара:</div>
                                                    <div class="paid" style="margin-top: 3px;">
                                                        ТОВАР ОТПРАВЛЕН
                                                    </div>
                                                    {if $deal->getStatus() == 2}
                                                        <div class="clearfix" style="display: block; margin-bottom: 0.5em;"></div>
                                                        <div>Дальнейшие действия:&nbsp;&nbsp;&nbsp;</div>
                                                        <div class="paid" style="margin-bottom: 0.5em; margin-top: 11px;">Ожидаем подтверждения доставки</div>
                                                    {/if}                                                     
                                                    {if $deal->getStatus() >= 4 && $deal->getStatus() < 5}
                                                        <div class="paid">ПОЛУЧЕН</div>
                                                    {/if}
                                                    {if $deal->getStatus() == 8}
                                                        <div class="no-paid" style="color: red; margin-top: 2.5px;">НЕ ПОЛУЧЕН</div>
                                                    {/if}                                                    
                                                </div>
                                            {/if}
                                            {if $deal->getStatus() >= 6 && $deal->getStatus() < 8}
                                                <div class="llk-p-close_row llk-p-close_row-width">
                                                    <div>Статус товара:</div>
                                                    
                                                    <div class="no-paid" style="color: red; margin-top: 4.5px;">
                                                        ТОВАР НЕ ОТПРАВЛЕН
                                                    </div>
                                                </div>
                                            {/if}                                            
                                        
                                        {if $deal->getStatus() == 4 || $deal->getStatus() == 6 || $deal->getStatus() == 7 || $deal->getStatus() == 8}
                                            <div class="llk-p-close_row">
                                            {$reviewFrom = $Adverts->GetDealFeedback($deal->getId(), $buyer->getId())}
                                            {if empty($reviewFrom)}
                                                <a href="#review" class="lk-p-close_addreview open-forms add_review" data-deal_id="{$deal->getId()}">Оставить оценку и отзыв о покупателе</a>
                                            {else}
                                                <div class="llk-p-close_row llk-p-close_row-reviews">
                                                    <div>Оценка и отзыв продавца:</div>
                                                    <div class="lk-p-close_stars">
                                                        {include file='elements/advert/rating.tpl' rating=$reviewFrom['rating']}
                                                    </div>
                                                    <div>
                                                        <a href="#reviews2" class="lk-p-close_review open-forms show-comment seller" data-text="{htmlspecialchars($reviewFrom['text'])}" data-like="{$reviewFrom['like']}" data-rating="{$reviewFrom['rating']}" data-from="{$user->getLogin()}" data-to="{$buyer->getLogin()}" data-avatar="{$user->getAvatar()}" data-avatar-color="{$user->getColor()}">Отзыв</a>
                                                    </div>
                                                </div>
                                            {/if}
                    {include file='elements/user_reviews2.tpl' user=$buyer empty=false}
                        
                                            {$reviewTo = $Adverts->GetDealFeedback($deal->getId(), $user->getId())}
                                            {if empty($reviewTo)}
                                                <div class="lk-p-close_wait">Ожидание оценки и отзыва от покупателя</div>
                                            {else}
                                                <div class="llk-p-close_row llk-p-close_row-reviews">
                                                    <div>Оценка и отзыв покупателя:</div>
                                                    <div class="lk-p-close_stars">
                                                        {include file='elements/advert/rating.tpl' rating=$reviewTo['rating']}
                                                    </div>
                                                    <div>
                                                        <a href="#reviews" class="lk-p-close_review open-forms show-comment buyer" data-text="{htmlspecialchars($reviewTo['text'])}" data-like="{$reviewTo['like']}" data-rating="{$reviewTo['rating']}" data-to="{$user->getLogin()}" data-from="{$buyer->getLogin()}" data-avatar="{$buyer->getAvatar()}" data-avatar-color="{$buyer->getColor()}">Отзыв</a>
                                                    </div>
                                                </div>
                                            {/if}
                        
                                        </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    {else}
                        <div class="lk-border lk-block_products lk-profile_sales">
                            <div class="row">
                                {foreach from=$deals item=$deal}
                                    {$advert = $deal->getAdvert()}
                                    {$seller = $advert->getAuthor()}

                                    {include file='elements/advert/advert.tpl' showRating=true}
                                {/foreach}
                                </div>
                            </div>
                        </div>
                    {/if}
                {else}
                    <div class="lk-border">
                        <h3 class="text-center">{t}Нет продаж{/t}</h3>
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>

<script>
    $(function () {
        $('input[name="product_get"]').on('change', function () {
            let v = $(this).data('status');
            $(this).closest('form').find('button.update_status').data('status', v);
        })
    })
</script>

{include file='elements/main/footer.tpl'}