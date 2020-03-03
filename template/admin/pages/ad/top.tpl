{include file='admin/elements/header.tpl'}

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <div class="title_left">
                        <h3>ТОП-4</h3>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel filter-box">
                            <div class="x_title">
                                <h2>Фильтр</h2>
                                <ul class="nav navbar-right panel_toolbox">
                                    <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="x_content">
                                <form action="" class="form-horizontal form-label-left">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="filter-item">
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Раздел</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>Товары</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Категория</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>Оргтехника</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Подкатегория</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>Принтеры и МФУ</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Страна/город</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>Москва</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="filter-item">
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Отсортировать</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>по новизне</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Дата поступления</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>за последние 24 часа</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Оплата</label>
                                                    <div class="col-md-5 col-sm-5 col-xs-12">
                                                        <select class="form-control">
                                                            <option>Безопасная сделка</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group filter_price">
                                                    <label class="control-label col-md-4 col-sm-4 col-xs-12">Цена: от</label>
                                                    <div class="col-sm-8 col-md-8 col-xs-12">
                                                        <input type="text" class="form-control" placeholder="0.00005">
                                                        <label class="control-label">до</label>
                                                        <input type="text" class="form-control" placeholder="0.00009">
                                                        <select class="form-control">
                                                            <option>BTC</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="btn-filter">
                                                    <button class="btn btn-success btn-sm col-md-offset-4">Применить фильтр</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="products-wrap">
                    <div class="row">
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="product-item">
                                <div class="product-item-body">
                                    <div class="product-item_image">
                                        <img src="img/runningsnail.png" alt="">
                                    </div>
                                    <div class="product-item_title">RunningSnail Emergency Solar Crank NOAA Weather Emergen Radio...</div>
                                    <div class="product-item_price">
                                        <div class="row">
                                            <div class="col-sm-5 col-xs-5">
                                                <img src="img/btc-icon.png" alt="">
                                            </div>
                                            <div class="col-sm-7 col-xs-7 text-right">
                                                <span>0.012</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-item_bottom">
                                    <div class="product-item-bottom__likes">
                                        <i></i> 1234
                                    </div>
                                    <div class="product-item-bottom__dislikes">
                                        <i></i> 15
                                    </div>
                                    <div class="product-item-bottom__stars">
                                        <i></i>
                                        <span>17</span>
                                    </div>
                                </div>
                                <div class="product-item_best">Best Seller</div>
                                <div class="product-item_addons">
                                    <i class="crypto-addons"></i>
                                    <a href="#" class="add-to-fav">
                                        <svg width="640" height="480" viewbox="0 0 640 480" xmlns="http://www.w3.org/2000/svg">
                                            <g class="layer1">
                                                <path class="svg_2" d="m219.28949,21.827393c-66.240005,0 -119.999954,53.76001 -119.999954,120c0,134.755524 135.933151,170.08728 228.562454,303.308044c87.574219,-132.403381 228.5625,-172.854584 228.5625,-303.308044c0,-66.23999 -53.759888,-120 -120,-120c-48.047913,0 -89.401611,28.370422 -108.5625,69.1875c-19.160797,-40.817078 -60.514496,-69.1875 -108.5625,-69.1875z"/> </path>
                                            </g>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="product-item">
                                <div class="product-item-body">
                                    <div class="product-item_image">
                                        <img src="img/runningsnail.png" alt="">
                                    </div>
                                    <div class="product-item_title">RunningSnail Emergency Solar Crank NOAA Weather Emergen Radio...</div>
                                    <div class="product-item_price">
                                        <div class="row">
                                            <div class="col-sm-5 col-xs-5">
                                                <img src="img/btc-icon.png" alt="">
                                            </div>
                                            <div class="col-sm-7 col-xs-7 text-right">
                                                <span>0.012</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-item_bottom">
                                    <div class="product-item-bottom__likes">
                                        <i></i> 1234
                                    </div>
                                    <div class="product-item-bottom__dislikes">
                                        <i></i> 15
                                    </div>
                                    <div class="product-item-bottom__stars">
                                        <i></i>
                                        <span>17</span>
                                    </div>
                                </div>
                                <div class="product-item_best">Best Seller</div>
                                <div class="product-item_addons">
                                    <i class="crypto-addons"></i>
                                    <a href="#" class="add-to-fav">
                                        <svg width="640" height="480" viewbox="0 0 640 480" xmlns="http://www.w3.org/2000/svg">
                                            <g class="layer1">
                                                <path class="svg_2" d="m219.28949,21.827393c-66.240005,0 -119.999954,53.76001 -119.999954,120c0,134.755524 135.933151,170.08728 228.562454,303.308044c87.574219,-132.403381 228.5625,-172.854584 228.5625,-303.308044c0,-66.23999 -53.759888,-120 -120,-120c-48.047913,0 -89.401611,28.370422 -108.5625,69.1875c-19.160797,-40.817078 -60.514496,-69.1875 -108.5625,-69.1875z"/> </path>
                                            </g>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="product-item">
                                <div class="product-item-body">
                                    <div class="product-item_image">
                                        <img src="img/runningsnail.png" alt="">
                                    </div>
                                    <div class="product-item_title">RunningSnail Emergency Solar Crank NOAA Weather Emergen Radio...</div>
                                    <div class="product-item_price">
                                        <div class="row">
                                            <div class="col-sm-5 col-xs-5">
                                                <img src="img/btc-icon.png" alt="">
                                            </div>
                                            <div class="col-sm-7 col-xs-7 text-right">
                                                <span>0.012</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-item_bottom">
                                    <div class="product-item-bottom__likes">
                                        <i></i> 1234
                                    </div>
                                    <div class="product-item-bottom__dislikes">
                                        <i></i> 15
                                    </div>
                                    <div class="product-item-bottom__stars">
                                        <i></i>
                                        <span>17</span>
                                    </div>
                                </div>
                                <div class="product-item_best">Best Seller</div>
                                <div class="product-item_addons">
                                    <i class="crypto-addons"></i>
                                    <a href="#" class="add-to-fav">
                                        <svg width="640" height="480" viewbox="0 0 640 480" xmlns="http://www.w3.org/2000/svg">
                                            <g class="layer1">
                                                <path class="svg_2" d="m219.28949,21.827393c-66.240005,0 -119.999954,53.76001 -119.999954,120c0,134.755524 135.933151,170.08728 228.562454,303.308044c87.574219,-132.403381 228.5625,-172.854584 228.5625,-303.308044c0,-66.23999 -53.759888,-120 -120,-120c-48.047913,0 -89.401611,28.370422 -108.5625,69.1875c-19.160797,-40.817078 -60.514496,-69.1875 -108.5625,-69.1875z"/> </path>
                                            </g>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="product-item">
                                <div class="product-item-body">
                                    <div class="product-item_image">
                                        <img src="img/runningsnail.png" alt="">
                                    </div>
                                    <div class="product-item_title">RunningSnail Emergency Solar Crank NOAA Weather Emergen Radio...</div>
                                    <div class="product-item_price">
                                        <div class="row">
                                            <div class="col-sm-5 col-xs-5">
                                                <img src="img/btc-icon.png" alt="">
                                            </div>
                                            <div class="col-sm-7 col-xs-7 text-right">
                                                <span>0.012</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-item_bottom">
                                    <div class="product-item-bottom__likes">
                                        <i></i> 1234
                                    </div>
                                    <div class="product-item-bottom__dislikes">
                                        <i></i> 15
                                    </div>
                                    <div class="product-item-bottom__stars">
                                        <i></i>
                                        <span>17</span>
                                    </div>
                                </div>
                                <div class="product-item_best">Best Seller</div>
                                <div class="product-item_addons">
                                    <i class="crypto-addons"></i>
                                    <a href="#" class="add-to-fav">
                                        <svg width="640" height="480" viewbox="0 0 640 480" xmlns="http://www.w3.org/2000/svg">
                                            <g class="layer1">
                                                <path class="svg_2" d="m219.28949,21.827393c-66.240005,0 -119.999954,53.76001 -119.999954,120c0,134.755524 135.933151,170.08728 228.562454,303.308044c87.574219,-132.403381 228.5625,-172.854584 228.5625,-303.308044c0,-66.23999 -53.759888,-120 -120,-120c-48.047913,0 -89.401611,28.370422 -108.5625,69.1875c-19.160797,-40.817078 -60.514496,-69.1875 -108.5625,-69.1875z"/> </path>
                                            </g>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-center">
                        <a href="#" class="yel-button show-more">Show more</a>
                    </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}