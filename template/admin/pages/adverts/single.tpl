{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var country_status = $("input[name='country_status']").val();

    if (country_status == 8)
        {
            alert("Объявление переведено в исходное состояние модерации со статусом 1!");
            $("input[name='country_status']").val('');
        }

    if (country_status == 10)
        {
            alert("Объявление заблокировано!");
            $("input[name='country_status']").val('');
        } 

    if (country_status == 12)
        {
            alert("Объявление в архиве!");
            $("input[name='country_status']").val('');
        } 

    if (country_status == 14)
        {
            alert("Объявление опубликовано!");
            $("input[name='country_status']").val('');
        } 


    $('#modal_advert').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("#modal_advert").focus();
    })           

    $(".white-border-button.blocked").on('click', function () 
        { 
            let advert_id = $(this).data('advert-id');
            let status = $(this).data('status');

            $("input[name='advert_id']").val(advert_id);
            $("input[name='update_status']").val(status);
            
            if (status == 4)
                {
                    $(".modal-header h4").html('Заблокировать данное объявление?');

                    $(".modal-footer #modal_advert").html('Да, заблокировать');
                    $("#modal_advert_run input[name='function']").val("modal_advert");
                }
            else
                {
                    $(".modal-header h4").html('Разблокировать данное объявление?');

                    $(".modal-footer #modal_advert").html('Да, разблокировать');
                    $("#modal_advert_run input[name='function']").val("unmodal_advert");                    
                }                

        });  

    $(".white-border-button.in_out_archive").on('click', function () 
        { 
            let advert_id = $(this).data('advert-id');
            let status = $(this).data('status');

            $("input[name='advert_id']").val(advert_id);
            $("input[name='update_status']").val(status);
            
            if (status == 3)
                {
                    $(".modal-header h4").html('Поместить данное объявление в архив?');

                    $(".modal-footer #modal_advert").html('Да, в архив');
                    $("#modal_advert_run input[name='function']").val("arr_advert");
                }
            else
                {
                    $(".modal-header h4").html('Извлечь данное объявление из архива?');

                    $(".modal-footer #modal_advert").html('Да, извлечь из архива');
                    $("#modal_advert_run input[name='function']").val("unarr_advert");                    
                }                

        });

    $(".white-border-button.active").on('click', function () 
        { 
            let advert_id = $(this).data('advert-id');
            let status = $(this).data('status');

            $("input[name='advert_id']").val(advert_id);
            $("input[name='update_status']").val(status);
            
            if (status == 2)
                {
                    $(".modal-header h4").html('Разместить данное объявление в системе?');

                    $(".modal-footer #modal_advert").html('Да, активировать');
                    $("#modal_advert_run input[name='function']").val("active_advert");
                }
            else
                {
                    $(".modal-header h4").html('Снять данное объявление с публикации?');

                    $(".modal-footer #modal_advert").html('Да, снять');
                    $("#modal_advert_run input[name='function']").val("unactive_advert");                    
                }                

        });                   
});
</script>

<div id="modal_advert" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title country"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="modal_advert_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="advert_id" value="">
        <input type="hidden" name="country_status" value="{if isset($status)}{$status}{/if}">
        <input type="hidden" name="update_status" value="">
          <div class="modal-body">
{*                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_country" placeholder="Впишите название страны" required>
                    </div>
                </div> *}
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Отменить</button>
            <button id="modal_advert" type="submit" class="btn btn-primary">Да, заблокировать</button>
          </div>
      </form>
    </div>
  </div>
