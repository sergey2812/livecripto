{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        {* todo-hard Доделать создание новых пользователей в админке *}

        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Учетные записи сотрудников</h3>
                    <div class="title_left">
                        <a href="/admin/profiles.php?type=create" class="btn btn-default btn-md">Создать</a>
                    </div>

                    <div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Поиск по имени или почте">
                                <span class="input-group-btn">
                      <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                    </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Логин</th>
                                            <th>Почта</th>
                                            <th>Телефон</th>
                                            <th>Роль</th>
                                            <th>Статус</th>
                                            <th>Дата регистрации</th>
                                            <th>Чат</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {foreach from=$all_users item=$user}
                                        {$last_admin_chat = $Chats->GetLastChatAdminByUserId($user->getId())}
                                            <tr>
                                                <th>{$user->getLogin()}</th>
                                                <th>{$user->getEmail()}</th>
                                                <th class="nmb">{$user->getPhone()}</th>
                                                <th class="nmb">{$user->getPermissions()}</th>
                                                <th class="nmb">
                                                    {if $user->getBanned()}
                                                        Заблокирован
                                                    {else}
                                                        Активен
                                                    {/if}
                                                </th>
                                                <th class="nmb">{$user->getRegisterDate()}</th>
                                                <th><a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$user->getId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{/if}" class="btn btn-default btn-sm">открыть</a></th>

                                                <th><a href="/admin/profiles.php?type=edit&id={$user->getId()}" class="btn btn-default btn-sm">Редактировать</a></th>
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
                                            </tr>
                                        {/foreach}
                                    </tbody>
                                </table>
                                <input type="hidden" class="val_text" value="В данном разделе в таблице отображаются все зарегистрированные пользователи админ. панели. ">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}