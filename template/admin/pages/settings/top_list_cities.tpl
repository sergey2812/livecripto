{include file='admin/elements/header.tpl'}

{include file='admin/elements/map_modal.tpl' type='city'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>ТОП: страна - {$country_name}, города, настройка цен</h3>
                </div>
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=top" class="btn btn-default btn-md">Вернуться назад, выбрать другую страну</a>
                    </div>                
                <div class="clearfix"></div>

<ul class="nav nav-tabs">
  <li class="home_top active"><a data-toggle="tab" href="#home_top_price_city">Главная</a></li>
  <li><a data-toggle="tab" href="#section_top_price_city">Разделы</a></li>
  <li><a data-toggle="tab" href="#category_top_price_city">Категории</a></li>
  <li><a data-toggle="tab" href="#subcategory_top_price_city">Подкатегории</a></li>
</ul> 

        <div class="tab-content">
            <div id="home_top_price_city" class="tab-pane fade in active">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>{$country_name} - всего городов, загруженных в систему {$countries->getCityCountByCountry($country_id)} шт.</h3>
                    </div>
                    <h3 class="title_table_top_price">Главная страница для городов страны {$country_name}</h3>                        
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="x_content table-nstr table_top4">
                                    <table id="" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <td>№<br>п/п</td>
                                            <td>Название</td>
                                            <td>Цена ТОП-1</td>
                                            <td>Цена ТОП-2</td>
                                            <td>Цена ТОП-3</td>
                                            <td>Цена ТОП-4</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$cities_top4 item=$city}
                                                <tr>
                                                    {$i = $i + 1}
                                                    <td>{$i}</td>
                                                    <td>{$city->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=home&position=1&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=home&position=2&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=home&position=3&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=home&position=4&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
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
            </div> {* это блок с панелью главная *}

            <div id="section_top_price_city" class="tab-pane fade">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>{$country_name} - всего городов, загруженных в систему {$countries->getCityCountByCountry($country_id)} шт.</h3>
                    </div>
                    <h3 class="title_table_top_price">Разделы</h3>                        
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="x_content table-nstr table_top4">
                                    <table id="" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <td>№<br>п/п</td>
                                            <td>Название</td>
                                            <td>Цена ТОП-1</td>
                                            <td>Цена ТОП-2</td>
                                            <td>Цена ТОП-3</td>
                                            <td>Цена ТОП-4</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$cities_top4 item=$city}
                                                <tr>
                                                    {$i = $i + 1}
                                                    <td>{$i}</td>
                                                    <td>{$city->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=section&position=1&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=section&position=2&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=section&position=3&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=section&position=4&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
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
            </div> {* это блок с панелью разделы *}

            <div id="category_top_price_city" class="tab-pane fade">              
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>{$country_name} - всего городов, загруженных в систему {$countries->getCityCountByCountry($country_id)} шт.</h3>
                    </div>
                    <h3 class="title_table_top_price">Категории</h3>                        
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="x_content table-nstr table_top4">
                                    <table id="" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <td>№<br>п/п</td>
                                            <td>Название</td>
                                            <td>Цена ТОП-1</td>
                                            <td>Цена ТОП-2</td>
                                            <td>Цена ТОП-3</td>
                                            <td>Цена ТОП-4</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$cities_top4 item=$city}
                                                <tr>
                                                    {$i = $i + 1}
                                                    <td>{$i}</td>
                                                    <td>{$city->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=category&position=1&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=category&position=2&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=category&position=3&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=category&position=4&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
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
            </div> {* это блок с панелью категории *}            

            <div id="subcategory_top_price_city" class="tab-pane fade">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>{$country_name} - всего городов, загруженных в систему {$countries->getCityCountByCountry($country_id)} шт.</h3>
                    </div>
                    <h3 class="title_table_top_price">Подкатегории</h3>                        
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="x_content table-nstr table_top4">
                                    <table id="" class="table table-striped table-bordered">
                                        <thead>
                                        <tr>
                                            <td>№<br>п/п</td>
                                            <td>Название</td>
                                            <td>Цена ТОП-1</td>
                                            <td>Цена ТОП-2</td>
                                            <td>Цена ТОП-3</td>
                                            <td>Цена ТОП-4</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$cities_top4 item=$city}
                                                <tr>
                                                    {$i = $i + 1}
                                                    <td>{$i}</td>
                                                    <td>{$city->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=subcategory&position=1&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=subcategory&position=2&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=subcategory&position=3&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&function=subcategory&position=4&id={$city->getId()}&name={$city->getName()}&countryid={$country_id}&countryname={$country_name}" class="btn btn-success btn-sm">редактировать</a></td>
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
            </div> {* это блок с панелью подкатегории *}            

        </div>   {* это контейнер со всеми панелями *}


            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}