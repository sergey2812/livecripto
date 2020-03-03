{include file='admin/elements/header.tpl'}

{include file='admin/elements/map_modal.tpl' type='country'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>ТОП: весь Мир и все Страны, настройка цен</h3>               
                </div>               
                <div class="clearfix"></div>

        <ul class="nav nav-tabs">
          <li class="home_top active"><a data-toggle="tab" href="#home_top_price">Главная</a></li>
          <li class="section_top"><a data-toggle="tab" href="#section_top_price">Разделы</a></li>
          <li class="category_top"><a data-toggle="tab" href="#category_top_price">Категории</a></li>
          <li class="subcategory_top"><a data-toggle="tab" href="#subcategory_top_price">Подкатегории</a></li>
        </ul> 

        <div class="tab-content">

            <div id="home_top_price" class="tab-pane fade in active">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему {$countries->getCountryCount()-1} шт.</h3>
                    </div>
                        <h3 class="title_table_top_price">Главная страница для Мира и Стран</h3>
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
                                            <td>Города</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() == 220}
                                                    <td>0</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td></td>
                                                {/if}
                                                </tr>
                                            {/foreach}
                                                    
                                                
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() != 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=home&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">открыть</a></td>
                                                {/if}
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
            </div> {* это блок с панелью главная страница *}

            <div id="section_top_price" class="tab-pane fade">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему {$countries->getCountryCount()-1} шт.</h3>
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
                                            <td>Города</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() == 220}
                                                    <td>0</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td></td>
                                                {/if}
                                                </tr>
                                            {/foreach}
                                                    
                                                
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() != 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=section&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">открыть</a></td>
                                                {/if}
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

            <div id="category_top_price" class="tab-pane fade">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему {$countries->getCountryCount()-1} шт.</h3>
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
                                            <td>Города</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() == 220}
                                                    <td>0</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td></td>
                                                {/if}
                                                </tr>
                                            {/foreach}
                                                    
                                                
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() != 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=category&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">открыть</a></td>
                                                {/if}
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

            <div id="subcategory_top_price" class="tab-pane fade">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему {$countries->getCountryCount()-1} шт.</h3>
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
                                            <td>Города</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody>
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() == 220}
                                                    <td>0</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td></td>
                                                {/if}
                                                </tr>
                                            {/foreach}
                                                    
                                                
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() != 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=1&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=2&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=3&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcountry&function=subcategory&position=4&id={$country->getId()}&name={$country->getName()}&countryid={$country->getId()}&countryname={$country->getName()}" class="btn btn-success btn-sm">редактировать</a></td>
                                                    <td><a href="/admin/settings.php?type=topcity&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">открыть</a></td>
                                                {/if}
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