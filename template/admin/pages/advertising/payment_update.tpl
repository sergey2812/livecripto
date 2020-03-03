{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    let ad_id = 0;
    let advert_num = 0;
    let advert_name = '';

    let author_login = '';
    let author_avatar = '';
    let author_color = '';
    let author_wallet_address = '';

    let author_id = 0;
    let admin_id = 0;
    let chat_id = 0;    

    let pay_date = '';
    let pay_sum = 0;    

    let crypto_code = '';

    let country = 0;
    let city = 0;
    let section = '';
    let category = '';    
    let subcategory = '';

    $('#payment-update-info').on('shown.bs.modal', function () {
      //#new_edit_country - id элемента, которому необходимо установить фокус
      $("input[name='number_days_plus']").focus();
    })     

    $(".btn-sm.payment-update").on('click', function () 
        { 
            advert_num = $(this).data('advert-id');
            advert_name = $(this).data('advert-name');
            ad_id = $(this).data('id');
            $("input[name='id_row_clients_update']").val(ad_id);
            $("input[name='advert_id_from_adverts']").val(advert_num);

            $(".advert_row").html('<a href="/admin/adverts.php?type=single&id='+advert_num+'" target="_blank" class="advert-title-modal-top">Объявление № '+advert_num+' '+advert_name+'</a>');

            author_login = $(this).data('author-login');
            author_avatar = $(this).data('author-avatar');
            author_color = $(this).data('author-color');

            author_id = $(this).data('author-id');
            admin_id = $(this).data('admin-id');
            chat_id = $(this).data('chat-id');

            $(".author_row").html('<a class="login-btn-top-update" href="/admin/clients.php?type=chat&admin_id='+admin_id+'&user_id='+author_id+'&chat_id='+chat_id+'" target="_blank">'+author_login+'</a>');

            $("div.user-icon").css('background-color', '#'+author_color);               
            $("div.user-icon img").attr('src', '/files/'+author_avatar);

            pay_date = $(this).data('pay-date');
            pay_sum = $(this).data('pay-sum');
            $(".request_row").html('Заявка от ' +pay_date);
            $(".amount_row").html('Сумма ' +pay_sum);

            author_wallet_address = $(this).data('author-wallet');
            crypto_code = $(this).data('crypto-code');
            $(".wallet_row").html('Из кошелька ' +author_wallet_address);
            $("div.crypto-image img").attr('src', '/template/img/'+crypto_code+'.png');
            $(".crypta_row").html(crypto_code.toUpperCase());

            $("th.country").text($(this).data('country'));
            $("th.city").text($(this).data('city'));
            $("th.section").text($(this).data('section'));
            $("th.category").text($(this).data('category'));
            $("th.subcategory").text($(this).data('subcategory'));

            var current_date = Date.now();
            var days_num = $("input[name='number_days_plus']").val();
            var public_date = current_date + days_num*86400*1000;                        
            public_date = new Date(public_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
            $("input[name='control_date']").val(public_date); 

            var away_date = Date.now();
            away_date = new Date(away_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
            $("input[name='away_date']").val(away_date);
        });

        $("input[name='number_days_plus']").keyup(function () 
            {
                var current_date = Date.now();

                if (isNaN($(this).val())) 
                    {
                        // It isn't a number
                        alert('В поле должны быть только цифры!');
                        $(this).val('');               
                    }
                else
                    {
                        var days_num = $("input[name='number_days_plus']").val();
                        var public_date = current_date + days_num*86400*1000;                        
                        public_date = new Date(public_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
                        $("input[name='control_date']").val(public_date);
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

<div id="payment-update-info" class="modal fade">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 class="modal-title">Информация об Обновлении</h3>
            <div class="modal_title_block">
                <div class="advert_row"></div>
                <div class="author_row"></div>
                <div class="user-icon pay-top4"><img src=""></div>
            </div>
            <div class="modal_title_block-2">    
                <div class="request_row"></div>
                <div class="amount_row"></div>
                <div class="wallet_row"></div>
                <div class="crypto-image pay-top4"><img src=""></div>
                <div class="crypta_row"></div>
            </div>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="advert_update" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="id_row_clients_update" value="">
        <input type="hidden" name="advert_id_from_adverts" value="">
        <input type="hidden" name="away_date" value="">
        <input type="hidden" name="advert_update_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable3" class="table table-striped table-bordered">
                                    <thead>
                                    <tr> 
                                        <th>Страна</th>
                                        <th>Город</th>
                                        <th>Раздел</th>
                                        <th>Категория</th>
                                        <th>Подкатегория</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr> 
                                            <th class="country"></th>
                                            <th class="city"></th>
                                            <th class="section"></th>
                                            <th class="category"></th>
                                            <th class="subcategory"></th>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="form-group modal_top_update">
                                    <div class="marketing-create__right">
                                        <label class="label_start_date_update">Дата обновления</label>
                                        <input type="text" class="form-control calendar_start_date_update" value="" name="control_date" data-tooltip="Эта дата Вам для контроля. С этой даты начнется обновление объявления клиента" readonly>
                                        <input type="text" class="form-control input_start_date_update" value="0" name="number_days_plus" placeholder="цифра" data-tooltip="Цифра означает, сколько дней надо прибавить к сегодняшней дате. Например, сегодня 1 января. Ставим 3. Пубикация начнется с 4-го января. Ноль - это значит с сегодняшнего дня, прямо сейчас." required>
                                    </div>
                                </div>
                                <input type="hidden" class="val_text" value="На данной странице отображаются заявки на ОБНОВЛЕНИЕ">
                            </div>
                        </div>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <input name="action" value="Принять заявку" type="submit" class="btn btn-primary">
            <input name="action" value="Отклонить" type="submit" class="btn btn-danger">
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
                    <h3>Контроль заявок на ОБНОВЛЕНИЕ</h3>
                </div>

                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего заявок, требующих рассмотрения, {$update_prices->getClientsUpdateRowCount()} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№<br>п/п</th>
                                        <th>Объявления</th>
                                        <th>Автор</th> 
                                        <th>Дата<br>оплаты</th> 
                                        <th>Сумма</th>
                                        <th>Кошелек<br>администрации</th>
                                        <th>Дата<br>обновления</th> 
                                        <th>Дата<br>отказа</th>
                                        <th>Статус</th> 
                                        <th>Действие</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                    {foreach from=$all_clients_payment_update item=$client_payment_update}
                                    {$last_admin_chat = $Chats->GetLastChatAdminByUserId($client_payment_update->getUser()->getId())}
                                    <tr>
                                        {$i = $i + 1}
                                        <th>{$i}</th>
                                        <th>№ {$client_payment_update->getAdvert()->getId()}<br>{$client_payment_update->getAdvert()->getName()}</th>
                                        <th>{$client_payment_update->getUser()->getLogin()}</th>
                                        <th>{$client_payment_update->getPayDate()}</th>
                                        <th>{$client_payment_update->getPaySum()}</th> 
                                        <th>{$client_payment_update->getAdminWallet()}</th>
<th>{if $client_payment_update->getStartDate() !== '30.11.-0001'}{$client_payment_update->getStartDate()}{/if}</th>
<th>{if $client_payment_update->getAwayDate() !== '30.11.-0001'}{$client_payment_update->getAwayDate()}{/if}</th>
                                        <th class="{if $client_payment_update->getStatus() == 1}expectation{elseif $client_payment_update->getStatus() == 2}approved{elseif $client_payment_update->getStatus() == 4}in_the_archive{/if}">{if $client_payment_update->getStatus() == 1}ожидание{elseif $client_payment_update->getStatus() == 2}одобрено{elseif $client_payment_update->getStatus() == 3}отклонено{elseif $client_payment_update->getStatus() == 4}в архиве{else}{/if}</th> 
                            <th class="nmb"><a href="#payment-update-info" class="btn{if $client_payment_update->getStatus() > 1} btn-info{else} btn-success{/if} btn-sm payment-update" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-id="{$client_payment_update->getId()}" data-advert-id="{$client_payment_update->getAdvert()->getId()}" data-advert-name="{$client_payment_update->getAdvert()->getName()}" data-author-login="{$client_payment_update->getUser()->getLogin()}" data-author-avatar="{$client_payment_update->getUser()->getAvatar()}" data-author-color="{$client_payment_update->getUser()->getColor()}" data-pay-date="{$client_payment_update->getPayDate()}" data-pay-sum="{$client_payment_update->getPaySum()}" data-author-wallet="{$client_payment_update->getUserWallet()}" data-crypto-code="{$client_payment_update->getCryptaCode()}" data-country="{$countries->GetLocation($client_payment_update->getCountry())->getName()}" data-city="{if $client_payment_update->getCity() != 0}{$countries->GetCity($client_payment_update->getCity())->getName()}{/if}" data-section="{$client_payment_update->getSection()->getName()}" data-category="{$client_payment_update->getCategory()->getName()}" data-subcategory="{$client_payment_update->getSubcategory()->getName()}" data-author-id="{$client_payment_update->getUser()->getId()}" data-admin-id="{$_COOKIE['id']}" data-chat-id="{if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}">{if $client_payment_update->getStatus() > 1}Рассмотрено{else}Рассмотреть{/if}</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются заявки на обновление объявлений">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}