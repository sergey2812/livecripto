<div class="lk-top_menu">
    <div class="row">
        <div class="col-xs-4">
            <a href="/dashboard.php{if !empty($user_id)}?user_id={$user_id}{/if}" {if empty($page)}class="active"{/if}>Персональные данные</a>
        </div>
        <div class="col-xs-4">
            <a href="/dashboard.php?page=wallets{if !empty($user_id)}&user_id={$user_id}{/if}" {if $page == 'wallets'}class="active"{/if}">Адреса кошельков</a>
        </div>
    </div>
</div>