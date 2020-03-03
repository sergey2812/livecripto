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


    if (isset($_POST["country_id"]))
    {
        
        $result = $locations->GetCitiesOfCountry($_POST['country_id']);

            if (!empty($result)) {
                $data = [];
                foreach ($result as $city){
                    $data[] = [
                        'id' => $city->getId(),
                        'name' => $city->getName()
                    ];
                }
                $ajax->AddData($data);
                $ajax->Success();
            }


        echo json_encode($data); // возвращаем данные в JSON формате;
    }
    else
    {
        echo json_encode(array('Выберите страну'));
    }
 
    exit;