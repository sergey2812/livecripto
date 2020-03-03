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

    let days = 0;
    let position = 0;
    let country = 0;
    let city = 0;
    let section = 0;
    let category = 0;    
    let subcategory = 0;

    $('#payment-top-info').on('shown.bs.modal', function () {
      //#new_edit_country - id элемента, которому необходимо установить фокус
      $("input[name='number_days_plus']").focus();
    })    

    $(".btn-sm.payment-top4").on('click', function () 
        { 
            advert_num = $(this).data('advert-id');
            advert_name = $(this).data('advert-name');
            ad_id = $(this).data('id');
            $("input[name='advert_top_id']").val(ad_id);
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

            $("th.days").text($(this).data('days'));
            days = $(this).data('days');
            $("input[name='days_in_top']").val(days);
            $("th.position").text($(this).data('position'));
            $("th.country").text($(this).data('country'));
            $("th.city").text($(this).data('city'));
            $("th.section").text($(this).data('section'));
            $("th.category").text($(this).data('category'));
            $("th.subcategory").text($(this).data('subcategory'));

            var current_date = Date.now();
            var days_num = $("input[name='number_days_plus']").val();
            var public_date = current_date + days_num*86400*1000; 
            var end_date = public_date + days*86400*1000; 

            public_date = new Date(public_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
            $("input[name='control_start_date']").val(public_date);

            end_date = new Date(end_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
            $("input[name='control_end_date']").val(end_date);

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
                        var end_date = public_date + days*86400*1000; 

                        public_date = new Date(public_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
                        $("input[name='control_start_date']").val(public_date);

                        end_date = new Date(end_date).toISOString().replace(/^([^T]+)T(.+)$/,'$1').replace(/^(\d+)-(\d+)-(\d+)$/,'$3.$2.$1');
                        $("input[name='control_end_date']").val(end_date);

                        
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
        <h3 class="modal-title">Информация о размещении в ТОП</h3>
            <div class="modal_title_block_top">
                <div class="advert_row"></div>
                <div class="author_row"></div>
                <div class="user-icon pay-top4"><img src=""></div>
            </div>
            <div class="modal_title_block_top-2">
                <div class="request_row"></div>
                <div class="amount_row"></div>
                <div class="wallet_row"></div>
                <div class="crypto-image pay-top4"><img src=""></div>
                <div class="crypta_row"></div>
            </div>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="advert_top" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="advert_top_id" value="">
        <input type="hidden" name="away_date" value="">
        <input type="hidden" name="days_in_top" value="">
        <input type="hidden" name="advert_top_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable2" class="table table-striped table-bordered">
                                    <thead>
                                    <tr> 
                                        <th>Дней</th> 
                                        <th>Позиция<br>в ТОП</th>
                                        <th>Страна</th>
                                        <th>Город</th>
                                        <th>Раздел</th>
                                        <th>Категория</th>
                                        <th>Подкатегория</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th class="days"></th> 
                                            <th class="position"></th>
                                            <th class="country"></th>
                                            <th class="city"></th>
                                            <th class="section"></th>
                                            <th class="category"></th>
                                            <th class="subcategory"></th>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="form-group modal_top">
                                    <div class="marketing-create__right">
                                        <label class="label_start_date">Публикация в ТОП</label>
                                        <input type="text" class="form-control calendar_start_date" value="" name="control_start_date" data-tooltip="Эта дата Вам для контроля. С этой даты начнется публикация бъявления в ТОП" readonly>

                                        <label class="label_end_date">Выход из ТОП</label>
                                        <input type="text" class="form-control calendar_end_date" value="" name="control_end_date" data-tooltip="Эта дата Вам для контроля. В этот день закончится публикация бъявления в ТОП" readonly>

                                        <input type="text" class="form-control input_start_date" value="0" name="number_days_plus" placeholder="цифра" data-tooltip="Цифра означает, сколько дней надо прибавить к сегодняшней дате. Например, сегодня 1 января. Ставим 3. Пубикация начнется с 4-го января. Ноль - это значит с сегодняшнего дня, прямо сейчас." required>
                                    </div>
                                </div>
                                <input type="hidden" class="val_text" value="На данной странице отображаются заявки на размещение в ТОП">
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
                    <h3>Контроль заявок на размещения в ТОП-4</h3>
                </div>

                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего заявок, требующих рассмотрения, {$top_4_prices->getClientsTop4RowCount()} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr><th>№<br>п/п</th>
                                        <th>Объявление</th>
                                        <th>Автор</th> 
                                        <th>Дата<br>оплаты</th> 
                                        <th>Сумма</th>
                                        <th>Кошелек<br>администрации</th> 
                                        <th>Дата<br>публикации</th>
                                        <th>Дата<br>снятия</th>
                                        <th>Статус</th> 
                                        <th>Действие</th></tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                    {foreach from=$all_clients_payment_top item=$client_payment_top}
                                    {$last_admin_chat = $Chats->GetLastChatAdminByUserId($client_payment_top->getUser()->getId())}
                                    <tr>
                                        {$i = $i + 1}
                                        <th>{$i}</th>
                                        <th>№ {$client_payment_top->getAdvert()->getId()}<br>{$client_payment_top->getAdvert()->getName()}</th>
                                        <th>{$client_payment_top->getUser()->getLogin()}</th>
                                        <th>{$client_payment_top->getPayDate()}</th> 
                                        <th>{$client_payment_top->getPaySum()}</th>
                                        <th>{$client_payment_top->getAdminWallet()}</th>
<th>{if $client_payment_top->getStartDate() !== '30.11.-0001'}{$client_payment_top->getStartDate()}{/if}</th>
<th>{if $client_payment_top->getEndDate() !== '30.11.-0001'}{$client_payment_top->getEndDate()}{/if}</th>
                                        <th class="{if $client_payment_top->getStatus() == 1}expectation{elseif $client_payment_top->getStatus() == 2}approved{elseif $client_payment_top->getStatus() == 4}in_the_archive{/if}">{if $client_payment_top->getStatus() == 1}ожидание{elseif $client_payment_top->getStatus() == 2}одобрено{elseif $client_payment_top->getStatus() == 3}отклонено{elseif $client_payment_top->getStatus() == 4}в архиве{else}{/if}</th> 
                                        <th class="nmb"><a href="#payment-top-info" class="btn{if $client_payment_top->getStatus() > 1} btn-info{else} btn-success{/if} btn-sm payment-top4" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-id="{$client_payment_top->getId()}" data-advert-id="{$client_payment_top->getAdvert()->getId()}" data-advert-name="{$client_payment_top->getAdvert()->getName()}" data-author-login="{$client_payment_top->getUser()->getLogin()}" data-author-avatar="{$client_payment_top->getUser()->getAvatar()}" data-author-color="{$client_payment_top->getUser()->getColor()}" data-pay-date="{$client_payment_top->getPayDate()}" data-pay-sum="{$client_payment_top->getPaySum()}" data-author-wallet="{$client_payment_top->getUserWallet()}" data-crypto-code="{$client_payment_top->getCryptaCode()}" data-days="{$client_payment_top->getDays()}" data-position="{$client_payment_top->getTopPosition()}" data-country="{$countries->GetLocation($client_payment_top->getCountry())->getName()}" data-city="{if $client_payment_top->getCity() > 0}{$countries->GetCity($client_payment_top->getCity())->getName()}{/if}" data-section="{if $client_payment_top->getSection() > 0}{$sections_table->GetSection($client_payment_top->getSection())->getName()}{/if}" data-category="{if $client_payment_top->getCategory() > 0}{$sections_table->GetCategory($client_payment_top->getCategory())->getName()}{/if}" data-subcategory="{if $client_payment_top->getSubcategory() > 0}{$sections_table->GetSubcategory($client_payment_top->getSubcategory())->getName()}{/if}" data-author-id="{$client_payment_top->getUser()->getId()}" data-admin-id="{$_COOKIE['id']}" data-chat-id="{if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}">{if $client_payment_top->getStatus() > 1}Рассмотрено{else}Рассмотреть{/if}</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются заявки на размещение в ТОП">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}