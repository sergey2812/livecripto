{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Рекламные иконки</h3>
                    <div class="title_left">
                        <a href="/admin/ad.php?type=create-icon" class="btn btn-default btn-md">Создать</a>
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
                                        <th>Название РК</th>
                                        <th>Статус</th>
                                        <th>Дата размещения</th>
                                        <th>Дата окончания</th>
                                        <th>Раздел</th>
                                        <th>Категория</th>
                                        <th>Подкатегория</th>
                                        <th>Заголовок</th>
                                        <th>Действия</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$all_ads item=$ad}
                                        <tr>
                                            <th>{$ad->getName()}</th>
                                            <th class="nmb">
                                                {if $ad->getStatus() == 1}
                                                    В очереди
                                                {elseif $ad->getStatus() == 2}
                                                    Опубликовано
                                                {elseif $ad->getStatus() == 3}
                                                    В архиве
                                                {/if}
                                            </th>
                                            <th class="nmb">{$ad->getDateStart()}</th>
                                            <th class="nmb">{$ad->getDateEnd()}</th>
                                            <th class="nmb">{$ad->getSection()}</th>
                                            <th class="nmb">{$ad->getCategory()}</th>
                                            <th class="nmb">{$ad->getSubcategory()}</th>
                                            <th>{$ad->getTitle()}</th>
                                            <th><a href="/admin/ad.php?type=edit-icon&id={$ad->getId()}">Редактировать</a></th>
                                        </tr>
                                        {foreachelse}
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                                <input type="hidden" class="val_text" value="В данном разделе в таблице отображаются все рекламные блоки.">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}