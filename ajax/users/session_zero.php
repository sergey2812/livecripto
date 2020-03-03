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
$captcha = new \LiveinCrypto\Captcha();

$cookie_valid = time() + 604800;

setcookie('session', 0, $cookie_valid, '/');

$ajax->Echo();