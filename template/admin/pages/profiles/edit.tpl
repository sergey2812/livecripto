{include file='admin/elements/header.tpl'}

<script src="{$template}/js/admin/ad_avatar.js"></script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Редактирование пользователя</h3>
                </div>
                <div class="clearfix"></div>
                    <div class="back_btn_wallet">
                        <a href="/admin/profiles.php?type=users" class="btn btn-default btn-md">Назад, в список пользователей</a>
                    </div>                 
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel marketing__create">
                            <div class="x_content">
                                <form method="POST" class="form-horizontal form-label-left">
                                    <input type="hidden" name="avatar" id="html_code">
                                    <div class="row">
                                        <div class="col-sm-7">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="control-label">Аватар</label>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-5">
                                                        <div class="block-see avatars edit">
                                                            <div class="edit block-see__item" id="preview_block_avatar">
                                                                <div class="profiles-avatar" style="background-color: #{$profile->getColor()}">
                                                                <img src="{$files_dir}{$profile->getAvatar()}"></div>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                </div>
                                                <div class="form-group">
                                                    
                                                    <div class="marketing-create__right">
                                                        <button id="see" class="btn btn-success upload">Обзор</button>
                                                        <input type="file" class="file_input image_upload" name="avatar">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Статус:</label>
                                                    <div class="marketing-create__right">
                                                        {if $profile->getBanned()}
                                                            Заблокирован
                                                        {else}
                                                            Активен
                                                        {/if}
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Дата регистрации:</label>
                                                    <div class="marketing-create__right">
                                                        {$profile->getRegisterDate()}
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Логин:</label>
                                                    <div class="marketing-create__right">
                                                        {$profile->getLogin()}
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Почта:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="email" name="email" class="form-control" value="{$profile->getEmail()}" required>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Телефон 1:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" name="phone" class="form-control" value="{$profile->getPhone()}" required>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Роли:</label>
                                                    <div class="marketing-create__right profile__Select">
                                                        <select class="form-control" name="permissions">
                                                            <option value="1"{if $profile->getPermissions() == 1} selected{/if}>Супер-администратор</option>

                                                            <option value="2"{if $profile->getPermissions() == 2} selected{/if}>Маркетолог</option>

                                                            <option value="3"{if $profile->getPermissions() == 3} selected{/if}>Модератор</option>

                                                            <option value="4"{if $profile->getPermissions() == 4} selected{/if}>Арбитраж</option>

                                                            <option value="5"{if $profile->getPermissions() == 5} selected{/if}>Редактор</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Изменить пароль:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="password" name="password" class="form-control">
                                                    </div>
                                                </div>
                                                <div class="marketing-create__buttons">
                                                    <button class="btn btn-success btn-lg" type="submit">Сохранить</button>
                                                    <a href="/admin/profiles.php?type=users" class="btn btn-default btn-lg cancel">Отменить</a>
                                                </div>                                                 
                                            </div>
                                        </div>                                       
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}