</div>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}

        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Создание/редактирование объявления</h3>
                </div>
                <div class="clearfix"></div>
                    <div class="back_btn_wallet">
                        <a href="/admin/adverts.php?type=all" class="btn btn-default btn-md">Вернуться назад, в список объявлений</a>
                    </div>                
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel marketing__create">
                            <div class="x_content">
                                <div class="row product-moderate">
                                    <div class="col-sm-9 home-content_6">

        <div class="row">
            <div class="col-xs-10" style="padding-left: 5px">
                <h1 class="product-single_title">{$advert->getName()} {if $advert->isSecureDeal()}<img src="{$template}/img/safe_icon_bg.png" alt="">{/if}</h1>
            </div>
        </div>

                                        <div class="product-gallery">
                                            <div class="owl-carousel product_gal">
                                                {foreach from=$advert->getPhotos() item=$photo}
                                                    <img src="{$files_dir}{$photo}" alt="">
                                                {/foreach}
                                            </div>
                                        </div>
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Размещено
                    </div>
                    <div class="product-single-info_block product-views">
                        <div class="date">{date('d.m.Y', strtotime($advert->getDate()))}</div>
                        <div class="views">
                            <i></i>
                            <span>{$advert->getViews()}</span>
                        </div>


                        <div class="likes add_to_favorites" data-advert_id="{$advert->getId()}" style="margin-right: 0em; margin-top: 2px;">
                            {if $user == false}
                            <a href="#login" class="head-item_buttons open-forms" data-tab="panel1">
                            {/if}

                        {if $user != false && $advert->getAuthor()->getId() != $user->getId()}
                            <i {if !empty($user) AND in_array($advert->getId(), $user->getFavorites())}class="filled"{/if}></i>
                            <span class="counter">{$Adverts->getAdvertFavoritesCount($advert->getId())}</span>
                        {else}               
                            <span></span>
                        {/if}
                        {if $user == false}</a>{/if}
                        </div>


                        {if $user != false && $advert->getAuthor()->getId() == $user->getId()}
                        <div style="margin-right: 10em; margin-top: -23px;">
                        {if $user != false && $advert->getAuthor()->getId() == $user->getId()}    
                            <i class="icon-fav"></i>

                            <span>{$Adverts->getAdvertFavoritesCount($advert->getId())}</span>

                        {else}
                            <span></span>
                        {/if}
                        </div>
                        {/if}

                    </div>
                </div>
                {if $advert->getConditionType() > 0}
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Состояние
                    </div>
                    <div class="product-single-info_block">
                        {if $advert->getConditionType() == 1}
                            Новое
                        {else}
                            Б/У
                        {/if}
                    </div>
                </div>
                {/if}
                <div class="product-single_info">
                    <div class="product-single-info_label">
                        Описание
                    </div>
                    <div class="product-single-info_block">
                        {$advert->getDescription()}
                    </div>
                </div>

                    <div class="product-single_info">
                        <div class="product-single-info_label">
                            Место сделки
                        </div>

                        {if $advert->getLocation()->getId() >= 1 AND !empty($advert->getCity())}
                        <div class="product-single-info_block">
                            {$advert->getLocation()->getName()}{if $advert->getLocationName() != ''}, {$advert->getLocationName()}{/if}
                        </div>
                        {else}
                        <div class="product-single-info_block">
                            Передача через сеть
                        </div>
                        {/if}
                    </div>

                        {if $advert->getStatus() == 4}
                        <div class="product-single-info_block blocked">
                            Объявление заблокировано!
                        </div>
                        {/if}

                        {if $advert->getStatus() == 3}
                        <div class="product-single-info_block blocked">
                            Объявление в архиве!
                        </div>
                        {/if}                        
                             
                        {if $advert->getStatus() == 2}
                        <div class="product-single-info_block active">
                            Объявление опубликовано!
                        </div>
                        {/if}
                                    </div>
                                    <div class="col-sm-3 home-content_3">
                                        <div class="black-border_block home-sidebar_item">
                                            <div class="product-price">
                                                <div class="product-block_title text-center">
                                                    Цена
                                                </div>
                            <div class="{if !$advert->isSecureDeal()} not-secure{/if}">
                                {$prices = $advert->getPrices()}
                                {foreach from=$prices item=$price key=$type}
                                    <div class="product-single_price">
                                        <div class="product-single-price_icon">
                                            <img src="{$template}/img/{mb_strtolower($type)}.png" alt="">
                                            <p>{mb_strtoupper($type)}</p>
                                        </div>
                                        <span>{$price}</span>
                                    </div>
                                {/foreach}
                            </div>
                                            </div>
{*                                              <div class="product-rating">
                                                    <div class="product-block_title text-center">
                                                        Рейтинг товара
                                                    </div>   


                                                    <div class="product-profile_sales">
                                                        <div>
                                                            {include file='elements/advert/rating.tpl' rating=$advert->getRating()}           
                                                        </div>
                                                    </div>

                                                </div>      *}

                                            <div class="product-user">
                                                <div class="product-block_title text-center">
                                                    О продавце
                                                </div>
{*                                                <div class="prodcut-user_name">{$advert->getAuthor()->getLogin()}</div>
                                                <div class="product-user_info">
                                                    <div>
                                                        {$advert->getAuthor()->getPhone()}
                                                    </div>
                                                </div> *}
                                                <div class="product-user_info">
                                                    <div>
                                                        {$advert->getAuthor()->getEmail()}
                                                    </div>
                                                </div>
                                                {$last_admin_chat = $Chats->GetLastChatAdminByUserId($advert->getAuthor()->getId())}
                                                <div class="text-center"><a href="/admin/clients.php?type=chat&admin_id={$_COOKIE['id']}&user_id={$advert->getAuthor()->getId()}&chat_id={if !empty($last_admin_chat)}{$last_admin_chat[0]->getId()}{else}0{/if}" target="_blank" class="white-border-button">Написать в чат</a></div>
                                            </div>
                                            <div class="product-userrating ">
                                                <div class="product-block_title product-single_seller text-center">
                    {if !empty($advert->getAuthor()->getAvatar())}
                    {include file='elements/advert/rating.tpl' rating=$advert->getAuthor()->getRating()}

                        <div class="user-icon" style="background: #{$advert->getAuthor()->getColor()}">
                            <img src="/files/{$advert->getAuthor()->getAvatar()}">
                        </div>
                    {/if}
                    {if $user == false}
                        <a href="#login" class="user-name head-item_buttons head-item_register open-forms" data-tab="panel2">{$advert->getAuthor()->getLogin()}</a>
                    {else}
                        <a href="/dashboard.php?page=my_adverts&user_id={$advert->getAuthor()->getId()}" class="user-name">{$advert->getAuthor()->getLogin()}</a>
                    {/if}
                                                </div>
                                                <span><i class="like"></i> {$advert->getAuthor()->getLikes()}</span><span><i class="dislike"></i> {$advert->getAuthor()->getDislikes()}</span>

                        <div class="row">
                            <div class="col-xs-12">
                                {if $user == false}
                                    <a href="#login" class="user-links_in_sell head-item_buttons head-item_register open-forms" data-tab="panel2">Объявлений в продаже: <span>{$Users->getAdvertsCount($advert->getAuthor()->getId())}</span></a>
                                {else}
                                    <a href="/dashboard.php?page=my_adverts&user_id={$advert->getAuthor()->getId()}" class="user-links_in_sell">Объявлений в продаже: <span>{$Users->getAdvertsCount($advert->getAuthor()->getId())}</span></a>
                                {/if}
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6">
                                {if $user == false}
                                    <a href="#login" class="user-links_in_sell green head-item_buttons head-item_register open-forms" data-tab="panel2">Продал: <span>{$Users->getSells($advert->getAuthor()->getId())}</span></a>
                                {else}
                                    <a href="/dashboard.php?page=my_sells&user_id={$advert->getAuthor()->getId()}" class="user-links_in_sell green">Продал: <span>{$Users->getSells($advert->getAuthor()->getId())}</span></a>
                                {/if}
                            </div>
                            <div class="col-xs-6">
                                <a href="#" class="user-links_in_sell green-light">Купил: <span>{$Users->getBuys($advert->getAuthor()->getId())}</span></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <a href="#" class="user-links_in_sell gray">Зарегистрирован:  <span>{if $user != false}{date('d.m.Y', strtotime($user->getRegisterDate()))}{/if}</span></a>
                            </div>                        
                        </div>

                                            </div>
                                            <div class="product-reviews">
{*                                                <div class="product-block_title text-center">
                                                    Отзывы
                                                </div>
                                                <div class="product-reviews_block">
                                                    {foreach from=$advert->getAuthor()->getLastComments() item=$comment}
                                                        <div class="product-reviews_item">
                                                            <p>{$comment}</p>
                                                        </div>
                                                        {foreachelse}
                                                    {/foreach}
                                                </div>  *}
                                                <div class="text-center">
                                                    <a href="#author-reviews" class="white-border-button reviews" data-toggle="modal" data-advert-id="{$advert->getId()}" data-backdrop="static" data-keyboard="false">Посмотреть отзывы</a>
                                                </div>
                                            </div>

