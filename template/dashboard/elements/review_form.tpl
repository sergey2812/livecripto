{$anotherUser = ($deal->getSeller()->getId() == $user->getId()) ? $deal->getBuyer() : $deal->getSeller()}
<input type="hidden" name="deal_id" value="{$deal->getId()}">

<button title="Close (Esc)" type="button" class="mfp-close">×</button>
<div class="add-review_head text-center">
    <div class="add-review_head-title">Оставьте отзыв о сотрудничестве с <span><a href="/dashboard.php?page=my_adverts&user_id={$anotherUser->getId()}">{$anotherUser->getLogin()}</a></span></div>
</div>
<div class="add-review_body">
    <div class="row">
        <div class="col-xs-9">
            <div class="form-row">
                <label>Общий рейтинг<span>*</span>:</label>
                <div class="add-review_star" onClick="checkReview()">

                    <input id="star-0" type="radio" name="stars" value="5">
                    <label title="bad" for="star-0"></label>

                    <input id="star-1" type="radio" name="stars" value="4">
                    <label title="poor" for="star-1"></label>

                    <input id="star-2" type="radio" name="stars" value="3">
                    <label title="regular" for="star-2"></label>

                    <input id="star-3" type="radio" name="stars" value="2">
                    <label title="good" for="star-3"></label>

                    <input id="star-4" type="radio" name="stars" value="1" required>
                    <label title="gorgeous" for="star-4"></label>

                </div>
            </div>
            <div class="form-row">
                <label>Рекомендуете сотрудничать?<span>*</span></label>
                <div class="add-review_recently">
                    <input type="radio" name="like" checked="" value="1" required>
                    <label><i class="icon-like"></i></label>
                </div>
                <div class="add-review_recently">
                    <input type="radio" name="like" class="no" value="0">
                    <label><i class="icon-dislike"></i></label>
                </div>
            </div>
            <div class="form-row">
                <label>Ваш отзыв<span>*</span>:</label>
                <textarea name="message" onChange="checkReview()" maxlength="258" required></textarea>
                <button class="btn-submit" disabled>Отправить</button>
            </div>
        </div>
        {include file='elements/advert/advert.tpl' advert=$deal->getAdvert()}
    </div>
</div>