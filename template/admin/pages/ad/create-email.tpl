{include file='admin/elements/header.tpl'}

<script src="{$template}/js/admin/ad_html_email.js"></script>

<script>
$(function()
{
    $("textarea[name='html']").prop('disabled', true);
    $("textarea[name='content']").prop('disabled', false);

    $("input[name='image']").on('click', function () 
        { 
            $("textarea[name='content']").prop('disabled', true);
            $("textarea[name='content']").val('');
            $("textarea[name='html']").prop('disabled', false);
      
        }); 

    $("textarea[name='content']").on('change', function () 
        { 
            $("textarea[name='html']").val('');
        });     

});
</script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>{if $edit_mode}Редактирование{else}Создание{/if} рассылки</h3>
                </div>
                <div class="clearfix"></div>
                    <div class="back_btn_wallet">
                        <a href="/admin/ad.php?type=email" class="btn btn-default btn-md">Назад, в список всех рассылок</a>
                    </div>                 
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel marketing__create">
                            <div class="x_content">
                                <form method="POST" class="form-horizontal form-label-left">
                                    <div class="row">
                                        <div class="col-sm-7">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="control-label">Статус:</label>
                                                    <div class="marketing-create__right">
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" value="1" id="status1" name="status" class="flat" {if $edit_mode AND $ad->getStatus() == 1}checked=""{/if}> В очереди
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" value="2" id="status2" name="status" class="flat" {if $edit_mode AND $ad->getStatus() == 2}checked=""{/if}> Отправляется
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" value="3" id="status3" name="status" class="flat" {if $edit_mode AND $ad->getStatus() == 3}checked=""{/if}> В архиве
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group" style="margin-bottom: 20px; margin-left: 18px;">
                                                    <div class="marketing-create__right marketing-create__date">
                                                        <label for="">
                                                            Дата рассылки:
                                                        </label>
                                                        <fieldset>
                                                            <div class="control-group">
                                                                <div class="controls">
                                                                    <div class=" xdisplay_inputx form-group has-feedback">
                                                                        <input type="date" class="form-control has-feedback-left" name="mailing_date" {if $edit_mode}value="{$ad->getMailingDate()}"{/if}>
                                                                        <span class="fa fa-calendar-o form-control-feedback left"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Название<br> рассылки:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="name_mailing" {if $edit_mode}value="{$ad->getNameMailing()}"{/if}>
                                                    </div>
                                                </div>                                                
                                                <div class="form-group">
                                                    <label class="control-label">Выбрать способ отправки:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control" name="method">
                                                            <option value="1" {if $edit_mode AND $ad->getMethod() == 1}selected{/if}>Почта</option>
                                                            <option value="2" {if $edit_mode AND $ad->getMethod() == 2}selected{/if}>Всем</option>
                                                            <option value="3" {if $edit_mode AND $ad->getMethod() == 3}selected{/if}>Приложения моб.</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label">Заголовок письма:
                                                        <span>(до 255 знаков)</span></label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="subject" value="{if $edit_mode}{$ad->getSubject()}{/if}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Текст письма:
                                                        <span></span></label>
                                                    <div class="marketing-create__right">
                                                        <textarea class="form-control" name="content">{if $edit_mode}{$ad->getContent()}{/if}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Загрузить<br>HTML-письмо:</label>
                                                    <div class="marketing-create__right">
                                                        <button class="btn btn-success upload">Загрузить HTML-письмо</button>
                                                        <input type="file" name="image" class="image_upload file_input">
                                                    </div>
                                                </div>                                                
                                                <div class="form-group">
                                                    <label class="control-label">HTML-письмо:</label>
                                                    <div class="marketing-create__right">
                                                        <textarea name="html" class="form-control" id="html_code" readonly>{if $edit_mode}{$ad->getContentHtml()}{/if}</textarea>
                                                    </div>
                                                </div>                                                
                                                <div class="marketing-create__buttons">
                                                    <button class="btn btn-success btn-lg">Сохранить</button>
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