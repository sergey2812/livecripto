{include file='admin/elements/header.tpl'}

{if empty($new_chat)}
    <script src="{$template}/js/dashboard/chat.js"></script>
{/if}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                {* todo-hard Доделать чат *}
                <div class="page-title">
                    <h3>Чат</h3>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel profile_chat">
                            <div class="x_content">
                                {if !empty($chat)}
                                    <form action="" class="lk-chat no-ajax" method="post">
                                        <div class="lk-chat-header">
                                            <div class="row">
                                                <div class="col-sm-9">
                                                    <div class="lk-chat-header__title">
                                                        {$chat->GetSubject()}
                                                        <span>
                                                            {$user_type = 'from'}
                                                            {$to = $chat->GetTo()}
                                                            {$from = $chat->getFrom()}
                                                            {if $to->getId() != $user->getId()}
                                                                {$to->getLogin()}
                                                            {else}
                                                                {$user_type = 'to'}
                                                                {$from->getLogin()}
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
                                            <div class="row">
                                                <div class="col-sm-9">
                                                    <div class="lk-chat-body__messages">
                                                    </div>
                                                    <div class="lk-chat-button">
                                                        {if !empty($new_chat)}
                                                            <textarea name="message" placeholder="Введите текст сообщения" class="emoji"></textarea>
                                                            <button class="yel-button" type="submit">Отправить</button>
                                                        {else}
                                                            <textarea name="message" placeholder="Введите текст сообщения" class="emoji" id="message_text_area"></textarea>
                                                            <button class="yel-button send_message" data-chat_id="{$chat->getId()}" type="button">Отправить</button>
                                                        {/if}
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="lk-chat-body__users">
                                                        {foreach from=$chats item=$chat}
                                                            <a href="/admin/profiles.php?type=chat&chat_id={$chat->getId()}" class="lk-chat-user__item">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-center">
                                                                        <img src="{$template}/img/lk-user.png" alt="">
                                                                        <span class="status not-in-place"></span>
                                                                    </div>
                                                                    <div class="col-sm-8">
                                                                        {$to = $chat->GetTo()}
                                                                        {$from = $chat->getFrom()}
                                                                        {if $to->getId() != $user->getId()}
                                                                            {$chat_user = $to}
                                                                        {else}
                                                                            {$chat_user = $from}
                                                                        {/if}
                                                                        {$advert = $chat->getAdvert()}

{*                                                                        <a href="/dashboard.php?page=chat_admin&new_chat={$chat_user->getId()}&subject=admin-msg&advert={$advert->getId()}" class="message-seller" target="_blank">{t}Написать в личный чат{/t}</a>
*}
                                                                        <div class="lk-chat-user__name">{$chat_user->getLogin()}</div>
                                                                        {$last_message = $chat->getMessages()}
                                                                        {$last_message = end($last_message)}
                                                                        <div class="lk-chat-user__last">{urldecode($last_message->getText())}</div>
                                                                        <div class="lk-chat-user__time">{date("H:i", strtotime($last_message->getDate()))}</div>
                                                                    </div>
                                                                </div>
                                                                {if $chat->hasUnread($user->getId()) > 0}
                                                                    <div class="lk-chat-user__number">{$unread[$chat_user->getId()]}</div>
                                                                {/if}
                                                            </a>
                                                            {foreachelse}
                                                        {/foreach}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                {else}
                                    <h4 class="text-center">У вас начатых чатов</h4>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}