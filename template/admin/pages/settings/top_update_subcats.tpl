{include file='admin/elements/header.tpl'}

{* <script src="{$template}/js/admin/top_settings.js"></script> *}

<script>
$(function()
{
    let price_massive = {};
    let crypto_code = '';
    let crypto_price = '';

    let id_country = 0;
    let id_city = 0;

    let active_section_id = 0;
    let active_category_id = 0;
    let active_subcategory_id = 0;    

    let position_top = 0; 

    const params = new Map(location.search.slice(1).split('&').map(kv => kv.split('=')))
    var abc = params.has('save');
    if (abc == true)
        {
            var save = params.get('save');
            if (save == 1)
                {
                    $('div.title_right.price_table_head_3').css('display', 'block');
                }
            else
                {
                    $('div.title_right.price_table_head_3').css('display', 'none');
                }
        }


    $("div.section_panel ul.nav.nav-tabs.bar_tabs li.section").removeClass('active');

    $("div.category_panel ul.nav.nav-tabs.bar_tabs li.category").removeClass('active');

    $("div.subcategory_panel ul.nav.nav-tabs.bar_tabs li.subcategory").removeClass('active');

    $("div.price_block").css('display', 'none');

    $("div.category_panel ul.nav.nav-tabs.bar_tabs li.category").each(function () 
        {
            $(this).css('pointer-events', 'none');
        });

    $("div.subcategory_panel ul.nav.nav-tabs.bar_tabs li.subcategory").each(function () 
        {
            $(this).css('pointer-events', 'none');
        });

    id_country = $("input[name='id_country']").val();

    id_city = $("input[name='id_city']").val();

    position_top = $("input[name='position_top']").val();



    $("div.section_panel ul.nav.nav-tabs.bar_tabs li.section").on('click', function () 
        { 
            active_section_id = $(this).data('section-active');
            $("input[name='section']").val(active_section_id);

            $("div.category_panel ul.nav.nav-tabs.bar_tabs li.category").each(function () 
                {
                    $(this).removeClass('active');
                    $(this).css('pointer-events', 'painted');
                });

            $("div.subcategory_panel ul.nav.nav-tabs.bar_tabs li.subcategory").each(function () 
                {
                    $(this).removeClass('active');
                    $(this).css('pointer-events', 'none');
                });
            $('div.title_right.price_table_head_3').css('display', 'none');
        });

    $("div.category_panel ul.nav.nav-tabs.bar_tabs li.category").on('click', function () 
        { 
            active_category_id = $(this).data('category-active');
            $("input[name='category']").val(active_category_id);

            $("div.subcategory_panel ul.nav.nav-tabs.bar_tabs li.subcategory").each(function () 
                {
                    $(this).removeClass('active');
                    $(this).css('pointer-events', 'painted');
                });            
        });

    $("div.subcategory_panel ul.nav.nav-tabs.bar_tabs li.subcategory").on('click', function () 
        { 
            active_subcategory_id = $(this).data('subcategory-active');
            $("input[name='subcategory']").val(active_subcategory_id);

            $("input.top_price_input").each(function () 
                {
                    // это функция формирования массива цен по умолчанию
                    crypto_code = $(this).attr('name');
                    crypto_price = $(this).val();

                    price_massive[crypto_code] = crypto_price;
                });
            $('input[name="price_massive"]').val(JSON.stringify(price_massive));

            id_country = $("input[name='id_country']").val();

            id_city = $("input[name='id_city']").val();

            position_top = $("input[name='position_top']").val();


            $.ajax({
                url: '/ajax/sections/get_top4_prices.php',
                type: 'POST',
                dataType: 'JSON',
                data: { active_section_id: active_section_id, active_category_id: active_category_id, active_subcategory_id: active_subcategory_id, id_country: id_country, id_city: id_city, position_top: position_top },
            })
                .done(function(data) 
                {
                    console.log("success");

                    $('div.title_right.price_table_head_1').css('display', 'block');
                    $('div.title_right.price_table_head_2').css('display', 'none');
                 
                    $.each(data, function( key, value ) 
                        {
                            $('div.table_price_for_top3 input').each(function ()
                                {
                                    if ($(this).attr('name') == key)
                                        {                   
                                            $(this).val('');
                                            $(this).val(value);
                                        }
                                });
                        });
                })
                    .fail(function() 
                    {
                        console.log("error");

                        $('div.title_right.price_table_head_1').css('display', 'none');
                        $('div.title_right.price_table_head_2').css('display', 'block');

                        $('div.table_price_for_top3 input').each(function ()
                            {
                                var min = $(this).attr('min')
                                                      
                                $(this).val('');
                                $(this).val(min);
                            });
                    })
                    .always(function() 
                    {
                        console.log("complete");
                    }); 

            $("div.price_block").css('display', 'block');

        });

    $("input.top_price_input.form-control").on('change', function () 
        {            
            // это функция формирования массива цен по изменению в input'ax
            crypto_code = $(this).attr('name');
            crypto_price = $(this).val();

            price_massive[crypto_code] = crypto_price;
     
            $('input[name="price_massive"]').val(JSON.stringify(price_massive));

        });  

        $(document).on('change', 'input[type="number"]', function (event) 
            {
                this.value = this.value.replace(/[^0-9\.]+/g, '');
                if (this.value < 0 || this.value == '') this.value = 0;
            });                   

});
</script>    


