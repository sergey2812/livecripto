{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>ОБНОВИТЬ: страна - {$country_name}, города, настройка цен</h3>
                </div>
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=update" class="btn btn-default btn-md">Вернуться назад, выбрать другую страну</a>
                    </div>                
                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>{$country_name} - всего городов, загруженных в систему {$countries->getCityCountByCountry($country_id)} шт.</h3>
                    </div>                
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="x_content table-nstr table_top4">
                                    <table id="" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <td>№<br>п/п</td>
                                            <td>Название города</td>
                                            <td>Цены для городов</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$cities_top4 item=$city}
                                                <tr>
                                                    {$i = $i + 1}
                                                    <td>{$i}</td>
                                                    <td>{$city->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=updtcity&function=edit&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                </tr>
                                            {foreachelse}
                                                <tr>
                                                    <td colspan="6">В этом регионе пока что нет городов</td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                    <input type="hidden" class="val_text" value="На данной странице отображаются все категории объявлений на сайте">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}