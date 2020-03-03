{include file='admin/elements/header.tpl'}

<script src="{$template}/js/functions/get_categories.js"></script>
<script src="{$template}/js/admin/ad_functions.js"></script>
<script src="{$template}/js/admin/del_image.js"></script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>{if $edit_mode}Редактирование{else}Создание{/if} рекламного блока</h3>
                </div>
                <div class="clearfix"></div>
                    <div class="back_btn_wallet">
                        <a href="/admin/ad.php?type=block" class="btn btn-default btn-md">Назад, в список всех блоков</a>
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
                                                                <input type="radio" value="2" id="status2" name="status" class="flat" {if $edit_mode AND $ad->getStatus() == 2}checked=""{/if}> Опубликовано
                                                            </label>
                                                        </div>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" value="3" id="status3" name="status" class="flat" {if $edit_mode AND $ad->getStatus() == 3}checked=""{/if}> В архиве
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Дата размещения:</label>
                                                    <div class="marketing-create__right marketing-create__date">
                                                        <fieldset>
                                                            <div class="control-group">
                                                                <div class="controls">
                                                                    <div class="xdisplay_inputx form-group has-feedback">
                                                                        <input type="date" class="form-control has-feedback-left" name="date_start" {if $edit_mode}value="{$ad->getDateStart()}"{/if}>
                                                                        <span class="fa fa-calendar-o form-control-feedback left"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                        <label for="">
                                                            Дата окончания:
                                                        </label>
                                                        <fieldset>
                                                            <div class="control-group">
                                                                <div class="controls">
                                                                    <div class=" xdisplay_inputx form-group has-feedback">
                                                                        <input type="date" class="form-control has-feedback-left" name="date_end" {if $edit_mode}value="{$ad->getDateEnd()}"{/if}>
                                                                        <span class="fa fa-calendar-o form-control-feedback left"></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Выбрать вид рекламы:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control" name="position">
                                                            <option value="1" {if $edit_mode AND $ad->getPosition() == 1}selected{/if}>Верхний баннер</option>
                                                            <option value="2" {if $edit_mode AND $ad->getPosition() == 2}selected{/if}>Слайдер 1</option>
                                                            <option value="3" {if $edit_mode AND $ad->getPosition() == 3}selected{/if}>Слайдер 2</option>
                                                            <option value="4" {if $edit_mode AND $ad->getPosition() == 4}selected{/if}>Слайдер 3</option>
                                                            <option value="5" {if $edit_mode AND $ad->getPosition() == 5}selected{/if}>Главная страница № 1</option>
                                                            <option value="6" {if $edit_mode AND $ad->getPosition() == 6}selected{/if}>Главная страница № 2</option>
                                                            <option value="7" {if $edit_mode AND $ad->getPosition() == 7}selected{/if}>Страница объявления № 1</option>
                                                            <option value="8" {if $edit_mode AND $ad->getPosition() == 8}selected{/if}>Страница объявления № 2</option>
                                                            <option value="9" {if $edit_mode AND $ad->getPosition() == 9}selected{/if}>Страница размещения объявления № 1</option>
                                                            <option value="10" {if $edit_mode AND $ad->getPosition() == 10}selected{/if}>Страница размещения объявления № 2</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Название<br> рекламного блока:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="name" {if $edit_mode}value="{$ad->getName()}"{/if}>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Выбрать раздел:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control category_select" id="section" name="section" data-target="#category" data-type="categories">
                                                            <option value="" disabled selected>Сделайте выбор</option>
                                                            {foreach from=$sections item=$section}
                                                                <option value="{$section->getId()}" {if $edit_mode AND $section->getId() == $ad->getSection()}selected{/if}>{$section->getName()}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Выбрать категорию:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control category_select" id="category" name="category" data-target="#subcategory" data-type="subcategories">
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Выбрать<br> подкатегорию:</label>
                                                    <div class="marketing-create__right">
                                                        <select class="form-control" name="subcategory" id="subcategory">
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Загрузить<br> изображение:</label>
                                                    <div class="marketing-create__right">
                                                        <button class="btn btn-success upload">Обзор</button>
                                                        <input type="file" name="image" class="image_upload file_input">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Указать ссылку:</label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control link_input">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Вставить HTML:</label>
                                                    <div class="marketing-create__right">
                                                        <textarea name="html" class="form-control" id="html_code">{if $edit_mode}{$ad->getContent()}{/if}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Заголовок:
                                                        <span>(до 30 знаков)</span></label>
                                                    <div class="marketing-create__right">
                                                        <input type="text" class="form-control" name="title" value="{if $edit_mode}{$ad->getTitle()}{/if}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Описание:
                                                        <span>(до 60 знаков)</span></label>
                                                    <div class="marketing-create__right">
                                                        <textarea class="form-control" name="description">{if $edit_mode}{$ad->getDescription()}{/if}</textarea>
                                                    </div>
                                                </div>
                                                <div class="marketing-create__buttons">
                                                    <button class="btn btn-success btn-lg">Сохранить</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <div class="block-see">
                                                <div id="photo_close_0" class="close-select photo_photo_close" style="display: none; margin-top: 15px; margin-right: -125px; background: white; border-style: solid; border-color: #C33; border-radius: 100%; border-width: 1.0px; z-index: 25; cursor: pointer; padding: 0px 6.5px;"></div>
                                                <h4>Просмотр:</h4>
                                                <div class="block-see__item" id="preview_block">{if $edit_mode}{$ad->getContent()}{/if}</div>
                                                <p class="block-see_size active">Размер объявления: высота 35px</p>
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