{if !empty($mainUser)}{$user = $mainUser}{/if}
<!DOCTYPE html>
<html lang="ru">
<head>
	{include file='elements/main/head.tpl'}
	
</head>

<body>

{if isset($adsBannerUp)}
<div id="top">{$adsBannerUp}</div>
{/if}
<div class="head"></div>

<div id="header" {if $user != false}class="header-login"{/if}>
	<div class="cat-menu">
		<button title="Close (Esc)" type="button" class="mfp-close close-menu">×</button>
		<ul class="nav nav-tabs">
			{foreach from=$sections item=$section key=$i}
				<li {if $i == 0}class="active"{/if}>
					<a data-toggle="tab" href="#panel{$section->getId()}">{$section->getName()}</a>
				</li>
			{/foreach}
		</ul>
		<div class="tab-content">
			{foreach from=$sections item=$section key=$i}
				<div class="cat-menu_row {if $i == 0}active{/if}" data-panel="#panel{$section->getId()}" data-columns>
					{foreach from=$section->getCategories() item=$category}
						<div class="cat-menu_item">
							<div class="cat-menu_name"><a href="/?category={$category->getId()}">{$category->getName()}</a></div>
							<ul>
								{foreach from=$category->getSubcategories() item=$subcategory}
									<li>
										<a href="/?section={$section->getId()}&category={$category->getId()}&subcategory={$subcategory->getId()}">
											{$subcategory->getName()}
										</a>
									</li>
								{/foreach}
							</ul>
						</div>
					{/foreach}
				</div>
			{/foreach}
		</div>
	</div>
	<div class="cat-menu_overlay"></div>
	<div class="container">
		<div class="row">
			<div class="col-xs-6">
				<div class="head-item">
					<a href="/" class="head-logo">
						<img src="{$template}/img/logo-01.svg" alt="" width="60">
					</a>
				</div>
				<div class="head-item head-item_lang">
					<ul>
						<li class="current">{if $lang == 'en_US'}Eng{else}Rus{/if} <i></i>
							<ul>
								{if $lang != 'en_US'}<li><a href="/change_lang.php?lang=en_US">English</a></li>{/if}
								{if $lang != 'ru_RU'}<li><a href="/change_lang.php">Русский</a></li>{/if}
							</ul>
						</li>
					</ul>
				</div>
				<div class="head-item head-item_search">
					<form method="get" action="/" class="no-ajax">
						{if !empty($filters)}
							{foreach from=$filters item=$value key=$name}
								{if $name == 'page'}
									<input type="hidden" name="{$name}" value="{$value+1}">
								{else}
									{if is_array($value)}
										{foreach from=$value item=$val}
											<input type="hidden" name="{$name}" value="{$val}">
										{/foreach}
									{else}
										<input type="hidden" name="{$name}" value="{$value}">
									{/if}
								{/if}
							{/foreach}
						{/if}
						<img src="{$template}/img/head-item-search_icon.png" alt="Искать">
						<input type="text" name="search" placeholder="Поиск на ZaCrypto" {if !empty($_GET['search'])}value="{$_GET['search']}"{/if}>
						<button type="submit">{t}Найти{/t}</button>
					</form>
				</div>
			</div>
			<div class="col-xs-6" {if !empty($user)}style="padding-top: 8px;"{/if}>
				<div class="head-item" style="margin-right: 11px;">
					<a href="{if empty($user)}#login{else}/create_ad.php{/if}" class="head-item_buttons head-item_add {if empty($user)}open-forms{/if}" {if empty($user)}data-tab="panel1"{/if}>{t}Разместить объявление{/t}</a>
				</div>
				<div class="head-item">
					<a href="#" class="head-item_buttons head-item_cats">{t}Категории{/t}</a>
				</div>
				{if empty($user)}
					<div class="head-item">
						<a href="#login" class="head-item_buttons head-item_login open-forms" data-tab="panel2">Вход</a>
					</div>
					<div class="head-item">
						<a href="#login" class="head-item_buttons head-item_register open-forms" data-tab="panel1">Регистрация</a>
					</div>
				{else}
					<div class="head-item head-item_profile" style="width: 298px">
						<a href="/dashboard.php?page=my_favorites" class="head-profile_fav">

						{if $user != false && $user->getFavorites() != '' && $user->getFavorites() != NULL && $user->getFavorites() != false}

									<span>{$Users->getFavoritesRealCount($user->getFavorites())}</span>
						{else}
                        <span>0</span>
                		{/if}	
						</a>
						
						<a href="/dashboard.php?page=chat" class="head-profile_message">
							{if $msgCount > 0}
								<span>{$Users->getMessagesCount($user->getId())}</span>
							{/if}
						</a>

						<div class="head-profile_avatar" style="overflow: hidden;text-align: center;background: #{$user->getColor()}">
							{if !empty($user->getAvatar())}
								<a href="/dashboard.php?page=my_adverts"><img src="/files/{$user->getAvatar()}" alt="{$user->getLogin()}"></a>
							{else}
								<a href="/dashboard.php?page=my_adverts"><img src="/files/avatars/1.png" width="23"></a>
							{/if}
						</div>
						<div class="head-profile_name"><a href="/dashboard.php?page=my_adverts">{$user->getLogin()}</a></div>
						{if isset($_COOKIE['permissions']) AND $_COOKIE['permissions'] <= 5}
							<div style="display: inline-block; text-align: center; font-size: 20px; font-weight: 900;  background: gainsboro;padding-left: 5px; padding-right: 5px; margin-left: 5px;"><a href="/admin">B</a>
							</div>
						{/if}
					</div>
				{/if}
			</div>
		</div>
	</div>
</div>
<div class="content-wrapper">