{include file='admin/elements/header.tpl'}

<script>
$(function(){

    $('.show_more').on('submit', function (e) {
        e.preventDefault();

        let button = $(this).find('button');       
        let page_input = $(this).find("input[name='page']");
        let page = parseInt(page_input.val()) + 1;

        $.ajax({
            url: '/ajax/adverts/admin_get_next_adverts.php',
            type: 'POST',
            dataType: 'html',
            data: $(this).serialize(),
        })
            .done(function(data) {
                if (data === ''){
                    button.remove();
                } else{
                    $('#ajax_append').append(data);
                    page_input.val(page);

                }
            })
            .fail(function(data) {
                console.log(data);
            })
            .always(function(data) {
                //console.log(data);
            });

    });
});
</script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main" style="margin-bottom: 2.7em;">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <div class="title_left">
                        <h3>{$title_type}</h3>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    
                        <div class="x_panel filter-box">
                            <div class="x_title">
                                <h2>Фильтр</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content filter__obj">
                                {include file='admin/pages/adverts/search_block.tpl'}
                            </div>
                        </div>
                    
                </div>
                <div class="products-wrap">
                    <div class="row" id="ajax_append">
                        {foreach from=$all_adverts item=$advert}
                            {include file='admin/pages/adverts/advert.tpl' advert=$advert}
                        {foreachelse}
                            <h4 class="text-center">Объявлений не найдено</h4>
                        {/foreach}
                    </div>       

                    <div class="text-center admin_page">
                        <form class="no-ajax show_more">
                    {foreach from=$filters item=$value key=$name}
                        {if $name == 'page'}
                            <input type="hidden" name="{$name}" value="{$value+1}">
                        {else}
                            {if is_array($value)}
                                {foreach from=$value item=$val}
                                    <input type="hidden" name="{$name}" value="{$val}">
                                {/foreach}
                            {else}
                                <input type="hidden" name="{$name}" value="{$value}">
                            {/if}
                        {/if}
                    {/foreach}

                            {if empty($filters['page'])}
                                <input type="hidden" name="page" value="1">
                            {/if}
                            {if count($all_adverts) > 64}
                                <button type="submit" class="yel-button">{t}Показать ещё{/t}</button>
                            {/if}
                        </form>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}