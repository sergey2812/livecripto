<script src="{$template}/js/helpers/user_reviews.js"></script>

{$id = (empty($id)) ? 'reviews' : $id}

<div id="{$id}" class="mfp-hide reviews-popup">
    <div class="reviews-popup_head">
        <div class="row">
            <div class="col-sm-7">
                <div class="reviews-popup_head-title">Отзывы о <span>{if empty($empty) OR !$empty}{$user->getLogin()}{/if}</span></div>
            </div>
            {if empty($empty) OR !$empty}
                <div class="col-sm-5">
                    <select name="reviews_filter" style="width: 100%"></select>
                </div>
            {/if}
        </div>
    </div>
    <div class="reviews-popup_body">
        {if empty($empty) OR !$empty}
            {foreach from=$Users->getLastComments($user->getId()) item=$comment}
                <div class="reviews-item" data-like="{$comment['type']}" data-date="{strtotime($comment['date'])}" data-rating="{$comment['rating']}">
                    <div class="reviews-item_head">
                        <div class="avatar" style="background: #{$comment['color']}">
                            <img src="/files/{(!empty($comment['avatar'])) ? $comment['avatar'] : 'avatars/12.png'}" alt="">
                        </div>
                        <div class="name">{$Users->getLogin($comment['from'])}</div>
                        <div class="date">{$comment['date']}</div>
                        <div class="score">
                            <i class="icon-{if $comment['type'] == 0}dis{/if}like"></i>
                        </div>
                        <div class="stars">
                            {include file='elements/advert/rating.tpl' rating=$comment['rating']}
                        </div>
                    </div>
                    <p>{$comment['comment']}</p>
                </div>
                
            {/foreach}
        {else}
            <div class="reviews-item">
                <div class="reviews-item_head">
                    <div class="avatar">
                        <img src="{$template}/img/13.png" alt="">
                    </div>
                    <div class="name"></div>
                    <div class="score"></div>
                    {*<div class="stars">
                        {include file='elements/advert/rating.tpl' rating=5}
                    </div>*}
                </div>
                <p class="comment"></p>
            </div>
        {/if}
    </div>
</div>