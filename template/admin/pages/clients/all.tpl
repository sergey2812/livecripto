{include file='admin/elements/header.tpl'}


{if !empty($user_to)}
{include file='admin/pages/clients/modal_form_user_ban.tpl'}
{/if}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <div class="title_left">
                        <h3>Все клиенты</h3>
                    </div>
                    <div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <form method="POST" class="input-group">
                                <input type="text" class="form-control" placeholder="Поиск по имени или почте" name="search" value="{$search}">
                                <span class="input-group-btn">
                                  <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                                </span>
                            </form>
                        </div>
                    </div>
                </div>
                    <div class="back_btn_wallet">
                        <a href="/admin/clients.php?type=banned" class="btn btn-default btn-md">Перейти в список заблокированных</a>
                    </div>                
                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th rowspan="2">Логин<br>(открыть новый чат<br>по инициативе<br>администратора)</th>
                                        <th rowspan="2">Почта</th>
                                        <th colspan="2">Объявления</th>
                                        <th rowspan="2">Покупки</th>
                                        <th rowspan="2">Блокировки</th>
                                        <th rowspan="2">ЛК клиента</th>
                                        <th rowspan="2">Статус<br>(Действия)</th>
                                        <th rowspan="2">Сообщения<br>клиента из чата</th>
                                        {*<th rowspan="2">Комментарии</th>*}
                                    </tr>
                                    <tr>
                                        <th>Активные</th>
                                        <th>В ТОП</th>
                                    </tr>
                                    </thead>                                    
                                    <tbody>
                                        {foreach from=$all_users item=$user}
                                            <tr>
                                                {$last_admin_chat = $Chats->GetLastChatAdminByUserId($user->getId())}

                                                <th>{if $_COOKIE['id'] != $user->getId()}<a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$user->getId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}">{$user->getLogin()}</a>{else}{$user->getLogin()}{/if}</th>
                                                <th>{$user->getEmail()}</th>
                                                {$user_stats = $user->getStats()}
                                                <th class="nmb">{$user_stats['adverts_active']}</th>
                                                <th class="nmb">{$user_stats['adverts_in_top']}</th>
                                                <th class="nmb">{$user_stats['buys']}</th>
                                                <th class="nmb">{$user_stats['blocks']}</th>
                                                <th><a href="/dashboard.php?user_id={$user->getId()}" target="_blank">Открыть</a></th>

                                                <th>
                                                    <form method="POST">
                                                        <input type="hidden" name="function" value="modal_ban">
                                                        <input type="hidden" name="id_user_to" value="{$user->getId()}">
                                                        <input type="hidden" name="stats" value="{if $user->hasBanned()}1{else}0{/if}">
                                                        <input type="hidden" name="stats_2" value="{if isset($stats)}{$stats}{/if}">
    <button href="#banned_modal_form" target="_blank" name="banned_button" type="submit" class="{if $user->hasBanned()}btn_unbanned{elseif $user->getBannedCause() == 1}btn_banned{else}btn_ok{/if} admin_all_clients open-forms" data-client-login="{$user->getLogin()}" data-client-id="{$user->getId()}" data-client-color="{$user->getColor()}" data-client-avatar="{$user->getAvatar()}">
        {if $user->hasBanned()}Заблокирован
        {elseif $user->getBannedCause() == 1}Заблокировать
        {else}Ok
        {/if}
    </button>
                                                    </form>
                                                </th> 
                                                <th>{if $Chats->GetReadStatusAdminMessages($user->getId()) == 2 OR $Chats->GetReadStatusAdminMessages($user->getId()) == 1}<a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$user->getId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{/if}" class="{if $Chats->GetReadStatusAdminMessages($user->getId()) == 2}reply_to_chat{/if}">{if $Chats->GetReadStatusAdminMessages($user->getId()) == 2}Ответить{elseif $Chats->GetReadStatusAdminMessages($user->getId()) == 1}Открыть{/if}</a>{/if}</th>
                
                                            </tr>

                                        {foreachelse}
                                            <tr>
                                                <th>Нет клиентов по данному запросу</th>
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

                                <input type="hidden" class="val_text" value="В данном разделе в таблице отображаются все зарегистрированные на сайте клиенты. ">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='admin/elements/footer.tpl'}