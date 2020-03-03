{include file='admin/elements/header.tpl'}

{if !empty($user_to)}
{include file='admin/pages/clients/modal_form_user_unban.tpl'}
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
                        <h3>Заблокированные клиенты</h3>
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
                        <a href="/admin/clients.php?type=all" class="btn btn-default btn-md">Перейти в список всех клиентов</a>
                    </div>                
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th rowspan="2">Логин</th>
                                        <th rowspan="2">Почта</th>
                                        <th colspan="2">Объявления</th>
                                        <th rowspan="2">Покупки</th>
                                        <th rowspan="2">Блокировки</th>
                                        <th rowspan="2">ЛК клиента</th>
                                        <th rowspan="2">Дата последней<br>блокировки клиента</th>
                                        <th rowspan="2">Заблокирован<br>(Действия)</th>
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
                                                <th class="nmb">{if $user->getBannedDate() != null}{$user->getBannedDate()}{/if}</th>
                                                <th>
                                                    <form method="POST">
                                                        <input type="hidden" name="function" value="modal_unban">
                                                        <input type="hidden" name="btn_open" value="{if isset($hidden_rows)}{$hidden_rows}{/if}">
                                                        <input type="hidden" name="id_user_to" value="{$user->getId()}">

    <button href="#banned_modal_form_2" name="unbanned_button" type="submit" class="{if $user->hasBanned()}btn_unbanned{else}btn_banned{/if} admin_all_clients open-forms" data-client-login="{$user->getLogin()}" data-client-id="{$user->getId()}" data-client-color="{$user->getColor()}" data-client-avatar="{$user->getAvatar()}">{if $user->hasBanned()}Разблокировать{else}Заблокировать{/if}</button>
                                                    </form>
                                                </th> 
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
                                <input type="hidden" class="val_text" value="В данном разделе можно посмотреть всех заблокированных клиентов и управлять их статусом">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='admin/elements/footer.tpl'}