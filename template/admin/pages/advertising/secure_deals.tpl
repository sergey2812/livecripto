{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    let deal_id = 0;
    let deal_status = 0;
    let deal_deal_status = 0;

    let advert_num = 0;
    let advert_name = '';

    let author_login = '';
    let author_wallet_address = '';
    let author_id = 0;

    let admin_id = 0;
    let admin_login = '';
    let admin_wallet_address = '';

    let buyer_id = 0;
    let buyer_login = '';
    let buyer_wallet_address = '';

    let pay_date = '';
    let pay_confirmation_date = '';    
    let pay_sum = 0;

    let pay_summ_toseller = 0;
    let royalty = 0;    

    let send_product_date = '';
    let resive_product_confirmation_date = '';
    let send_pay_to_seller_date = '';

    let crypto_code = '';
    let chat_buyer_id = 0;
    let chat_author_id = 0;

    let incident_opener = 0;

    $('#payment-top-info').on('shown.bs.modal', function () {
      //#new_edit_country - id элемента, которому необходимо установить фокус
      $("input[name='number_days_plus']").focus();
    })    

    deal_deal_status = $("input[name='deal_deal_status']").val();

    if (deal_deal_status ==2)
        {
            alert('Перевод подтвержден!');
            $("input[name='deal_deal_status']").val('');
        }

    $(".btn-sm.payment-top4").on('click', function () 
        { 
            deal_id = $(this).data('id');
            advert_num = $(this).data('advert-id');
            advert_name = $(this).data('advert-name');

            $("input[name='deal_id']").val(deal_id);           

            $("h3.modal-title").html('Безопасная сделка №  ' +deal_id);
            
            $("input[name='advert_id']").val(advert_num);
            $(".advert_row_secure_deal").html('<a href="/admin/adverts.php?type=single&id='+advert_num+'" target="_blank" class="advert-title-modal-top">Объявление № '+advert_num+' '+advert_name+'</a>');

            author_login = $(this).data('author-login');
            admin_login = $(this).data('admin-login');
            buyer_login = $(this).data('buyer-login');

            author_id = $(this).data('author-id');
            admin_id = $(this).data('admin-id');
            buyer_id = $(this).data('buyer-id');

            $("input[name='admin_id']").val(admin_id);            

            chat_author_id = $(this).data('chat-seller-id');
            chat_buyer_id = $(this).data('chat-buyer-id-id');            

            if (admin_id != author_id && admin_id != '')
                {
                    $("th.secure_author_login").html('<a class="login-btn-top-update" href="/admin/clients.php?type=chat&admin_id='+admin_id+'&user_id='+author_id+'&chat_id='+chat_author_id+'" target="_blank">'+author_login+'</a>');
                }
            else
                {
                    $("th.secure_author_login").text(author_login);
                }

            if (admin_id != buyer_id && admin_id != '')
                {
                    $("th.secure_buyer_login").html('<a class="login-btn-top-update" href="/admin/clients.php?type=chat&admin_id='+admin_id+'&user_id='+buyer_id+'&chat_id='+chat_buyer_id+'" target="_blank">'+buyer_login+'</a>');
                }
            else
                {
                    $("th.secure_buyer_login").text(buyer_login);
                }            

            $("th.secure_admin_login").text(admin_login);
            

            author_wallet_address = $(this).data('author-wallet');
            admin_wallet_address = $(this).data('admin-wallet');
            buyer_wallet_address = $(this).data('buyer-wallet');

            $("th.secure_author_address_wallet").text(author_wallet_address);
            $("th.secure_admin_address_wallet").text(admin_wallet_address);
            $("th.secure_buyer_address_wallet").text(buyer_wallet_address);            

            pay_date = $(this).data('pay-date');
            pay_sum = $(this).data('pay-sum');

            $("th.secure_buyer_pay_sum").text(pay_sum);
            $("th.secure_buyer_pay_date").text(pay_date);

            royalty = (pay_sum/100*10);
            pay_summ_toseller = (pay_sum-royalty);

            $("th.secure_admin_pay_sum").text(royalty);
            $("th.secure_author_pay_sum").text(pay_summ_toseller);

            $("input[name='summ_to_seller']").val(pay_summ_toseller);
            $("input[name='royalty']").val(royalty); 

            crypto_code = $(this).data('crypto-code');
            $(".wallet_row").html('Тип кошелька ');
            $("div.crypto-image img").attr('src', '/template/img/'+crypto_code+'.png');
            $(".crypta_row").html(crypto_code.toUpperCase());

            var public_date = $(this).data('date-deal'); 

            $("input[name='control_start_date']").val(public_date);           

            deal_status = $(this).data('deal-status');

            if (deal_status == 0 && pay_date != null)
                {
                    $("input[name='secure_deal_status']").val('Покупатель сделал перевод. Проверьте и подтвердите!');
                    $(".btn.btn-primary.secure_deal").val('Подтвердить перевод');
                    $(".btn.btn-danger.secure_deal").val('Перевод НЕ пришел');
                    $(".btn.btn-primary.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-danger.secure_deal").css('display', 'inline-block');
                }
            
            pay_confirmation_date = $(this).data('pay-conf-date');
            $("th.secure_admin_pay_confirmation").text('');

            if (deal_status == 1 && pay_confirmation_date != '')
                {
                    $("input[name='secure_deal_status']").val('Перевод подтверждён. Ожидаем отправки товара!');
                } 

            if (pay_confirmation_date != '')
                {
                    $("th.secure_admin_pay_confirmation").text($(this).data('pay-conf-date'));
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }
            
            send_product_date = $(this).data('send-product-date');  
            $("th.secure_author_send_product_date").text('');  

            if (deal_status == 2 && send_product_date != '')
                {
                    $("input[name='secure_deal_status']").val('Товар отправлен. Ожидаем подтверждения доставки!');
                } 

            if (send_product_date != '')
                {
                    $("th.secure_author_send_product_date").text($(this).data('send-product-date'));
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }

            resive_product_confirmation_date = $(this).data('resive-confirmation-date');  
            $("th.secure_buyer_resive_confirmation_date").text('');  

            if (deal_status == 4 && resive_product_confirmation_date != '')
                {
                    $("input[name='secure_deal_status']").val('Товар получен. Отправить перевод продавцу!');
                } 

            if (resive_product_confirmation_date != '')
                {
                    $("th.secure_buyer_resive_confirmation_date").text($(this).data('resive-confirmation-date'));
                    $(".btn.btn-primary.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-danger.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-primary.secure_deal").val('Отправить перевод продавцу');
                    $(".btn.btn-danger.secure_deal").val('Перевести сделку в арбитраж?');
                } 

            send_pay_to_seller_date = $(this).data('send-pay-to-seller-date');
            $("th.secure_admin_pay_date").text('');               

            if (send_pay_to_seller_date != '')
                {
                    $("input[name='secure_deal_status']").val('Сделка успешно завершена!');
        
                    $("th.secure_admin_pay_date").text($(this).data('send-pay-to-seller-date'));
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }
            
            incident_opener = $(this).data('incident-opener');
            
            if (deal_status == 6 && incident_opener > 0)
                {
                    $("input[name='secure_deal_status']").val('Перевод НЕ подтверждён! Сделка в арбитраже!');
                    $(".btn.btn-primary.secure_deal").val('Есть решение по арбитражу? Да, завершить сделку!');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                } 

            if (deal_status == 6 && incident_opener == 0)
                {
                    $("input[name='secure_deal_status']").val('Сделка завершена арбитражем! Перевод НЕ подтверждён.');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }

            if (deal_status == 7 && incident_opener > 0)
                {
                    $("input[name='secure_deal_status']").val('Товар НЕ отправлен продавцом! Сделка в арбитраже!');
                    $(".btn.btn-primary.secure_deal").val('Есть решение по арбитражу? Да, завершить сделку!');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }

            if (deal_status == 7 && incident_opener == 0)
                {
                    $("input[name='secure_deal_status']").val('Сделка завершена арбитражем! Товар НЕ отправлен продавцом.');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }                 

            if (deal_status == 8 && incident_opener > 0)
                {
                    $("input[name='secure_deal_status']").val('Товар НЕ получен покупателем! Сделка в арбитраже!');
                    $(".btn.btn-primary.secure_deal").val('Есть решение по арбитражу? Да, завершить сделку!');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'inline-block');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }

            if (deal_status == 8 && incident_opener == 0)
                {
                    $("input[name='secure_deal_status']").val('Сделка завершена арбитражем! Товар НЕ получен.');
                    
                    $(".btn.btn-primary.secure_deal").css('display', 'none');
                    $(".btn.btn-danger.secure_deal").css('display', 'none');
                }                                                                         
        });

    $("[data-tooltip]").mousemove(function (eventObject) 
        {

            $data_tooltip = $(this).attr("data-tooltip");
            
                $("#tooltip").text($data_tooltip)
                             .css({ 
                                 "top" : eventObject.pageY + 45,
                                "left" : eventObject.pageX - 25
                             })
                             .show();

            }).mouseout(function () {

                $("#tooltip").hide()
                             .text("")
                             .css({
                                 "top" : 0,
                                "left" : 0
                             });
        });                          
});
</script>

