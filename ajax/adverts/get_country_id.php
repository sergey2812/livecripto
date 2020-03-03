<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.09.2018
 * Time: 8:54
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

global $country_id;



    if (isset($_GET["country_id"]))
    {
        $list_cities = $locations->GetCitiesOfCountry($_GET['country_id']);

        echo json_encode($list_cities); // возвращаем данные в JSON формате;

        $smarty->assign('list_cities', $list_cities);
    }
    else
    {
        echo json_encode(array('Выберите страну'));
    }
 
    exit;

