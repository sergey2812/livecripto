{foreach from=$all_adverts item=$one_advert}
    {include file='admin/pages/adverts/advert.tpl' advert=$one_advert}
{foreachelse}
{/foreach}

{if count($all_adverts) < $pageAdvertsCount}
    <script>
        $("form.no-ajax.show_more").remove();
    </script>
{/if}
