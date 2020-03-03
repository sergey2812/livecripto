<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 18.09.2018
 * Time: 7:37
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if ($_POST['id']) {

    $adverts = new \LiveinCrypto\Adverts();

    if ($adverts->isUserSeller($_COOKIE['id'], $_POST['deal_id']) OR $adverts->isUserBuyer($_COOKIE['id'], $_POST['deal_id'])) {

        $opener = ($adverts->isUserSeller($_COOKIE['id'], $_POST['advert_id'])) ? 1 : 2;

        $result = $adverts->OpenIncident($_POST['deal_id'], $opener);

        if ($result != false) {
            $ajax->Success();
        } else {
            $ajax->Error(_('Проверьте правильность заполнения формы'));
        }
    } else {
        $ajax->Error(_('Вы не автор этого объявления'));
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();