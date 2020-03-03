{foreach from=$adverts item=$advert}
    {include file='elements/advert/advert.tpl' advert=$advert}
{foreachelse}
{/foreach}

<script src="{$template}/js/functions/add_to_favorites.js"></script>

{if count($adverts) < $pageAdvertsCount}
    <script>
        $("form.no-ajax.show_more").remove();
    </script>
{/if}