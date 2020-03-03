{include file='elements/main/header.tpl'}

<script src="{$template}/js/functions/get_categories.js"></script>
<script src="{$template}/js/functions/show_more.js"></script>

{include file='elements/map_modal.tpl' easy_search='true'}

<div id="slider">
    <div class="owl-carousel owl-slider">
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');"></div>
            </a>
        </div>
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');"></div>
            </a>
        </div>
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');"></div>
            </a>
        </div>
        <div class="slider-item">
            <a href="#">
                <div class="slider-item_image" style="background: url('{$template}/img/42875.jpg');"></div>
            </a>
        </div>
    </div>
</div>

{include file='elements/main/best.tpl'}

<div id="cats" class="text-center">
    <div class="container">
        <ul>
            {if !empty($selected_section_categories)}
                {foreach from=$selected_section_categories item=$category}
                    <li>

                        <a href="/?section={$_GET['section']}&category={$category->getId()}">
                            <img src="/files/{$category->getIcon()}" alt="{htmlspecialchars($category->getName())}">
                            <span>{$category->getName()}</span>
                        </a>
                    </li>
                {/foreach}
            {/if}
        </ul>
    </div>
</div>

<div id="objects">
    <div class="container">
        <div class="row">
            <form class="col-xs-3 obj-filter no-ajax">
                <div class="form-row">
                    <select name="" id="filter_val" class="filter_select">
                        <option value="Выберите криптовалюту" data-first="true">{t}Выберите криптовалюту{/t}</option>
                        {foreach from=$currencies item=$cur}
                            <option value="{$cur['code']}" data-image="{$template}/img/{mb_strtolower({$cur['code']})}.png">{$cur['name']}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-row cs__purse" {if !empty($typeFilters)}style="display: block;"{/if}>
                    {foreach from=$typeFilters key=$type item=$value}
                        <div class="choice-purse__minmax" data-icon="/template/img/{mb_strtolower($type)}.png">
                            <label><img src="/template/img/{mb_strtolower($type)}.png" alt="" width="45"></label>
                            <div class="home-content-filter_check">
                                <input type="text" name="{$type}_min" id="min" placeholder="От" maxlength="8" value="{$value['min']}">
                            </div>
                            <div class="home-content-filter_check">
                                <input type="text" name="{$type}_max" placeholder="До" maxlength="8" value="{$value['max']}">
                            </div>
                            <div class="close">X</div>
                        </div>
                        {foreachelse}
                    {/foreach}
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['section'])}class="active"{/if}>{t}Раздел{/t}</span>
                        <div class="obj-filter-block_body" {if !empty($filters['section'])}style="display: block;"{/if}>
                            {foreach from=$sections item=$section}
                                <div>
                                    <input type="checkbox" name="section[]" value="{$section->getId()}" {if !empty($filters['section']) AND $filters['section'] == $section->getId()}checked{/if}>
                                    <label>{$section->getName()}</label>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['securedeal'])}class="active"{/if}>{t}Тип оплаты{/t}</span>
                        <div class="obj-filter-block_body" {if !empty($filters['securedeal'])}style="display: block;"{/if}>
                            <div>
                                <input type="checkbox" name="securedeal[]" {if !empty($filters['securedeal']) AND $filters['securedeal'] == 'on'}checked{/if}>
                                <label>{t}Безопасная сделка{/t}</label>
                            </div>
                            <div>
                                <input type="checkbox" name="securedeal[]" value="off" {if !empty($filters['securedeal']) AND $filters['securedeal'] == 'off'}checked{/if}>
                                <label>{t}Прямая сделка{/t}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <a href="#map" class="open-filter_map open-forms"><span>{t}Местоположение{/t}</span></a>
                    </div>
                </div>
                <div class="form-row">
                    <div class="obj-filter_block">
                        <span {if !empty($filters['delivery'])}class="active"{/if}>{t}Способ получения{/t}</span>
                        <div class="obj-filter-block_body" {if !empty($filters['delivery'])}style="display: block;"{/if}>
                            <div>
                                <input type="checkbox" name="delivery[]" value="on" {if !empty($filters['delivery']) AND $filters['delivery'] == 'on'}checked{/if}>
                                <label>{t}Личная встреча{/t}</label>
                            </div>
                            <div>
                                <input type="checkbox" name="delivery[]" value="off" {if !empty($filters['delivery']) AND $filters['delivery'] == 'off'}checked{/if}>
                                <label>{t}Передача через сеть{/t}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="btn-submit">{t}Начать поиск{/t}</button>

                <div class="home-converter" style="margin-top: 47px">
                    {include file='elements/main/rates.tpl' rates=$today_rates_widget}
                </div>

                <div class="text-center go-top_btn">
                    <a href="#top" class="go-top text-center">
                        <span>Наверх</span>
                        <svg version="1.1" id="не_закрашена" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                             x="0px" y="0px" viewBox="0 0 180.7 181.8" enable-background="new 0 0 180.7 181.8" xml:space="preserve">
                            <polygon fill="#CFD0CF" points="30.8,130.4 90.6,35.5 149.9,130.8 89.5,113.7 "/>
                            <circle fill="none" stroke="#CFD0CF" stroke-width="2" stroke-miterlimit="10" cx="90.3" cy="91" r="89"/>
                        </svg>
                    </a>
                </div>

            </form>
            <div class="col-xs-7 obj-body">
                <div class="search-title">Ошибка 404</div>
                <div class="seach-content">
                    <div class="error">По Вашему запросу ничего не найдено: </div>
                    <ul>
                        <li>Смягчите условия поиска</li>
                        <li>Используйте общие термины</li>
                        <li>Проверьте орфографию</li>
                        <li>Или перейдите на <a href="/" style="color: #009e91">главную страницу</a></li>
                    </ul>
                    <div class="search-help text-center">
                        <img src="{$template}/img/head-logo.png" alt="" width="100">
                        <p>Если вам нужна помощь, посетите раздел<br> <a href="/pages.php?page=help">Помощь</a> или <a href="#">Свяжитесь с нами</a></p>
                    </div>
                </div>
            </div>
            <div class="col-xs-2 obj-info">
                <div class="home_advertising">
                    <div class="advertising-item">
                        <div class="advertising-item_head text-center">
                            <span>Номер 8-800</span>
                            <img src="img/r-icon.png" alt="">
                            <p>без абонентской<br> платы</p>
                        </div>
                        <div class="advertising-item_foot">
                            <b>Номер 8800 от Ростелекома</b>
                            <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                        </div>
                    </div>
                    <div class="advertising-item">
                        <div class="advertising-item_head text-center">
                            <span>Номер 8-800</span>
                            <img src="img/r-icon.png" alt="">
                            <p>без абонентской<br> платы</p>
                        </div>
                        <div class="advertising-item_foot">
                            <b>Номер 8800 от Ростелекома</b>
                            <p>Более 30 000 свободных<br> номеров. Упраление<br> вызовами, переадерсация,<br> запись разговора</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='elements/main/footer.tpl'}