{include file='elements/main/header.tpl'}

{include file='elements/main/breadcrubms.tpl'}

{if empty($new_chat)}
    <script src="{$template}/js/dashboard/chat_admin.js"></script>
{/if}

<script>   
    $(function()
        {

            $('div.href_div').on('click', function()
            {         
                let href_chat = $(this).data('link');

                if (href_chat !== null) location.href = href_chat;  

            });

            $(".chat-user").css("border", "1.25px solid #abb9cd");
               
        });
</script>


<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                <div class="lk-top_menu">
                    <div class="row">
                        <div class="col-xs-4">
                            <span>Сообщения</span>
                        </div>

                        <div class="col-xs-4 chattt-hidden-admin">
                            <a href="/dashboard.php?page=chat_admin&new_chat=0" style="position: relative;left: -4px;{if isset($chat)}{if $chat->getStatus() == 1} pointer-events: none;{/if}{/if}">

                            Начать новый чат с администратором
                            </a>
                        </div>                        
                        
                    </div>
                </div>
                
                <div class="lk-chat">
                    <div class="row">
                        <div class="col-xs-4">
                            <div class="chat-theme">
                            {if isset($chats)}
                                {foreach from=$admin_chats item=$chat}
                                    {$to = $chat->GetTo()}
                                    {$from = $chat->getFrom()}
                                    {if !empty($to) AND $to->getId() != $user->getId()}
                                        {$chat_user = $to}
                                    {else}
                                        {$chat_user = $from}
                                    {/if}

                                    {$last_message = $chat->getMessages()}
                                    {$last_message = end($last_message)}

                                    <div class="chat-theme_item href_div {if !empty($_GET['chat_id']) AND $_GET['chat_id'] == $chat->getId()}active{/if}" data-link="/dashboard.php?page=chat_admin&type=admin&chat_id={$chat->getId()}">
                                        
                                        <div class="chat-theme_item-head">
                                            <div class="chat-theme_item-title">Чат № {$chat->getId()}</div>
                                            <div class="chat-theme_item-date">
                                                {if !empty($last_message)}
                                                    {$Chats->getBeautifulDate($last_message->getDate())}
                                                {/if}
                                            </div>
                                        </div>
                                        
                                        <div class="chat-theme_item-info">
                                            <div class="chat-theme_item-avatar" style="background-color: #{$chat_user->getColor()}">
                                                <img src="/files/{$chat_user->getAvatar()}">
                                            </div>
                                            <div class="chat-theme_item-name">Online: {$chat_user->getLogin()}</div>
                                            {if !empty($last_message)}
                                                {if $chat->hasUnread($user->getId())}
                                                    <div class="chat-theme_item-att"></div>
                                                {/if}
                                            {/if}
                                        </div>
                                        <div class="chat-theme_item-text">
                                            {if !empty($last_message)}
                                                {urldecode($last_message->getText())}
                                            {/if}
                                        </div>
                                    </div>
                                {foreachelse}
                                {/foreach}
                            {/if}
                            </div>
                        </div>
               
                        {if !empty($chat) && $chat_fierst != 0}
                            <div id="chat-hidden" class="col-xs-8">
                                {$to = $chat->GetTo()}
                                
                                {$from = $chat->getFrom()}
                                
                                {if !empty($to) AND $to->getId() != $user->getId()}
                                    {$chatUser = $to}

                                {else}
                                    {$chatUser = $from}
                                {/if}
                            {if !empty($to)}
                                <div class="chat-user">

                                    <div class="chat-user_left text-center">
                                        
                                        <div class="chat-user_title">
                                            {if $user->getId() == $to->getId()}
                                                Online
                                            {else}
                                                Online
                                            {/if}
                                        </div>

                                       
                            <!-- Часть кода для получения цвета фона аватара в чате -->
                                        <div class="chat-user_av" style="background-color: #{$chatUser->getColor()}">
                                            <img src="/files/{$chatUser->getAvatar()}" alt="">
                                        </div>
                                    
                                        <div class="chat-user_name">
                                            <a>{$chatUser->getLogin()}</a>
                                        </div>
                                    </div>
                                
    
                                        <div class="clearfix"></div>
                                </div>
                            {/if}
                                <div class="chat-message">
                                    <div class="chat-message_body"></div>
                                    <div class="chat-message_foot">
                                        <textarea name="message" class="emoji twemoji-textarea" id="message_text_area"></textarea>
                                        <button class="send_message" data-chat_id="{$chat->getId()}" data-color_to="{if !empty($to)}{if $user->getId() == $to->getId()}{$to->getColor()}{else}{$from->getColor()}{/if}{else}{$from->getColor()}{/if}" data-color_from="{if !empty($to)}{if $user->getId() == $to->getId()}{$from->getColor()}{else}{$to->getColor()}{/if}{else}{$from->getColor()}{/if}">

                                            <img src="{$template}/img/chat-button.svg" alt="">
                                        </button>
                                        {if !empty($to)}
                                            {if $user->getId() == $to->getId()}
                                                Клиент
                                            {else}
                                                Администратор
                                            {/if}      
                                        {/if}
                                    </div>
                                </div>
{*                                    <div class="col-xs-4 btn-close-chat-admin" style="{if isset($chat)}{if $chat->getStatus() == 2}pointer-events: none;{/if}{/if}">
                                                            
                                        <form method="POST" action="/ajax/chat/close_current_chat_with_admin.php" class="btn-close-chat-admin" style="{if isset($chat)}{if $chat->getStatus() == 2}pointer-events: none;{/if}{/if}">
                                            <input type="hidden" name="close_chat_id" value="{$chat->getId()}">
                                         <button class="btn-close-chat-admin" type="submit" style="{if isset($chat)}{if $chat->getStatus() == 2}pointer-events: none;{/if}{/if}">Закрыть текущий чат с администратором</button> 
                                        </form>

                                    </div>  *}
                            </div>
                        {/if}                                          
                   
                    </div>
                
            </div>
        </div>
    </div>
</div>

{include file='elements/main/footer.tpl'}
