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
                    <h3>Создание пользователя</h3>
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
                                                    <label class="control-label">Аватар:</label>
                                                    <div class="marketing-create__right">
                                                        <button class="btn btn-success upload">Обзор</button>
                                                        <input type="file" class="file_input image_upload" name="image">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Логин:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="login" required>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Почта:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="email" required>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Телефон 1:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="phone" required>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Пароль:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="password" class="form-control" name="password" required>
                                                    </div>
                                                </div>
                                                <div class="form-group small">
                                                    <label class="control-label">Роль:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control" name="permissions" required>
                                                            <option value="1">Супер-администратор</option>
                                                            <option value="2">Маркетолог</option>
                                                            <option value="3">Модератор</option>
                                                            <option value="4">Арбитраж</option>
                                                            <option value="5">Редактор</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="marketing-create__buttons">
                                                    <button class="btn btn-success btn-lg">Сохранить</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <h4>Просмотр:</h4>
                                            <div class="block-see avatars">
                                                
                                                <div class="block-see__item" id="preview_block_avatar"></div>
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