<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 20:51
 */

require_once __DIR__.'/engine/autoload.php';

if ($user->hasBanned()){
    header('Location: /');
    die();
}

$smarty->assign('locations', $locations->GetLocations());

$smarty->assign('locations_cities', $locations->GetCities());

$smarty->assign('country', $locations);

$smarty->assign('all_cryptos', $currencies->getAllCryptos()); // новый вариант переменной с валютами со всеми полями

$smarty->assign('all_cryptos_bs', $currencies->getAllCryptosBs()); // новый вариант переменной с валютами со всеми полями для БС

$smarty->assign('page_title', 'Создать объявление');
$smarty->assign('edit_mode', false);

$smarty->assign('adsBlock9', $ads->Return(9, $sec_id, $cat_id, $subcat_id));

$smarty->assign('adsBlock10', $ads->Return(10, $sec_id, $cat_id, $subcat_id));

$smarty->display('create_ad.tpl');