<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 0:47
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['id'])) {

    if ($adverts->isUserBuyer($_COOKIE['id'], $_POST['id'])){

        $type = (!empty($_POST['type']) AND $_POST['type'] == '1');

        $result = $adverts->UpdateReceived($_POST['id'], $type);

        if ($result){
            $ajax->Success();
        } else{
            $ajax->Error($result);
        }
    } else{
        $ajax->Error(_('Вы не покупатель этого объявления'));
    }

} else{
    $ajax->Error(_('Пожалуйста, заполните все поля.'));
}

$ajax->Echo();