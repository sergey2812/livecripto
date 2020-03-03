<!-- top navigation -->
<div class="top_nav">
    <div class="nav_menu">
        <nav>
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-angle-left"></i></a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <a href="javascript:" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        {if !empty($user->getAvatar())}
                            <img src="/files/{$user->getAvatar()}" alt="{$user->getLogin()}" style="background: #{$user->getColor()}">
                        {/if}
                        {$user->getLogin()}
                        <span class="fa fa-angle-down"></span>
                    </a>
                    <ul class="dropdown-menu dropdown-usermenu pull-right">
                        <li><a href="/admin/profiles.php?type=my"> Профиль</a></li>
                        <li><a href="/"><i class="fa fa-sign-out pull-right"></i> Выход</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</div>
<!-- /top navigation -->