<div id="payment-top-info" class="modal fade">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 class="modal-title">Безопасная сделка</h3>
            <div class="modal_title_block_secure_deal">
                <div class="wallet_row"></div>
                <div class="crypto-image pay-top4"><img src=""></div>
                <div class="crypta_row"></div>
            </div>        
            <div class="modal_title_block_secure_deal-2">
                <div class="advert_row_secure_deal"></div>
                
            </div>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="advert_top" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="admin_id" value="">
        <input type="hidden" name="deal_id" value="">
        <input type="hidden" name="summ_to_seller" value="">
        <input type="hidden" name="royalty" value="">

        <input type="hidden" name="deal_deal_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable2" class="table table-striped table-bordered">
                                    <thead>
                                    <tr> 
                                        <th class="secure_parameters">Параметры сделки</th> 
                                        <th>Покупатель</th>
                                        <th>Продавец</th>
                                        <th>Администрация</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th class="secure_parameters login">Логин</th> 
                                            <th class="secure_buyer_login"></th>
                                            <th class="secure_author_login"></th>
                                            <th class="secure_admin_login"></th>
                                        </tr>
                                        <tr>
                                            <th class="secure_parameters address_wallet">Адрес кошелька</th> 
                                            <th class="secure_buyer_address_wallet"></th>
                                            <th class="secure_author_address_wallet"></th>
                                            <th class="secure_admin_address_wallet"></th>
                                        </tr>
                                        <tr>
                                            <th class="secure_parameters pay_sum">Сумма перевода</th> 
                                            <th class="secure_buyer_pay_sum"></th>
                                            <th class="secure_author_pay_sum"></th>
                                            <th class="secure_admin_pay_sum"></th>
                                        </tr>
                                        <tr>
                                            <th class="secure_parameters pay_date">Перевод отправлен</th> 
                                            <th class="secure_buyer_pay_date"></th>
                                            <th class="secure_author_pay_date"></th>
                                            <th class="secure_admin_pay_date"></th>
                                        </tr>                                        
                                        <tr> 
                                            <th class="secure_parameters pay_confirmation">Перевод получен</th> 
                                            <th class="secure_buyer_pay_confirmation"></th>
                                            <th class="secure_author_pay_confirmation"></th>
                                            <th class="secure_admin_pay_confirmation"></th>
                                        </tr>
                                        <tr>
                                            <th class="secure_parameters send_product_date">Товар отправлен</th> 
                                            <th class="secure_buyer_send_product_date"></th>
                                            <th class="secure_author_send_product_date"></th>
                                            <th class="secure_admin_send_product_date"></th> 
                                        </tr>
                                        <tr>                                      
                                            <th class="secure_parameters resive_confirmation_date">Товар получен</th> 
                                            <th class="secure_buyer_resive_confirmation_date"></th>
                                            <th class="secure_author_resive_confirmation_date"></th>
                                            <th class="secure_admin_resive_confirmation_date"></th>         
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="form-group modal_top">
                                    <div class="marketing-create__right left">
                                        <label class="label_start_date">Начало сделки</label>
                                        <input type="text" class="form-control secure_deal_start_date" value="" name="control_start_date" data-tooltip="Дата начала сделки для контроля." readonly>
                                    </div>
                                    <div class="marketing-create__right right">
                                        <label class="label_start_date">Статус</label>
                                        <input type="text" class="form-control secure_deal_status" value="" name="secure_deal_status" data-tooltip="Текущий статус сделки для контроля." readonly>
                                    </div>                                    
                                </div>
                                <input type="hidden" class="val_text" value="На данной странице отображаются данные по безопасным сделкам">
                            </div>
                        </div>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <input name="action" value="Принять сделку" type="submit" class="btn btn-primary secure_deal">
            <input name="action" value="Отклонить" type="submit" class="btn btn-danger secure_deal">
          </div>
      </form>
    </div>
  </div>
