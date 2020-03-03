{include file='elements/main/header.tpl'}

{include file='elements/main/breadcrubms.tpl'}

<script>
    const allWallets = {
        {foreach from=$currencies item=$cur}
        '{$cur['code']}': '{$cur['name']}',
        {/foreach}
    };
</script>

<script src="{$template}/js/dashboard/update_wallets.js"></script>

<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9 wallets-config">
                {include file='dashboard/elements/header_menu.tpl'}

                <script>
                    {foreach from=$user->getWallets() key=$type item=$wallet}
                        wallets.{$type} = '{$wallet}';
                    {/foreach}
                </script>

                {foreach from=$user->getWallets() key=$type item=$wallet}
                    <div class="wallet">
                        <div class="image">
                            <img src="{$template}/img/{mb_strtolower($type)}.png" alt="{$type}">
                        </div>
                        <p title="{$wallet}">{$wallet}</p>
                        <div class="delete" data-type="{$type}">X</div>
                    </div>
                {/foreach}

                <div style="display: block" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-code="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>
                <div style="display: none" class="lk-config_purse">
                    <select name="config_purse" class="filter_select">
                        <option value="0">Выберите криптовалюту</option>
                        {foreach from=$currencies item=$currency}
                            <option value="{$currency['code']}" data-image="{$template}/img/{mb_strtolower($currency['code'])}.png">{$currency['name']}</option>
                        {/foreach}
                    </select>
                    <input type="text" name="config_purse_input">
                </div>

                <form class="lk-config_pass disabled" method="POST" action="/ajax/users/set_wallets.php">
                    <input type="hidden" name="wallets" value="{htmlspecialchars(json_encode($user->getWallets()))}">
                    <div class="row">
                        <div class="col-xs-8">
                            <label>Введите текущий пароль для сохранения изменений</label>
                            <input type="password" name="change_pass">
                        </div>
                        <div class="col-xs-4 text-right">
                            <button>Сохранить</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
        $('input[name="change_pass"]').on('keyup', function () {
            updateForm();
        })
    });

    function updateForm() {
        let form = $('.wallets-config');
        let changes = false;
        let password = false;
        form.find('input').each(function () {
            if ($(this).val() !== '') changes = true;
        });

        if (form.find('input[name="change_pass"]').val().length > 6) password = true;

        if (changes) {
            let i = form.find('.lk-config_pass');
            i.removeClass('disabled');
            if (password) {
                i.removeClass('error');
            } else{
                i.addClass('error');
            }
        } else{
            i.addClass('disabled');
        }
    }
</script>

{include file='elements/main/footer.tpl'}