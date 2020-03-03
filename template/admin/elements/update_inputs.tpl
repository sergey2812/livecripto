{$section_id = $section->getId()}
{$category_id = (!empty($category)) ? $category->getId() : 0}
{$subcategory_id = (!empty($subcategory)) ? $subcategory->getId() : 0}

<div class="price_block section_{$section->getId()} category_{$category_id} subcategory_{$subcategory_id}" style="display: none;">
    <div class="title_right price_table_head_1">
        <h4>Эти цены ЕСТЬ в БД.<br>Вы можете их редактировать!</h4>
    </div>
    <div class="title_right price_table_head_2">
        <h4>По указанным параметрам цен в БД НЕТ.<br>Вы можете их создать, взяв за основу цифры в таблице!</h4>
    </div>                      
        <table id="" class="table table-striped table-bordered length_td">
            <thead>
            <tr>
                <td>№<br>п/п</td>
                <td><div class="table_price_for_top00">Цена</div></td>
                <td>Крипта</td>
            </tr>
            </thead>
            {$n = 0}
            {foreach from=$all_cryptos item=$crypto}
            <tbody>
                <tr>
                    {$n = $n + 1}
                    <td><div class="table_price_for_top12">{$n}</div></td>
                    <td>
                        <div class="table_price_for_top3">
                            <input type="number" step="0.00000001" min="0.00000777" class="top_price_input form-control" name="{$crypto['code']}" value="0.00000777">
                        </div>
                            </td>
                            <td><div class="crypto-image"><img src="{$template}/img/{mb_strtolower({$crypto['code']})}.png"></div><div class="table_price_for_top" >{$crypto['code']}</div></td>
                </tr>
            </tbody>
            {/foreach}
        </table>
                <input type="hidden" class="val_text" value="На данной странице отображаются все категории объявлений на сайте">

        <div class="form-group submit_vl">
            <input type="hidden" name="function" value="keep_price_row"> 
            
            <input type="hidden" name="id_country" value="{$country_id}">
            <input type="hidden" name="id_city" value="{if isset($item->getId())}{$item->getId()}{/if}"> 

            <input type="hidden" name="section" value=""> 
            <input type="hidden" name="category" value=""> 
            <input type="hidden" name="subcategory" value=""> 


            <input type="hidden" name="price_massive" value="">
            <label class="control-label"></label>
            <button class="btn btn-success btn-lg accept_to_childs" data-childs=".section_{$section->getId()}, .category_{$category_id}, .subcategory_{$subcategory_id}" type="submit">Сохранить изменения</button>
        </div>
   
</div>