<div id="tooltip"></div>  
</div>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Контроль безопасных сделок</h3>
                </div>

                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего сделок в работе {$count_secure_deals} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr><th>№<br>п/п</th>
                                        <th>Объявление</th>
                                        <th>№ сделки</th>
                                        <th>Дата<br>сделки</th>                                         
                                        <th>Покупатель</th> 
                                        <th>Продавец</th>
                                        <th>Администратор</th> 
                                        <th>Статус сделки</th> 
                                        <th>Действие</th></tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                    {foreach from=$all_secure_deals item=$sd}
                                    {$last_admin_chat = $Chats->GetLastChatAdminByUserId($sd->getBuyer()->getId())}
                                    {$last_admin_chat2 = $Chats->GetLastChatAdminByUserId($sd->getSeller()->getId())}
                                    <tr>
                                        {$i = $i + 1}
                                        <th>{$i}</th>
                                        <th>№ {$sd->getAdvert()->getId()}<br>{$sd->getAdvert()->getName()}</th>
                                        <th>{$sd->getId()}</th>
                                        <th>{$sd->getDate()}</th>
                                        <th>{$sd->getBuyer()->getLogin()}</th> 
                                        <th>{$sd->getSeller()->getLogin()}</th>
                                        <th>{if $sd->getAdmin() > 0}{$Users->Get($sd->getAdmin())->getLogin()}{/if}</th>
                    <th class="{if $sd->getSendPayToSellerDate() != ''}approved{elseif $sd->getStatus() == 8 AND $sd->getIncidentOpener() == 0}in_the_archive{else}expectation{/if}">{if $sd->getStatus() == 0 AND $sd->getPayDate() != null}Проверить перевод{elseif $sd->getStatus() == 1 AND $sd->getPayConfirmationDate() != ''}Перевод подтверждён. Ожидаем отправки товара!{elseif $sd->getStatus() == 2 AND $sd->getSendProductDate() != ''}Товар отправлен. Ожидаем подтверждения доставки!{elseif $sd->getStatus() == 4 AND $sd->getSendPayToSellerDate() == ''}Товар получен. Отправить перевод продавцу!{elseif $sd->getSendPayToSellerDate() != ''}Сделка успешно завершена!{elseif $sd->getStatus() == 6 AND $sd->getIncidentOpener() > 0}Перевод НЕ подтверждён! Сделка в арбитраже!{elseif $sd->getStatus() == 6 AND $sd->getIncidentOpener() == 0}Сделка завершена арбитражем! Перевод НЕ подтверждён.{elseif $sd->getStatus() == 7 AND $sd->getIncidentOpener() > 0}Товар НЕ отправлен продавцом! Сделка в арбитраже!{elseif $sd->getStatus() == 7 AND $sd->getIncidentOpener() == 0}Сделка завершена арбитражем! Товар НЕ отправлен продавцом.{elseif $sd->getStatus() == 8 AND $sd->getIncidentOpener() > 0}Товар НЕ получен покупателем! Сделка в арбитраже!{elseif $sd->getStatus() == 8 AND $sd->getIncidentOpener() == 0}Сделка завершена арбитражем! Товар НЕ получен.{else}{/if}</th> 
                                        <th class="nmb"><a href="#payment-top-info" class="btn btn-success btn-sm payment-top4" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-id="{$sd->getId()}" data-advert-id="{$sd->getAdvert()->getId()}" data-advert-name="{$sd->getAdvert()->getName()}" data-author-login="{$sd->getSeller()->getLogin()}" data-author-wallet="{$sd->getSellerWallet()}" data-author-id="{$sd->getSeller()->getId()}" data-admin-id="{$user->getId()}" data-admin-login="{$user->getLogin()}" data-admin-wallet="{$sd->getAdminWallet()}" data-buyer-id="{$sd->getBuyer()->getId()}" data-buyer-login="{$sd->getBuyer()->getLogin()}" data-buyer-wallet="{$sd->getBuyerWallet()}" data-crypto-code="{$sd->getBuyerType()}" data-date-deal="{$sd->getDate()}" data-deal-status="{$sd->getStatus()}" data-pay-date="{$sd->getPayDate()}" data-pay-sum="{$sd->getPrice()}" data-chat-buyer-id="{if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}" data-chat-seller-id="{if !empty($last_admin_chat2)}{$last_admin_chat2[0]->getId()}{else}0{/if}" data-pay-conf-date="{$sd->getPayConfirmationDate()}" data-send-product-date="{$sd->getSendProductDate()}" data-resive-confirmation-date="{$sd->getResiveConfirmationDate()}" data-send-pay-to-seller-date="{$sd->getSendPayToSellerDate()}" data-incident-opener="{$sd->getIncidentOpener()}">Открыть</a></th>
                                    </tr>
                                    {foreachelse}
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                                <input type="hidden" class="val_text" value="На данной странице отображаются данные по безопасным сделкам">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}