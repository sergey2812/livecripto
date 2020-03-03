<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 19.09.2018
 * Time: 7:59
 */

$admin_area = true;

require_once __DIR__.'/../engine/autoload.php';

header('Location: /admin/adverts.php?type=all');

$smarty->assign('banneds', $banneds);

$smarty->assign('page_title', 'Главная');

$smarty->display('admin/index.tpl');