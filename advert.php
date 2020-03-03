<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.09.2018
 * Time: 20:56
 */

$safe_mode_disable = true;

require_once __DIR__.'/engine/autoload.php';

if ($user !== false AND $user->hasBanned()){
    header('Location: /');
    die();
}

$advert = $adverts->Get($_GET['id']);
if ($advert->getId() <= 0) header('Location: /404.php');

$subcategory_id = $advert->getSubcategory()->getId();
$advert_id = $advert->getId();
$similar_adverts = $adverts->GetAll("subcategory = '$subcategory_id' AND status='2' AND id != '$advert_id'", 20);

$views = (!empty($advert->getViews())) ? $advert->getViews() + 1 : 1;
$adverts->Update($advert->getId(), ['views' => $views]);

$smarty->assign('advert', $advert);
$smarty->assign('adverts', $similar_adverts);

$smarty->assign('page_title', $advert->getName());

$smarty->assign('adsBlock7', $ads->Return(7, $sec_id, $cat_id, $subcat_id));

$smarty->assign('adsBlock8', $ads->Return(8, $sec_id, $cat_id, $subcat_id));


$smarty->display('advert.tpl');