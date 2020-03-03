{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Настройки SMTP</h3>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel marketing__create config__smpt">
                            <div class="x_content">
                                <form method="POST" class="form-horizontal form-label-left">
                                    <div class="row">
                                        <div class="col-sm-7">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="control-label">SMTP-сервер:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="smtp_server" value="{$settings->Get('smtp_server')}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">SMTP-порт:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="smtp_port" value="{$settings->Get('smtp_port')}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Режим подключения:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control" name="smtp_type">
                                                            {$type = $settings->Get('smtp_type')}
                                                            <option value="tls" {if $type == 'tls'}selected{/if}>TLS</option>
                                                            <option value="ssl" {if $type == 'ssl'}selected{/if}>SSL</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Логин:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="smtp_login" value="{$settings->Get('smtp_login')}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Пароль:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="password" class="form-control" name="smtp_password" value="{$settings->Get('smtp_password')}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">E-mail:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="smtp_email" value="{$settings->Get('smtp_email')}">
                                                    </div>
                                                </div>
                                                <div class="marketing-create__buttons">
                                                    <button class="btn btn-success btn-lg" type="submit">Сохранить</button>
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