<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <form method="POST" novalidate>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>ТОП-{$position} - {if $type == 'topcountry' AND $item->getName() != 'Весь МИР'}страна - {elseif $type == 'topcountry' AND $item->getName() == 'Весь МИР'}{else}страна - {$country_name}, город - {/if}{$item->getName()}, настройка цен</h3>
                </div>
                {if $type == 'topcountry'}
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=top" class="btn btn-default btn-md">Вернуться назад, выбрать другую страну</a>
                    </div>
                {else} 
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=topcity&country_id={$country_id}&country_name={$country_name}" class="btn btn-default btn-md">Выбрать другой город в {$country_name}</a>
                    </div>    
                {/if}                                
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel config-top_5">
                            <div class="x_content">
                                <div class="acc_block">
                                    <div class="acc_item">
{*                                      <div class="acc-item_head">Разделы</div> *}
                                        <div class="acc-item_body active">
                                            <div class="section_panel" role="tabpanel" data-example-id="togglable-tabs">
                                                <ul class="nav nav-tabs bar_tabs" role="tablist">
                                                    {foreach from=$sections item=$section key=$section_index}
                                                        <li role="presentation" class="section{if $section_index == 0} active{/if}" data-section-active="{$section->getId()}">
                                                            <a href="#section_{$section->getId()}" role="tab" data-toggle="tab">{$section->getName()}</a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                                <div id="myTabContent" class="tab-content">
                                                    {foreach from=$sections item=$section key=$section_index}
                                                        <div role="tabpanel" class="tab-pane fade in {if $section_index == 0}active{/if}" id="section_{$section->getId()}">
{*                                                       {include file='admin/elements/top_inputs.tpl'}  *}
                                                        <div class="acc_item_lvl1">
{*                                                       <div class="acc-item_headLvl1">Категории</div> *}
                                                            <div class="acc-item_bodyLvl1">
                                                                <div class="category_panel" role="tabpanel" data-example-id="togglable-tabs">
                                                                    <ul class="nav nav-tabs bar_tabs" role="tablist">
                                                                        {foreach from=$section->GetCategories() item=$category key=$category_index}
                                                                            <li role="presentation" class="category{if $category_index == 0} active{/if}" data-category-active="{$category->getId()}">
                                                                                <a href="#category_{$category->getId()}" role="tab" data-toggle="tab">{$category->getName()}</a>
                                                                            </li>
                                                                        {/foreach}
                                                                    </ul>
    <div class="tab-content">
        {foreach from=$section->GetCategories() item=$category key=$category_index}
            <div role="tabpanel" class="tab-pane fade in {if $category_index == 0}active{/if}" id="category_{$category->getId()}">
{*                                                  {include file='admin/elements/top_inputs.tpl'}  *}
                <div class="acc_item_lvl2">
{*                                           <div class="acc-item_headLvl2">Подкатегории</div>  *}
                    <div class="acc-item_bodyLvl2">
                        <div class="subcategory_panel" role="tabpanel" data-example-id="togglable-tabs">
                            <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                                {foreach from=$category->GetSubcategories() item=$subcategory key=$subcategory_index}
                                    <li role="presentation" class="subcategory{if $subcategory_index == 0} active{/if}"data-subcategory-active="{$subcategory->getId()}">
                                        <a href="#subcategory_{$subcategory->getId()}" role="tab" data-toggle="tab">{$subcategory->getName()}</a>
                                    </li>
                                {/foreach}
                            </ul>
                            <div id="myTabContent" class="tab-content">
                                {foreach from=$category->GetSubcategories() item=$subcategory key=$subcategory_index}
                                    <div role="tabpanel" class="tab-pane fade in{if $subcategory_index == 0} active{/if}" id="subcategory_{$subcategory->getId()}">
                                        {include file='admin/elements/top_inputs.tpl'}
                                    </div>
                                {/foreach}
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    {/foreach}
    <div class="title_right price_table_head_3" style="display: none; margin-top: -3.5em;">
        <h3>Цены сохранены в БД.<br>Вы можете выбирать новые разделы!</h3>
    </div>                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
{*                <button type="submit" class="btn btn-danger btn-lg btn-block">Сохранить</button> *}

            </form>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}