<div id="author-reviews" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title country">Отзывы о {$advert->getAuthor()->getLogin()}</h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="modal_reviews_run" method="POST" class="form-horizontal form-label-left">
          <div class="modal-body">
            {foreach from=$Users->getLastComments($advert->getAuthor()->getId()) item=$comment}
                <div class="reviews-item" data-like="{$comment['type']}" data-date="{strtotime($comment['date'])}" data-rating="{$comment['rating']}">
                    <div class="reviews-item_head">
                        <div class="avatar" style="background: #{$comment['color']}">
                            <img src="/files/{(!empty($comment['avatar'])) ? $comment['avatar'] : '/avatars/1.png'}" alt="">
                        </div>
                        <div class="name_author">{$Users->getLogin($comment['from'])}</div>
                        <div class="date_reviews">{$comment['date']}</div>
                        <div class="star_block product-single_seller">
                            {include file='elements/advert/rating.tpl' rating=$comment['rating']}  
                        </div>                        
                        <div class="score">
                                <i class="icon-like"></i>
                                <span>{$advert->getAuthor()->getLikes()}</span>
                                
                                <span>{$advert->getAuthor()->getDislikes()}</span>
                                <i class="icon-dislike"></i>
                        </div>                       
                    </div>
                    <div class="product-single_seller">
                        <p>{$comment['comment']}</p> 
                    </div>                    
                </div>
                {foreachelse}
            {/foreach}                        
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
          </div>
      </form>
    </div>
  </div>
