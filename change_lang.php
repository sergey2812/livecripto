<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.11.2018
 * Time: 8:22
 */

if (!empty($_GET['lang'])) {

    $lang = 'ru_RU';
    if ($_GET['lang'] == 'en_US') {
        $lang = 'en_US';
    }

    setcookie('lang', $lang, time()+60*60*24*365, '/');
} else{
    setcookie('lang', '', time()-1, '/');
}

header("Location: {$_SERVER['HTTP_REFERER']}");