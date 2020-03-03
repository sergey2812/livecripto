<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.10.2018
 * Time: 23:34
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../engine/autoload.php";

$pos_top_1 = $top_4_prices->getAllTopAdvertsIdByPosition(1, $country_id, $city_id, $sec_id, $cat_id, $subcat_id);


if (!empty($pos_top_1)) 
    {
        $params = [
            'massive_ids' => (!empty($pos_top_1) ? json_encode($pos_top_1[0], true) : json_encode(array(), true)),
            'num_position' => 1
        ];
        
        $top_4_prices->SavedAdvertsIdsMassives($params);
    }
