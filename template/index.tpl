{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/get_categories.js"></script>
{* <script src="{$template}/js/functions/show_more.js"></script> *}

<script>
$(function(){

    $('.show_more').on('submit', function (e) {
        e.preventDefault();

        let button = $(this).find('button');       
        let page_input = $(this).find("input[name='page']");
        let page = parseInt(page_input.val()) + 1;

          $(".obj-info .show_more").animate({ bottom: "-1.15%" }, 3000 );

        $.ajax({
            url: '/ajax/adverts/get_next_adverts.php',
            type: 'POST',
            dataType: 'html',
            data: $(this).serialize(),
        })
            .done(function(data) {
                if (data === ''){
                    button.remove();
                } else{
                    $('.items-append-here').append(data);
                    page_input.val(page);

                    let hgtHomeAdv = $('.obj-body').height();

                    $('.obj-info').css({ "height": hgtHomeAdv-125 });
                    $('.obj-filter').css({ "height": hgtHomeAdv });
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

<script>   
    $(function()
    {                
        let country_select = '';

        $("#filter_country").on('change', function() 
          {         
            country_select = $(this).val();

            let citySelect = $('#filter_city');
            
            $.ajax({
                url: '/ajax/sections/get_country_id.php',
                type: 'POST',
                dataType: 'JSON',
                data: { country_id: country_select },
            })
                            .done(function(data) 
                            {
                                console.log("success");

                                citySelect.html(''); // очищаем список городов
                                
                                // заполняем список городов новыми пришедшими данными
                                citySelect.append('<option value="Выберите город" data-first="true" selected disabled>Выберите город</option>');
                                
                                $.each(data, function(i) 
                                {
                                    citySelect.append('<option value="' + data[i].name + '">' + data[i].name + '</option>');
                             
                                });


                            })
                                .fail(function() 
                                {
                                    console.log("error");

                                        citySelect.html(''); // очищаем список городов
                                        
                                        // заполняем список городов новыми пришедшими данными
                                        citySelect.append('<option value="Выберите город" data-first="true" selected disabled>Выберите город</option>');

                                        citySelect.append('<option value=""></option>');

                                })
                                .always(function() 
                                {
                                    console.log("complete");
                                });
            });

    })         
</script>


<div id="slider" style="padding: 23px 0 20px;">
    <div class="owl-carousel owl-slider">
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');">{$adsSlider1}</div>
            </a>
        </div>
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');">{$adsSlider2}</div>
            </a>
        </div>
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');">{$adsSlider3}</div>
            </a>
        </div>
    </div>
</div>

<div id="best">
    <div class="container-fluid" style="width: 960px !important;">
      <div class="row">
        <div class="col-xs-3">
        {if isset($advert1)}
            {include file='elements/main/best_new.tpl' advert=$advert1}
        {/if}  
        </div>
        <div class="col-xs-3">
        {if isset($advert2)}
            {include file='elements/main/best_new.tpl' advert=$advert2}
        {/if}            
        </div>
        <div class="col-xs-3">
        {if isset($advert3)}
            {include file='elements/main/best_new.tpl' advert=$advert3}
        {/if}            
        </div>
        <div class="col-xs-3">
        {if isset($advert4)}
            {include file='elements/main/best_new.tpl' advert=$advert4}
        {/if}           
        </div>                        
      </div>
    </div>
</div>

    <div class="clearfix"></div>
<div id="cats" class="text-center">
    <div class="container">
        <ul>
            {if !empty($adsIcons)}
                {foreach from=$adsIcons item=$ad}
                    <li>
                        {$ad->getContent()}
                        <span>{$ad->getTitle()}</span>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
</div>

<div id="objects">
    <div class="container">
        <div class="obj-head">
            <div class="row">
                <div class="col-xs-7 col-sm-offset-3">
                    <div class="row">
                        <div class="col-xs-7">
                            <div class="obj-head_title">{t}Все объявления{/t} <span>{$advertsCount}</span></div>
                        </div>
                        <div class="col-xs-5 text-right">
                            {include file='elements/main/sort.tpl'}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <form class="col-xs-3 obj-filter no-ajax">
                {if !empty($filters['search'])}
                    <input type="hidden" name="search" value="{$filters['search']}">
                {/if}
                <div class="form-row">
                    <select name="" id="filter_val" class="filter_select">
                        <option value="Выберите криптовалюту" data-first="true">{t}Выберите криптовалюту{/t}</option>
                        {foreach from=$currencies item=$cur}
                            <option value="{$cur['code']}" data-image="{$template}/img/{mb_strtolower({$cur['code']})}.png">{$cur['name']}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-row cs__purse" {if !empty($typeFilters)}style="display: block;"{/if}>
                    {foreach from=$typeFilters key=$type item=$value}
                        <div class="choice-purse__minmax" data-icon="/template/img/{mb_strtolower($type)}.png">
                            <label><img src="/template/img/{mb_strtolower($type)}.png" alt="" width="45"></label>
                            <div class="home-content-filter_check">
                                <input type="text" name="{$type}_min" id="min" placeholder="От" maxlength="8" value="{$value['min']}">
                            </div>
                            <div class="home-content-filter_check">
                                <input type="text" name="{$type}_max" placeholder="До" maxlength="8" value="{$value['max']}">
                            </div>
                            <div class="close">X</div>
                        </div>
                    {foreachelse}
                    {/foreach}
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['section'])}class="active"{/if}>{t}Раздел{/t}</span>
                        <div class="obj-filter-block_body section-filter" data-type="categories" data-target="filter-block-categories" {if !empty($filters['section'])}style="display: block;"{/if}>
                            {foreach from=$sections item=$section}
                                <div>
                                    <input type="radio" name="section" value="{$section->getId()}" {if !empty($filters['section']) AND in_array($section->getId(), $filters['section'])}checked{/if}>
                                    <label>{$section->getName()}</label>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
                <div id="category_block" class="form-row">
                    <div class="obj-filter_block {if empty($filters['section'])}blocked{/if}">
                        <span {if !empty($filters['section'])}class="active"{/if}>{t}Категория{/t}</span>
                        <div class="obj-filter-block_body category-filter" id="filter-block-categories" data-type="subcategories" data-target="filter-block-subcategories" {if !empty($filters['category'])}style="display: block;"{/if}>
                            {if !empty($selected_section_categories)}
                                {foreach from=$selected_section_categories item=$category}
                                    <div>
                                        <input type="radio" name="category" value="{$category->getId()}" {if !empty($filters['category']) AND $filters['category'] == $category->getId()}checked{/if}>
                                        <label>{$category->getName()}</label>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </div>
                <div id="subcategory_block" class="form-row">
                    <div class="obj-filter_block {if empty($filters['category'])}blocked{/if}">
                        <span {if !empty($filters['section'])}class="active"{/if}>{t}Подкатегория{/t}</span>
                        <div class="obj-filter-block_body subcategory-filter" id="filter-block-subcategories" {if !empty($filters['subcategory'])}style="display: block;"{/if}>
                            {if !empty($selected_category_subcategories)}
                                {foreach from=$selected_category_subcategories item=$category}
                                    <div>
                                        <input type="radio" name="subcategory" value="{$category->getId()}" {if !empty($filters['subcategory']) AND $filters['subcategory'] == $category->getId()}checked{/if}>
                                        <label>{$category->getName()}</label>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['securedeal'])}class="active"{/if}>{t}Тип оплаты{/t}</span>
                        <div class="obj-filter-block_body" {if !empty($filters['securedeal'])}style="display: block;"{/if}>
                            <div>
                                <input type="checkbox" name="securedeal[]" {if !empty($filters['securedeal']) AND in_array('on', $filters['securedeal'])}checked{/if}>
                                <label>{t}Безопасная сделка{/t}</label>
                            </div>
                            <div>
                                <input type="checkbox" name="securedeal[]" value="off" {if !empty($filters['securedeal']) AND in_array('off', $filters['securedeal'])}checked{/if}>
                                <label>{t}Прямая сделка{/t}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row" style="text-align: center;">
                    <select name="location" id="filter_country" class="filter_select country_select" data-type="cities" data-target="filter_city">
                        <option value="" data-first="true">{t}Выберите страну{/t}</option>
                        {foreach from=$locations item=$location}
                            <option value="{$location->getId()}" {if !empty($_GET['location']) AND $_GET['location'] == $location->getId()}selected{/if}>{$location->getName()}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-row form-row--city blocked" style="text-align: center;">
                    <select name="location_name" id="filter_city" class="filter_select city-filter">
                        <option value="" data-first="true">{t}Выберите город{/t}</option>
                        {if !empty($selectedCities)}
                            {foreach from=$selectedCities item=$city}
                                <option value="{$city->getName()}" {if !empty($_GET['location_name']) AND $_GET['location_name'] == $city->getName()}selected{/if}>{$city->getName()}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['delivery'])}class="active"{/if}>{t}Способ получения{/t}</span>
                        <div class="obj-filter-block_body" {if !empty($filters['delivery'])}style="display: block;"{/if}>
                            <div>
                                <input type="checkbox" name="delivery[]" value="on" {if !empty($filters['delivery']) AND in_array('on', $filters['delivery'])}checked{/if}>
                                <label>{t}Личная встреча{/t}</label>
                            </div>
                            <div>
                                <input type="checkbox" name="delivery[]" value="off" {if !empty($filters['delivery']) AND in_array('off', $filters['delivery'])}checked{/if}>
                                <label>{t}Передача через сеть{/t}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <button id="search_begin" class="btn-submit">{t}Начать поиск{/t}</button>

                <div class="home-converter" style="margin-top: 47px">
                    {include file='elements/main/rates.tpl' rates=$today_rates_widget}
                </div>

                <div class="text-center go-top_btn">
                    <a href="#top" class="go-top text-center">
                        <span>Наверх</span>
                        <svg version="1.1" id="не_закрашена" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                             x="0px" y="0px" viewBox="0 0 180.7 181.8" enable-background="new 0 0 180.7 181.8" xml:space="preserve">
                            <polygon fill="#CFD0CF" points="30.8,130.4 90.6,35.5 149.9,130.8 89.5,113.7 "/>
                            <circle fill="none" stroke="#CFD0CF" stroke-width="2" stroke-miterlimit="10" cx="90.3" cy="91" r="89"/>
                        </svg>
                    </a>
                </div>

            </form>
            <div class="col-xs-7 obj-body">
                <div class="row items-append-here">
                    {if $advertsCount > 0}
                        {foreach from=$adverts item=$advert}
                            {include file='elements/advert/advert.tpl'}
                        {foreachelse}
                            <h3 class="text-center">{t}Объявлений не найдено{/t}</h3>
                        {/foreach}
                    {else}
                        {include file='elements/main/notfound_adverts.tpl'}
                    {/if}
                </div>
            </div>
            <div class="col-xs-2 obj-info">
                <div class="home_advertising">
                    <div class="advertising-item">
                        {if $adsBlock1 != ''}
                            {$adsBlock1}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
                    <div class="advertising-item">
                        {if $adsBlock2 != ''}
                            {$adsBlock2}
                        {else}
                            <div class="advertising-item_head text-center">
                                <span>Номер 8-800</span>
                                <img src="img/r-icon.png" alt="">
                                <p>без абонентской<br> платы</p>
                            </div>
                            <div class="advertising-item_foot">
                                <b>Номер 8800 от Ростелекома</b>
                                <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                            </div>                        
                        {/if}
                    </div>
                </div>
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
                    {if !empty($filters['sort'])}
                        <input type="hidden" name="sort" value="{$filters['sort']}">
                    {/if}

                    {if $advertsCount > 64}
                        <button type="submit" href="#" class="get-more text-center" style="background: transparent;border: 0;">
                            <svg version="1.1" id="не_закрашена" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 180.7 181.8" enable-background="new 0 0 180.7 181.8" xml:space="preserve">
                                <polygon fill="#CFD0CF" points="30.8,130.4 90.6,35.5 149.9,130.8 89.5,113.7 "></polygon>
                                <circle fill="none" stroke="#CFD0CF" stroke-width="2" stroke-miterlimit="10" cx="90.3" cy="91" r="89"></circle>
                            </svg>
                            <span>Показать еще</span>
                        </button>
                    {/if}
                </form>
            </div>
        </div>
    </div>
</div>

{include file='elements/main/footer.tpl'}