{include file='admin/elements/header.tpl'}

<script src="{$template}/js/dashboard/chat_admin.js"></script>


<script>   
    $(function()
        {

            $('div.href_div').on('click', function()
            {         
                let href_chat = $(this).data('link');

                if (href_chat !== null) location.href = href_chat;  

            });
               
        });
</script>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                {* todo-hard Доделать чат *}
                <div class="page-title">
                    <h3>Чат: ответы админа на запросы клиентов</h3>
                </div>
                <div class="clearfix"></div>
                    <div class="back_btn_wallet">
                        <a href="/admin/clients.php?type=all" class="btn btn-default btn-md">Вернуться в список всех клиентов</a>
                    </div>                 
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel profile_chat">
                            <div class="x_content">
                                
                                    <form action="" class="lk-chat no-ajax" method="post">
                                        <div class="lk-chat-header">
                                            <div class="row">
                                                <div class="col-sm-9">
                                                    <div class="lk-chat-header__title">
                                                        
                                                        <span>
                                                          
                                                            {$to = $chat->GetTo()}
                                                            {$from = $chat->getFrom()}

                                                            {if $to->getId() != $user->getId()}
                                                                {$chat_user = $to}
                                                            {else}
                                                                {$chat_user = $from}
                                                            {/if}

                                                            <p>Клиент № {$chat_user->getId()} {$chat_user->getLogin()}</p>
                                                            <p>чат № {$chat->getId()}</p>
                                                            {if $chat->getStatus() == 1}
                                                            <p>Статус чата - "ОТКРЫТЫЙ", можно продолжать переписку."</p>
                                                            {elseif $chat->getStatus() == 2}
                                                            <p>Статус чата - "ЗЫКРЫТЫЙ", для переписки откройте новый чат в списке клиентов."</p>
                                                            {/if}
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3 text-center">
                                                    <div class="lk-chat-header__themes">Темы чатов</div>
                                                </div>
                                            </div>
                                        </div>
                                    <div class="lk-chat-body">
                                        <div id="chat-hidden" class="row">


            <div class="col-sm-9 chat-message">
                <div class="lk-chat-body__messages chat-message_body"></div>
                    <div class="lk-chat-button chat-message_foot">
                       
                        <textarea name="message" placeholder="Введите текст сообщения" class="emoji twemoji-textarea" id="message_text_area"></textarea>
                        <button class="yel-button send_message" data-chat_id="{$chat->getId()}" type="button" data-color_to="{if !empty($to)}{if $user->getId() == $to->getId()}{$to->getColor()}{else}{$from->getColor()}{/if}{else}{$from->getColor()}{/if}" data-color_from="{if !empty($to)}{if $user->getId() == $to->getId()}{$from->getColor()}{else}{$to->getColor()}{/if}{else}{$from->getColor()}{/if}">Отправить</button>

                    </div>
            </div>


                                                <div class="col-sm-3">
                                                    <div class="lk-chat-body__users chat-theme">
                                                       {foreach from=$chats item=$chat}

<div class="lk-chat-user__item chat-theme_item href_div {if !empty($_GET['chat_id']) AND $_GET['chat_id'] == $chat->getId()}active{/if}" data-link="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$chat->getFrom()->getId()}&chat_id={$chat->getId()}">                                                       
                                                                <div class="row">
                                                                        {$to = $chat->GetTo()}
                                                                        {$from = $chat->getFrom()}
                                                                        {if $to->getId() != $user->getId()}
                                                                            {$chat_user = $to}
                                                                        {else}
                                                                            {$chat_user = $from}
                                                                        {/if}  

                                                    <div class="col-sm-4 text-center chat-theme_item-avatar" style="background-color: #{$chat_user->getColor()}">
                                                            <img src="/files/{$chat_user->getAvatar()}">
                                                    {if !empty($_GET['chat_id']) AND $_GET['chat_id'] == $chat->getId()}
                                                        <span class="status not-in-place"></span>
                                                    {/if}
                                                    </div>
                                                    <div class="col-sm-8">

                                                    <div class="chat-theme_item-name lk-chat-user__name">{$chat_user->getLogin()}</div>
                                                                       чат № {$chat->getId()}
                                                                        {$last_message = $chat->getMessages()}
                                                                        {$last_message = end($last_message)}
                                                                        
                                                    <div class="chat-theme_item-text lk-chat-user__last">
                                                        {if !empty($last_message)}
                                                        {urldecode($last_message->getText())}
                                                        {/if}
                                                    </div>
                                                                        
                                                    <div class="chat-theme_item-date lk-chat-user__time">
                                                        {if !empty($last_message)}
                                                            {$Chats->getBeautifulDate($last_message->getDate())}
                                                        {/if}
                                                    </div>

                                    
                                                                    </div>
                                                                </div>
                                                            
                                            </div>
                                                            {foreachelse}
                                                        {/foreach}                 
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>
                                    </form>
                            </div>
                                        <form method="POST" action="/ajax/chat/close_current_chat_admin.php" class="btn-close-chat-admin" style="{if isset($chat)}{if $chat->getStatus() == 2}pointer-events: none;{/if}{/if}">
                                            <input type="hidden" name="close_chat_id" value="{$chat->getId()}">
                                         <button class="btn-close-chat-admin" type="submit" style="{if isset($chat)}{if $chat->getStatus() == 2}pointer-events: none;{/if}{/if}">Закрыть текущий чат с клиентом</button> 
                                        </form>                            
                        </div>
                    </div>
                </div>
            </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}