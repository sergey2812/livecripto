{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>ОБНОВИТЬ: все Страны, настройка цен</h3>              
                </div>               
                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему {$countries->getCountryCount()-1} шт.</h3>
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
                                            <td>Название страны</td>
                                            <td>Цены для городов страны</td>
                                        </tr>
                                        </thead>
                                        {$i = 0}
                                        <tbody> 
                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() == 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td>
                                                            <a href="/admin/settings.php?type=updtcity&function=new&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">цены для всего мира</a>     
                                                    </td>
                                                {/if}
                                                </tr>
                                            {/foreach}

                                            {foreach from=$locations item=$country}
                                                <tr>
                                                {if $country->getId() != 220}
                                                {$i = $i+1}
                                                    <td>{$i}</td>
                                                    <td>{$country->getName()}</td>
                                                    <td>
                                                            <a href="/admin/settings.php?type=updtcity&country_id={$country->getId()}&country_name={$country->getName()}" class="btn btn-success btn-sm">открыть</a>     
                                                    </td>
                                                {/if}
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