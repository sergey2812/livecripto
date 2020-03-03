<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 19.09.2018
 * Time: 4:53
 */

require_once __DIR__.'/engine/autoload.php';

if ($user->getPermissions() <= 5 OR $adverts->isUserAuthor($user->getId(), $_GET['id'])) {

    $advert = $adverts->Get($_GET['id']);

    $smarty->assign('advert', $advert);
    $smarty->assign('locations', $locations->GetLocations());

	$smarty->assign('locations_cities', $locations->GetCities());    

	$smarty->assign('country', $locations);

    $smarty->assign('page_title', 'Редактировать объявление');
    $smarty->assign('edit_mode', true);

    $smarty->display('create_ad.tpl');

} else{
    header('Location: /');
}