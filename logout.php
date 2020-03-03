<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 05.10.2018
 * Time: 17:30
 */

setcookie('id', '', -1, '/');
setcookie('auth_key', '', -1, '/');
header('Location: /');
die();