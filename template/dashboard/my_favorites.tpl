{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/show_more.js"></script>

{include file='elements/main/breadcrubms.tpl'}
<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                <div class="lk-border lk-block_products">
                    <div class="row items-append-here">
                        {foreach from=$adverts item=$advert}
                            {include file='elements/advert/advert.tpl'}
                            {foreachelse}
                            <h3 class="text-center">{t}Объявлений не найдено{/t}</h3>
                        {/foreach}
                    </div>


                {if $user != false && $user->getFavorites() != '' && $user->getFavorites() != NULL && $user->getFavorites() != false}

                    {if $Users->getFavoritesRealCount($user->getFavorites()) > 16}
                        <div class="text-center">
                            <form class="no-ajax show_more" style="margin-bottom: 30px;">
                                <input type="hidden" name="type" value="favorites">
                                <input type="hidden" name="page" value="1">
                                <button type="submit" class="lk-favourite_more">Показать еще</button>
                            </form>
                        </div>
                    {/if}
                
                {else}
                        <span></span>
                {/if}


                </div>
            </div>
        </div>
    </div>
</div>

{include file='elements/main/footer.tpl'}