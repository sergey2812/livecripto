<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.09.2018
 * Time: 8:54
 */

require_once __DIR__ . "/../../engine/autoload.php";

// $ajax = new \LiveinCrypto\Ajax();


if (!empty($_POST['function'])){
    $function = $_POST['function'];

    if ($function == 'advert' AND !empty($_POST['idadvert']) AND !empty($_POST['idfrom']) AND !empty($_POST['idto'])){
        $deal_id = 0;
        $adverts->CreateCauseUserBan($deal_id, $_POST['idadvert'], ($_POST['idfrom']), $_POST['idto'], $_POST['report'], date('Y-m-d H:i:s'));

        $users->Update($_POST['idto'], ['banned_cause' => 1]);

//    $ajax->Success();

    } elseif($function == 'deal' AND !empty($_POST['iddeal']) AND !empty($_POST['idfrom']) AND !empty($_POST['idto'])){
        $advert_id = 0;
        $adverts->CreateCauseUserBan($_POST['iddeal'], $advert_id, ($_POST['idfrom']), $_POST['idto'], $_POST['report'], date('Y-m-d H:i:s'));
        $users->Update($_POST['idto'], ['banned_cause' => 1]);

//    $ajax->Success();
    }
}

 else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

// $ajax->Echo();
header("Location: {$_SERVER['HTTP_REFERER']}");