</div>

                                            <div class="product-moderation text-center">
                            
                                                <a href="#modal_advert" class="white-border-button active" data-toggle="modal" data-advert-id="{$advert->getId()}" data-backdrop="static" data-keyboard="false" data-status="{if $advert->getStatus() == 2}1{else}2{/if}">{if $advert->getStatus() == 2}Активно, Снять?{else}Разместить{/if}</a>

                                                <a href="#modal_advert" class="white-border-button in_out_archive" data-toggle="modal" data-advert-id="{$advert->getId()}" data-backdrop="static" data-keyboard="false" data-status="{if $advert->getStatus() == 3}1{else}3{/if}">{if $advert->getStatus() == 3}Извлечь из архива{else}В архив{/if}</a>
                                                
                                                <a href="/edit_advert.php?id={$advert->getId()}" class="white-border-button" target="_blank">Редактировать</a>

{*                                            <a href="#" class="white-border-button">Грубое нарушение</a>  *}

                                                <a href="#modal_advert" class="white-border-button blocked" data-toggle="modal" data-advert-id="{$advert->getId()}" data-backdrop="static" data-keyboard="false" data-status="{if $advert->getStatus() == 4}1{else}4{/if}">{if $advert->getStatus() == 4}Разблокировать{else}Заблокировать{/if}</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}