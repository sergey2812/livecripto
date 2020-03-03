<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.09.2018
 * Time: 8:54
 */

require_once __DIR__ . "/../../engine/autoload.php";

if (!empty($_POST['deal_id'])) {

    $deal = $adverts->GetDeal($_POST['deal_id']);

    if ($deal->getSeller()->getId() == $_COOKIE['id'] OR $deal->getBuyer()->getId() == $_COOKIE['id']) {
        $smarty->assign('deal', $deal);
        $smarty->display('dashboard/elements/review_form.tpl');
    } else{
        die('Вы не участник этой сделки');
    }
} else{
    die('Пожалуйста, заполните все поля');
}