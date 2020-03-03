{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    $('#wallet_delete_modal_form').modal({
         keyboard: true,
         backdrop: 'static',
       });

    let id_crypto = $('input[name="id_crypto_2"]').val();

        if (id_crypto == '')
        {
            $('wallet_delete_modal_form').css("display", "none");
        }
    else
        {
            $('.wallet_delete_modal_form').css("display", "block");
        }

      // .modal_wallet_delete_btn - элемент, которому необходимо установить фокус
      $('.modal_wallet_delete_btn').focus();
});
</script>

{if !empty($id_crypto)}

    <div id="wallet_delete_modal_form" class="modal" aria-hidden="true">
     <div class="modal-content wallet_delete">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
        <div class="mod_title">Удалить<br>эту крипту из системы?</div>       
        <div class="add-review_head text-center">  
        <div class="delete_crypto-image"><img src="{$template}/img/{$img_crypto}.png"></div>
        </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-row">
                        <form class="button_wallet_delete_modal_form" method="POST">
                            <input type="hidden" name="function" value="delete-yes">
                            <input type="hidden" name="crypto" value="{$id_crypto}"> 
                            
                            <button name="modal_wallet_delete_btn" type="submit" class="btn btn-primary wallet_delete">Да, удалить</button>
                        </form>
                    </div>
                </div>   
            </div>
        </div>
    </div>

{/if}    

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Настройки крипт и кошельков</h3>
                </div>
                    <div class="title_left wallet">
                        <a href="/admin/settings.php?type=wallets&function=new" class="btn btn-default btn-md">Добавить крипту в систему</a>
                    </div>
                        <div class="title_right wallet">
                            <h3>Всего крипт, загруженных в систему {$cryptos->getCryptoCount()} шт.</h3>
                        </div>                    
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th rowspan="2">№<br>п/п</th>
                                        <th colspan="3">Крипта</th>
                                        <th rowspan="2">Адрес кошелька</th>
                                        <th rowspan="2">Минимальная<br>цена для БС</th>   
                                        <th colspan="2">Действия</th>
                                    </tr>
                                    <tr>
                                        <th>Знак</th>
                                        <th>Название</th>
                                        <th>Код</th>
                                        <th>Редактировать</th>
                                        <th>Удалить</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    {foreach from=$all_cryptos item=$crypto}
                                    {$code = mb_strtolower($crypto['code'])}
                                    <tbody>
                                        {$i = $i + 1}
                                        <th><div class="collectiv-col">{$i}</div></th>

                                        <th class="crypto-image-col"><div class="crypto-image"><img src="{$template}/img/{$code}.png"></div></th>

                                        <th><div class="collectiv-col">{$crypto['name']}</div></th>
                                        
                                        <th><div class="collectiv-col">{$crypto['code']}</div></th>
                                        
                                        <th class="wallets_new_col"><div class="marketing-create__right wallets_new collectiv-col">{$crypto['wallets_address']}</div></th>
                                        
                                        <th><div class="marketing-create__right wallets_new collectiv-col">{$crypto['bs_min_price']}</div></th>   

                                        <th class="nmb"><div class="collectiv-col"><a href="/admin/settings.php?type=wallets&function=edit&id={$crypto['id']}&name={$crypto['name']}&code={$code}" class="btn-default btn btn-sm">Редактировать</a></div></th>

                                        <th class="nmb"><div class="collectiv-col"><a href="/admin/settings.php?type=wallets&function=delete&id={$crypto['id']}&img={$code}" class="btn-default btn btn-sm">Удалить</a></div></th>
                                    </tbody>
                                    {/foreach}
                                </table>
                                <input type="hidden" class="val_text" value="На данной странице отображается список не всех, а только действующих кошельков для БС">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}