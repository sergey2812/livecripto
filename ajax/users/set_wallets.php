<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 4:39
 */

require_once __DIR__ . "/../../engine/autoload.php";

$wallets_checker = new LiveinCrypto\Helpers\WalletsChecker();

$ajax = new \LiveinCrypto\Ajax();

if (!empty($_POST['wallets']) AND !empty($_POST['change_pass'])) {

    $login = $users->Login($_COOKIE['id'], $_POST['change_pass']);

    if ($login === true) {

        $wallets = json_decode($_POST['wallets'], true);

        /*if (!empty($wallets['btc'])) {
            if (!$wallets_checker->CheckBTC($wallets['btc'])){
                $ajax->Error(_('Неправильно указан BTC-кошелёк'));
            }
        }

        if (!empty($wallets['eth'])) {
            if (!$wallets_checker->CheckETH($wallets['eth'])){
                $ajax->Error(_('Неправильно указан ETH-кошелёк'));
            }
        }

        if (!empty($wallets['ltc'])) {
            if (!$wallets_checker->CheckLTC($wallets['ltc'])){
                $ajax->Error(_('Неправильно указан LTC-кошелёк'));
            }
        }

        if (!empty($wallets['xrp'])) {
            if (!$wallets_checker->CheckXRP($wallets['xrp'])){
                $ajax->Error(_('Неправильно указан XRP-кошелёк'));
            }
        }*/

        if (empty($ajax->GetError())) {
            $result = $users->UpdateWallet($wallets, $_COOKIE['id']);

            if ($result === true) {
                $ajax->Success();
            } else{
                $ajax->Error($result);
            }
        }
    } else{
        $ajax->Error(_('Неправильно указан пароль'));
    }
} else{
    $ajax->Error(_('Пожалуйста, заполните все поля'));
}

$ajax->Echo();