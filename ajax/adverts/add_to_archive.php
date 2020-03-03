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

if (isset($_POST['advert_id']) AND isset($_POST['type'])) {

    $adverts = new \LiveinCrypto\Adverts();

    if ($adverts->isUserAuthor($_COOKIE['id'], $_POST['advert_id'])) {

        if ($_POST['type'] == '1') {
            $result = $adverts->ToArchive($_POST['advert_id']);
        } else{
            $result = $adverts->FromArchive($_POST['advert_id']);
        }

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