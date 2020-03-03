{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/adverts_dashboard_status_update.js"></script>
<script src="{$template}/js/dashboard/advert_feedback.js"></script>

<script>   
    $(function productResivedOperation()
        {
            $('.input-product-resive-yes').on('click', function () 
                {
                    if ($('.assent-product-resive').hasClass('product_yes'))
                        {
                            $('.assent-product-resive').removeClass('product_yes');                  
                        }
                    else
                        {
                            $('.assent-product-resive').addClass('product_yes');
                            $('.assent-product-resive').removeClass('product_no');                  
                        }  
                });

            $('.input-product-resive-no').on('click', function () 
                {
                    if ($('.assent-product-resive').hasClass('product_no'))
                        {
                            $('.assent-product-resive').removeClass('product_no');                   
                        }
                    else
                        {
                            $('.assent-product-resive').addClass('product_no');
                            $('.assent-product-resive').removeClass('product_yes');                  
                        }                   
                });

            $('.assent-product-resive').on('click', function () 
                {
                    let chatId = $('.assent-product-resive').data('chat-id');

                    let text = "";

                    if ($('.assent-product-resive').hasClass('product_yes'))
                        {
                            text = "Товар получен. ПОДТВЕРЖДАЮ!";
                            $('.assent-product-resive').removeClass('pay_yes');
                            $('.assent-product-resive').removeClass('product_yes');                  
                        }

                    if ($('.assent-product-resive').hasClass('product_no'))
                        {
                            text = "Товар НЕ получен. Давайте выясним причину с обеих сторон!"; 
                            $('.assent-product-resive').removeClass('pay_no');
                            $('.assent-product-resive').removeClass('product_no');                  
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
                <div class="lk-top_menu">                     
                    <div class="row">
                        <div class="col-xs-4">
                            <a href="/dashboard.php?page=my_purchases&type=moderation{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'moderation'} class="active"{/if}>
                            {if $notifications['purchases-moderation'] > 0}
                                <i></i>
                            {/if}                               
                                На проверке {$Users->getBuyCount($user->getId(), '0')}
                            </a>
                        </div>
                        <div class="col-xs-4">
                            <a href="/dashboard.php?page=my_purchases&type=open{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'open'} class="active"{/if}>
                            {if $notifications['purchases-open'] > 0}
                                <i></i>
                            {/if}                                                              
                                Открытые {$Users->getBuyCount($user->getId(), '1,2,3')}
                            </a>
                        </div>
                        <div class="col-xs-4">
                            <a href="/dashboard.php?page=my_purchases&type=close{if !empty($user_id)}&user_id={$user_id}{/if}"{if $type == 'close'} class="active"{/if}>
                            {if $notifications['purchases-close'] > 0}
                                <i></i>
                            {/if}                                
                                Закрытые {$Users->getBuyCount($user->getId(), '4,6,7,8')}
                            </a>
                        </div>
                    </div>
                </div>
                {foreach from=$deals item=$deal}
                    {$advert = $deal->getAdvert()}
                    {$seller = $advert->getAuthor()}
                    <div class="lk-p-close lk-border">
                        <div class="row">
                            {include file='elements/advert/advert.tpl'}
                            <div class="col-xs-9">
                                <div class="llk-p-close_row llk-p-close_row-width">
                                    <div>Продавец:</div>
                                    <div><a href="/dashboard.php?page=my_adverts&user_id={$seller->getId()}">{$seller->getLogin()}</a></div>
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
                                {elseif !empty($deal->getPayDate())}
                                    <div class="llk-p-close_row llk-p-close_row-width">
                                        <div>Время перевода:</div>
                                        <div class="date">{date('d.m.Y H:i', strtotime($deal->getPayDate()))}</div>
                                        <div class="paid">
                                            ПЕРЕВОД ОТПРАВЛЕН
                                        </div>
                                        {if $deal->getStatus() == 0}
                                            <div>Дальнейшие действия:&nbsp;&nbsp;&nbsp;</div>
                                            <div class="paid" style="margin-bottom: 0.5em; margin-top: 0.9em;">Ожидаем подтверждения перевода</div>
                                        {/if}                                        
                                        {if $deal->getStatus() >= 1 && $deal->getStatus() < 5}
                                            <div class="paid">ПОЛУЧЕН</div>
                                        {/if}
                                        {if $deal->getStatus() == 1}
                                            <div>Дальнейшие действия:&nbsp;&nbsp;&nbsp;</div>
                                            <div class="paid" style="margin-bottom: 0.5em; margin-top: 0.9em;">Ожидаем поступление товара</div>
                                        {/if}                                        
                                        {if $deal->getStatus() == 6}
                                            <div class="no-product">НЕ ПОЛУЧЕН</div>
                                        {/if}
                                        {if $deal->getStatus() == 7 || $deal->getStatus() == 8}
                                            <div class="paid">ПОЛУЧЕН</div>
                                        {/if}                                                                                 
                                    </div>
                                {/if}
                                {if $deal->getStatus() == 2}
                                <div class="llk-p-close_row llk-p-close_row-width">
                                    <div class="llk-p-close_row llk-p-close_row-width" style="display: inline;">
                                        <div>Товар получен?</div>
                                            <div>
                                            <form class="lk-p-close_get" action="/ajax/chat/get_resived.php" method="POST">
                                                    <input type="hidden" name="chat_id" value="{$deal->getChat()}">
                                                <div>
                                                    <input type="radio" name="product_get" value="Да" data-status="1" class="input-product-resive-yes" onclick="productResivedOperation()" data-chat-id="{$deal->getChat()}">
                                                    <label>Да</label>
                                                </div>
                                                <div>
                                                    <input type="radio" name="product_get" value="Нет" data-status="0" class="input-product-resive-no" onclick="productResivedOperation()" data-chat-id="{$deal->getChat()}">
                                                    <label>Нет</label>
                                                </div>
                                                <div>
                                                    <button class="assent-product-resive" data-chat-id="{$deal->getChat()}" onclick="productResivedOperation()" disabled>Подтвердить</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                {/if}
                                {if $deal->getStatus() > 2 && $deal->getStatus() < 5}
                                    <div class="llk-p-close_row llk-p-close_row-width">
                                        <div>Статус товара:</div>
                                        
                                        <div class="paid">
                                            ТОВАР ПОЛУЧЕН
                                        </div>
                                    </div>
                                {/if}
                                {if $deal->getStatus() >= 6 && $deal->getStatus() < 8}
                                    <div class="llk-p-close_row llk-p-close_row-width">
                                        <div>Статус товара:</div>
                                        
                                        <div class="no-product">
                                            ТОВАР НЕ ОТПРАВЛЕН
                                        </div>
                                    </div>
                                {/if}
                                {if $deal->getStatus() == 8}
                                    <div class="llk-p-close_row llk-p-close_row-width">
                                        <div>Статус товара:</div>
                                        
                                        <div class="paid">
                                            ТОВАР ОТПРАВЛЕН
                                        </div>
                                        <div class="no-product">
                                            НЕ ПОЛУЧЕН
                                        </div>                                        
                                    </div>
                                {/if}                                                                
                                {if $deal->getStatus() == 4 || $deal->getStatus() == 6 || $deal->getStatus() == 7 || $deal->getStatus() == 8}
                                    <div class="llk-p-close_row">
                                    {$reviewFrom = $Adverts->GetDealFeedback($deal->getId(), $seller->getId())}
                                    {if empty($reviewFrom)}
                                        <a href="#review" class="lk-p-close_addreview open-forms add_review" data-deal_id="{$deal->getId()}">Оставить оценку и отзыв о продавце</a>
                                    {else}
                                        <div class="llk-p-close_row llk-p-close_row-reviews">
                                            <div>Оценка и отзыв покупателя:</div>
                                            <div class="lk-p-close_stars">
                                                {include file='elements/advert/rating.tpl' rating=$reviewFrom['rating']}
                                            </div>
                                            <div>
                                                <a href="#reviews2" class="lk-p-close_review open-forms show-comment" data-text="{htmlspecialchars($reviewFrom['text'])}" data-like="{$reviewFrom['like']}" data-rating="{$reviewFrom['rating']}" data-to="{$seller->getLogin()}" data-from="{$user->getLogin()}" data-avatar="{$user->getAvatar()}" data-avatar-color="{$user->getColor()}">Отзыв</a>
                                            </div>
                                        </div>
                                    {/if}
                            {include file='elements/user_reviews2.tpl' user=$seller empty=false}
                                    {$reviewTo = $Adverts->GetDealFeedback($deal->getId(), $user->getId())}
                                    {if empty($reviewTo)}
                                        <div class="lk-p-close_wait">Ожидание оценки и отзыва от продавца</div>
                                    {else}
                                        <div class="llk-p-close_row llk-p-close_row-reviews">
                                            <div>Оценка и отзыв продавца:</div>
                                            <div class="lk-p-close_stars">
                                                {include file='elements/advert/rating.tpl' rating=$reviewTo['rating']}
                                            </div>
                                            <div>
                                                <a href="#reviews" class="lk-p-close_review open-forms show-comment" data-text="{htmlspecialchars($reviewTo['text'])}" data-like="{$reviewTo['like']}" data-rating="{$reviewTo['rating']}" data-from="{$user->getLogin()}" data-to="{$seller->getLogin()}" data-avatar="{$seller->getAvatar()}" data-avatar-color="{$seller->getColor()}">Отзыв</a>
                                            </div>
                                        </div>
                                    {/if}
                       
                                </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {foreachelse}
                    <div class="lk-border">
                        <h3 class="text-center">{t}Нет покупок{/t}</h3>
                    </div>
                {/foreach}
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