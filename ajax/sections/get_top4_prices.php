<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 19:07
 */

$safe_mode_disable = true;

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

    if (isset($_POST["id_country"]) AND isset($_POST["id_city"]) AND isset($_POST["active_section_id"]) AND isset($_POST["active_category_id"]) AND isset($_POST["active_subcategory_id"]) AND isset($_POST["position_top"]))
        {
            $params = [
                        'country' => $_POST["id_country"],
                        'city' => $_POST["id_city"],
                        'section' => $_POST["active_section_id"],
                        'category' => $_POST["active_category_id"],
                        'subcategory' => $_POST["active_subcategory_id"],
                        'price_top_x' => $_POST["position_top"]
                    ];

            $result = $top_4_prices->GetTop4Prices($params);
            
            if (!empty($result)) 
                {
                    $data = [];
                    $data = json_decode($result, true);
                    $ajax->AddData($data);
                    $ajax->Success();
                }  
            echo json_encode($data); // возвращаем данные в JSON формате;
        }
    else
        {
            echo json_encode(array('Укажите все параметры'));
        }
 
    exit;