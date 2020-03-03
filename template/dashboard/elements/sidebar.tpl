{*  Часть кода для замены url в адресной строке браузера на алиас с именем продавца в чате *}

<div class="col-xs-3 lk-col-3">
    <div class="lk-menu_profile">
        <div class="lk-menu_profile-stars text-center">
            {include file='elements/advert/rating.tpl' rating=$user->getRating()}

        </div>
        <div class="lk-menu_profile-avatar" style="background: #{$user->getColor()}">
            <img src="/files/{$user->getAvatar()}">
        </div>
        <div class="lk-menu_profile-name text-center">{$user->getLogin()}</div>
        <div class="lk-menu_profile-ld clearfix">
            <div>
                <i class="icon-like"></i>
                <span>{$user->getLikes()}</span>
            </div>
            <div>
                <i class="icon-dislike"></i>
                <span>{$user->getDislikes()}</span>
            </div>
            <div>
                <a href="#reviews" class="user-links_in_sell open-forms">Отзывы</a>
            </div>
        </div>
    </div>
    <div class="lk-menu">
        <ul>
            {if empty($_GET['user_id'])}
                <li>
                    <a href="/dashboard.php?page=my_adverts{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_adverts'}class="active"{/if}>
                        <span>
                            Мои Объявления: {$Users->getAdvertsCount($user->getId())}
                            {if $notifications['adverts'] > 0 || $notifications['adverts-moderation'] > 0 || $notifications['adverts-close'] > 0} <i></i>{/if}
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=my_sells{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_sells'}class="active"{/if}>
                        <span>
                            Мои Продажи: {$Users->getSells($user->getId())}
                            {if $notifications['sells'] > 0 || $notifications['sells-open'] > 0 || $notifications['sells-close'] > 0}
                                <i></i>
                            {/if}
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=my_purchases{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_purchases'}class="active"{/if}>
                        <span>
                            Мои Покупки: {$Users->getBuys($user->getId())}
                            {if $notifications['purchases'] > 0 || $notifications['purchases-open'] > 0 || $notifications['purchases-close'] > 0}
                                <i></i>
                            {/if}
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=my_favorites{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_favorites'}class="active"{/if}>
                        
                {if $user != false && $user->getFavorites() != '' && $user->getFavorites() != NULL && $user->getFavorites() != false}

                            <span>Избранное: {$Users->getFavoritesRealCount($user->getFavorites())}</span>
                
                {else}
                        <span>Избранное: 0</span>
                {/if}                        
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=chat" {if !empty($_GET['page']) AND $_GET['page'] == 'chat'}class="active"{/if}>
                        <span>
                            {if $msgCount > 0} <i></i>{/if}Чат{if $msgCount > 0}: {$msgCount}{/if}
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php{if !empty($user_id)}?user_id={$user_id}{/if}" {if empty($_GET) OR $_GET['page'] == 'wallets'}class="active"{/if}>
                        <span>
                            Настройки
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=chat_admin" {if !empty($_GET['page']) AND $_GET['page'] == 'chat_admin'}class="active"{/if}>
                        <span>
                            {if $admin_msgCount > 0} <i></i>{/if}Администрация
                        </span>
                    </a>
                </li>
                <li class="logout">
                    <a href="/logout.php">
                        <span>
                            Выход
                        </span>
                    </a>
                </li>
            {else}
                <li>
                    <a href="/dashboard.php?page=my_adverts{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_adverts'}class="active"{/if}>
                        <span>
                            {if $notifications['adverts'] > 0}<i></i>{/if}
                            Объявления: {$Users->getAdvertsCount($user->getId())}
                        </span>
                    </a>
                </li>
                <li>
                    <a href="/dashboard.php?page=my_sells{if !empty($user_id)}&user_id={$user_id}{/if}" {if !empty($_GET['page']) AND $_GET['page'] == 'my_sells'}class="active"{/if}>
                        <span>
                            {if $notifications['adverts'] > 0}<i></i>{/if}
                            Продажи: {$Users->getSells($user->getId())}
                        </span>
                    </a>
                </li>
                <li>
                    <a class="no-cursor" href="#">
                        <span>
                            {if $notifications['adverts'] > 0}<i></i>{/if}
                            Покупки: {$Users->getBuys($user->getId())}
                        </span>
                    </a>
                </li>
            {/if}
        </ul>
    </div>
</div>

{include file='elements/user_reviews.tpl' user=$user}