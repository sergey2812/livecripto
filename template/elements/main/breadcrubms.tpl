<div class="product-single_head">
    <div class="container">
        <div class="row">
            <div class="col-xs-10">
                <div class="breadcrumbs">
                    <ul>
                        {foreach from=$breadcrumbs item=$crumb key=$i}
                            {if !empty($crumb['link'])}
                                <li><a href="{$crumb['link']}">{$crumb['name']}</a></li>
                            {else}
                                <li class="current">{$crumb['name']}</li>
                            {/if}
                        {foreachelse}
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>