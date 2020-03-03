<script src="{$template}/js/functions/get_categories.js"></script>

<form method="GET" action="/admin/adverts.php?type=search" class="form-horizontal form-label-left">
    <div class="row">
        <div class="col-sm-3">
            <div class="form-group">
                <label class="control-label col-md-5 col-sm-5 col-xs-12">Показать по статусу:</label>
                <div class="col-md-7 col-sm-7 col-xs-12">
                    <select class="form-control" name="type">
                        <option value="">Все</option>
                        <option value="1" {if !empty($filters['type']) AND $filters['type'] == '1'}selected{/if}>На модерации</option>
                        <option value="2" {if !empty($filters['type']) AND $filters['type'] == '2'}selected{/if}>Активные</option>
                        <option value="3" {if !empty($filters['type']) AND $filters['type'] == '3'}selected{/if}>В архиве</option>
                        <option value="4" {if !empty($filters['type']) AND $filters['type'] == '4'}selected{/if}>Заблокированные</option>
                        <option value="5" {if !empty($filters['type']) AND $filters['type'] == '5'}selected{/if}>Арбитраж</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="filter-item">
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Раздел</label>
                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <select class="form-control section_select" data-target="#category" data-type="categories" name="section">
                            <option value="">Все</option>
                            {foreach from=$sections item=$section}
                                <option value="{$section->getId()}" {if !empty($filters['section']) AND $filters['section'] == $section->getId()}selected{/if}>{$section->getName()}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Категория</label>
                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <select class="form-control category_select" id="category" name="category" data-target="#subcategory" data-type="subcategories">
                            {if !empty($selected_section_categories)}
                                <option value="">Выбрать</option>
                                {foreach from=$selected_section_categories item=$category}
                                    <option value="{$category->getId()}" {if !empty($filters['category']) AND $filters['category'] == $category->getId()}selected{/if}>{$category->getName()}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Подкатегория</label>
                    <div class="col-md-8 col-sm-8 col-xs-12">
                        <select class="form-control" id="subcategory" name="subcategory">
                            {if !empty($selected_category_subcategories)}
                                <option value="">Выбрать</option>
                                {foreach from=$selected_category_subcategories item=$subcategory}
                                    <option value="{$subcategory->getId()}" {if !empty($filters['subcategory']) AND  $filters['subcategory'] == $subcategory->getId()}selected{/if}>{$subcategory->getName()}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
                {*<div class="form-group">*}
                    {*<label class="control-label col-md-4 col-sm-4 col-xs-12">Отсортировать</label>*}
                    {*<div class="col-md-8 col-sm-8 col-xs-12">*}
                        {*<select class="form-control">*}
                            {*<option>По новизне</option>*}
                        {*</select>*}
                    {*</div>*}
                {*</div>*}
            </div>
        </div>
        <div class="col-sm-4">
            <div class="filter-item">
                <div class="form-group">
                    <label class="control-label col-md-5 col-sm-5 col-xs-12">Дата размещения</label>
                    <div class="col-md-7 col-sm-7 col-xs-12">
                        <select class="form-control" type="date_start" name="date">
                            <option value="">Все</option>
                            <option value="{date('Y-m-d H:i:s', strtotime('-24 hours'))}" {if !empty($filters['date']) AND $filters['date'] !== ''}selected{/if}>За последние 24 часа</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-5 col-sm-5 col-xs-12">Оплата</label>
                    <div class="col-md-7 col-sm-7 col-xs-12">
                        <select class="form-control" name="secure_deal">
                            <option value="">Все</option>
                            <option value="1" {if !empty($filters['secure_deal']) AND $filters['secure_deal'] == '1'}selected{/if}>Безопасная сделка</option>
                            <option value="0" {if !empty($filters['secure_deal']) AND $filters['secure_deal'] == '0'}selected{/if}>Прямая оплата</option>
                        </select>
                    </div>
                </div>
                    <div class="form-row form-group filter_price">
                        <label class="control-label col-md-5 col-sm-5 col-xs-12">Крипта</label>
                        <select name="" id="filter_val" class="form-control filter_select">
                            <option value="Выберите криптовалюту" data-first="true">{t}Выберите крипту{/t}</option>
                            {foreach from=$currencies item=$cur}
                                <option value="{$cur['code']}" data-image="{$template}/img/{mb_strtolower({$cur['code']})}.png"{if !empty($filters['prices']) AND $filters['prices'] == $cur['code']} selected{/if}>{$cur['name']}</option>
                            {/foreach}
                        </select>                        
                    </div>
                <div class="form-row cs__purse form-group filter_price" {if !empty($typeFilters)}style="display: block;"{/if}>
                    
                    {if !empty($typeFilters)}
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
                    {/if}
                </div>
                </div>
                <div class="form-group filter_price">
                    <div class="col-sm-7 col-md-7 col-sm-offset-5 col-xs-12">
                        <button class="btn btn-success btn-sm">Применить фильтр</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>