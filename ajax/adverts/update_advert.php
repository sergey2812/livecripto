<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 9:37
 */

require_once __DIR__ . "/../../engine/autoload.php";

$ajax = new \LiveinCrypto\Ajax();

if ($user->getPermissions() <= 5 OR $adverts->isUserAuthor($_COOKIE['id'], $_POST['advert_id'])) {

    if (
        !empty($_POST['advert_id']) AND
        (!empty($_POST['location']) OR (!empty($_POST['without_location']) AND $_POST['without_location'] == '1')) AND
        !empty($_POST['prices']) AND
        isset($_POST['secure_deal'])
        ) 
    {
        if ($_POST['without_location'] != '1')
            {
                if (!empty($_POST['location_name']) AND $_POST['location_name'] != '' AND $_POST['location_name'] != NULL AND empty($_POST['location_name_new'])) 
                    {
                        $locationName = $locations->GetCityName($_POST['location_name']);

                        if ($locationName == 'Весь МИР')
                            {
                                $locationName = 'Передача через сеть';
                            }
                        $city_id = $_POST['location_name'];
                        $location = $_POST['location'];
                    } 
                else
                    {
                        $locationName = $_POST['location_name_new'];

                        $location = $_POST['location'];

                        $cities = $locations->GetCitiesOfCountry($_POST['location']);

                        if ($cities != array())
                            {
                                $city_exist = 0;
                                foreach ($cities as $gorod) 
                                    {
                                        if ($gorod->getName() == $_POST['location_name_new'])
                                            {       
                                                $city_id = $gorod->getId();
                                                $city_exist = 1;
                                            }
                                    }

                                if ($city_exist != 1)
                                    {
                                        $params = [
                                            'name' => $_POST["location_name_new"],
                                            'country' => $_POST["location"],
                                            'author' => 0
                                        ];

                                        $city_id = $locations->CreateCity($params); 
                                    }    
                            }
                        else
                            {
                                $params = [
                                    'name' => $_POST["location_name_new"],
                                    'country' => $_POST["location"],
                                    'author' => 0
                                ];

                                $city_id = $locations->CreateCity($params);
                            }
                    }
            }
        else
            {
                $world = 'Весь МИР';
                $locationName = 'Передача через сеть';
                $city_id = 0;
                $location = $locations->GetCountryIdByName($world);
            }        

                    $params = [
                        'location' => $location,
                        'prices' => $_POST['prices'],
                        'secure_deal' => $_POST['secure_deal'],
                        'city' => $city_id,
                        'location_name' => $locationName,
                    ];

                    $result = $adverts->Update($_POST['advert_id'], $params);

                    if ($result != false) {
                        $ajax->AddData(['new_advert_id' => $_POST['advert_id']]);
                        $ajax->Success();
                    } else{
                        $ajax->Error(_('Проверьте правильность заполнения формы'));
                    }


    } 
    else
    {
        $ajax->Error(_('Пожалуйста, заполните все поля'));
    }
} 
else
{
    $ajax->Error(_('Вы не автор этого объявления'));
}

$ajax->Echo();