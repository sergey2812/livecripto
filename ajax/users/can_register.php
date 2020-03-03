<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 4:32
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['value'])) {

    $value = $users->mysqli->escape_string($_POST['value']);
    $result = $users->GetAll("login = '$value' OR email = '$value'", 1);

    if (empty($result)) {
        $ajax->Success();
    }
}

$ajax->Echo();