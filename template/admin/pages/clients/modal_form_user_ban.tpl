<script>
$(function()
{
    $('#banned_modal_form').modal({
     keyboard: true,
     backdrop: 'static',
   });

    let stats = $('input[name="stats_2"]').val();

    if (stats == 1)
        {
            $('.btn.btn-primary.ban-unban').css("display", "none");
            $('#admin_comment').css("display", "none");
            $('.admin_label.admin_comment').css("display", "none");
            $('.mod_title').text("Клиент заблокирован");
            $('input[name="stats_2"]').val('');
        }
    else
        {
            $('.btn.btn-primary.ban-unban').css("display", "block");
            $('#admin_comment').css("display", "block");
            $('.admin_label.admin_comment').css("display", "block");
            $('.mod_title').text("Заблокировать клиента");
            $('input[name="stats_2"]').val('');
        }

      //#mess - id элемента, которому необходимо установить фокус
 //     $('#mess').focus();

    function closeModal(){
        var modal = $('div.modal:visible');
        if (modal) {
            var method = modal.data("method") || "fade",
                classIn = method+"In",
                classOut = method+"Out",
                animTime = modal.data("amination-time") || 700;
                
            modal.removeClass(classIn).addClass(classOut)
            setTimeout(function() { modal.modal('hide').removeClass(classOut).addClass(classIn); }, animTime);
        }
    }
    $(document).on('click', 'button.close, button.btn.btn-secondary.ban-unban', function() {
        closeModal();
    });
    $(document).on('keyup', function(e) {
        if (e.which == 27) {
            closeModal();
        }
    });      

});
</script>

<div id="banned_modal_form" class="modal fadeIn" aria-hidden="true" data-method="fade" data-amination-time="700">
    <form action="" method="POST">
 <div class="modal-content ban-unban">
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    <div class="mod_title">Заблокировать клиента</div>       
    <div class="add-review_head text-center">  
    <div class="user-icon"  style="background-color: #{$user_to->getColor()}">
                        <img src="/files/{$user_to->getAvatar()}">    
    </div>
    {$last_admin_chat = $Chats->GetLastChatAdminByUserId($user_to->getId())}
    <div class="login-bth">{if $_COOKIE['id'] != $user_to->getId()}<a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$user_to->getId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}">{$user_to->getLogin()}</a>{else}{$user_to->getLogin()}{/if}</div>
    </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-row">
                    <label class="admin_label">История блокировок данного клиента</label>
                                <table id="client_banned_table" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th rowspan="2">Причина<br>(заявление)</th>
                                        <th rowspan="2">Заявитель</th>
                                        <th rowspan="2">Дата<br>заявления</th>
                                        <th rowspan="2">Источник<br>нарушения</th>
                                        <th rowspan="2">Комментарий<br>админа</th>
                                        <th rowspan="2">Дата<br>комментария</th>
                                        <th rowspan="2">Админ</th>
                                    </tr>
                                    </thead>
                                    <tr><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tr>
                                    <tbody id="rows_tables">                                        
                                    {$i = 1}                                        
                                        {foreach from=$banned_users item=$banned_user}
                                        {$last_admin_chat = $Chats->GetLastChatAdminByUserId($banned_user->getUserBanFromId())}
                                            <tr {if $i == 1}{$i = 0}style="background-color: #fdfdca;"{/if}> 
                                                <th>{$banned_user->getUserBanCause()}</th>
                                                <th class="login-btn">{if $_COOKIE['id'] != $banned_user->getUserBanFromId() AND $banned_user->getUserBanFromId() != 0}<a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$banned_user->getUserBanFromId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}">{if $banned_user->getUserBanFromId() > 0}{$Users->Get($banned_user->getUserBanFromId())->getLogin()}{/if}</a>{else}{if $banned_user->getUserBanFromId() > 0}{$Users->Get($banned_user->getUserBanFromId())->getLogin()}{/if}{/if}</th>
                        <th>{if $banned_user->getUserBanCauseDate() !== '30.11.-0001 00:00'}{$banned_user->getUserBanCauseDate()}{/if}</th>

                                                <th class="login-btn">{if $banned_user->getUserBanAdvertId()}<a href="/admin/adverts.php?type=single&id={$banned_user->getUserBanAdvertId()}" class="product-info_title" target="_blank">Товар № {$banned_user->getUserBanAdvertId()}</a>
                                                    {else}
                                                        {if $banned_user->getUserBanDealId()}
                                                        Сделка в чате № {$banned_user->getUserBanDealId()}
                                                        {/if}
                                                    {/if}                 
                                                </th>                   

                                                <th>{$banned_user->getUserBanComment()}</th>
    <th>{if $banned_user->getUserBanCommentDate() !== '30.11.-0001 00:00'}{$banned_user->getUserBanCommentDate()}{/if}</th>
                                                <th>{if $banned_user->getUserBanAdminId() > 0}{$Users->Get($banned_user->getUserBanAdminId())->getLogin()}{/if}</th>       
                                            </tr>
                                        {/foreach}  
                                    </tbody>
                                </table>
                </div>
                <div class="form-row">
                    <label class="admin_label admin_comment">Текущий комментарий администратора<span>*</span>:</label>
                    <div id="admin_comment" contenteditable="true">
                        <textarea id="mess" name="message" onChange="checkReview()" maxlength="2048" required></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <form class="modal_form_banned_button" method="POST">
                        <input type="hidden" name="function" value="ban">
                        <input type="hidden" name="id_user_to" value="{$user_to->getId()}">
                        <input type="hidden" name="id_admin" value="{$user->getId()}">
                        <button type="button" class="btn btn-secondary ban-unban" data-dismiss="modal">Close</button>
                        <button name="modal_banned_btn" type="submit" class="btn btn-primary ban-unban">Заблокировать</button>
                    </form>
                </div>
            </div>
            
        </div>
    </form>
    </div>
</div>