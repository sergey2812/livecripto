<script src="{$template}/js/functions/sort.js"></script>
<form method="GET" >
    <select name="sort" class="obj_head_select sort_selector">
        <option value="" {if empty($filters['sort'])}selected{/if}>{t}По умолчанию{/t}</option>
        <option value="date_desc" {if !empty($filters['sort']) AND $filters['sort'] == 'date_desc'}selected{/if}>{t}По новизне{/t}</option>
        {if !empty($typeFilters)}
            <option value="price_asc" {if !empty($filters['sort']) AND $filters['sort'] == 'price_asc'}selected{/if}>{t}По возрастанию{/t}</option>
            <option value="price_desc" {if !empty($filters['sort']) AND $filters['sort'] == 'price_desc'}selected{/if}>{t}По убыванию{/t}</option>
        {/if}
    </select>
</form>