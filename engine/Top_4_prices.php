<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:18
 */

namespace LiveinCrypto;

use LiveinCrypto\Types\Top_4_price;
use LiveinCrypto\Types\ClientTop4;

class Top_4_prices extends Config
{

    /**
     * @var Mysqli
     */
    public $mysqli;

    /**
     * @var array
     */
    private $top_4_prices_params = [
        'id',
        'country',
        'city',
        'section',
        'category',
        'subcategory',
        'price_top_1',
        'price_top_2',
        'price_top_3',
        'price_top_4'
    ];

    /**
     * @var array
     */
    private $top_4_clients_params = [
        'id',
        'advert_id',
        'user_id',
        'pay_date',
        'pay_sum',
        'crypta_code',
        'user_wallet',
        'admin_wallet',
        'status',
        'start_date',
        'end_date',
        'days',
        'top_position',
        'country',
        'city',
        'section',
        'category',
        'subcategory'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('top_4_prices');

        $this->sections = new Sections();
        $this->adverts = new Adverts();
        $this->users = new Users();       
    }

    public function WrightTop4Prices(array $params): int
    {
        $this->mysqli->setTable('top_4_prices');
        $country_id = $params['country'];
        $city_id = $params['city'];
        $section_id = $params['section'];
        $category_id = $params['category'];
        $subcategory_id = $params['subcategory'];
        $price_top_1 = $params['price_top_1'];
        $price_top_2 = $params['price_top_2'];
        $price_top_3 = $params['price_top_3'];
        $price_top_4 = $params['price_top_4'];
        
        $result = $this->mysqli->query("SELECT id, country, city, section, category, subcategory, price_top_1, price_top_2, price_top_3, price_top_4 FROM `top_4_prices` WHERE country = $country_id AND city = $city_id AND section = $section_id AND category = $category_id AND subcategory = $subcategory_id LIMIT 1");

        if (empty($result)) 
            {
                    $top_4_prices_params = [
                    'country' => $country_id,
                    'city' => $city_id,
                    'section' => $section_id,
                    'category' => $category_id,
                    'subcategory' => $subcategory_id,
                    'price_top_1' => $price_top_1,
                    'price_top_2' => $price_top_2,
                    'price_top_3' => $price_top_3,
                    'price_top_4' => $price_top_4
                ];
                
                $abc = $this->mysqli->insert($top_4_prices_params); 
                if ($abc) 
                    {
                       return 2;    
                    }     
                else
                    {
                        return 1;
                    }
            }     
        elseif (!empty($result))
            {  
                    $top_4_prices_params = [
                    'country' => $result[0]['country'],
                    'city' => $result[0]['city'],
                    'section' => $result[0]['section'],
                    'category' => $result[0]['category'],
                    'subcategory' => $result[0]['subcategory'],

                    'price_top_1' => ($price_top_1 === array()) ? $result[0]['price_top_1'] : $price_top_1,
                    'price_top_2' => ($price_top_2 === array()) ? $result[0]['price_top_2'] : $price_top_2,
                    'price_top_3' => ($price_top_3 === array()) ? $result[0]['price_top_3'] : $price_top_3,
                    'price_top_4' => ($price_top_4 === array()) ? $result[0]['price_top_4'] : $price_top_4
                ];

                $top4_id = $result[0]['id'];
                $abc = $this->mysqli->update($top_4_prices_params, "id = '$top4_id'", 1); 
                if ($abc) 
                    {
                       return 2;    
                    }     
                else
                    {
                        return 1;
                    }                
            }
    }    

    public function GetTop4Prices(array $params): string
    {
        $country_id = $this->mysqli->escape_string($params['country']);
        $city_id = $this->mysqli->escape_string($params['city']);
        $section_id = $this->mysqli->escape_string($params['section']);
        $category_id = $this->mysqli->escape_string($params['category']);
        $subcategory_id = $this->mysqli->escape_string($params['subcategory']);
        $price_top = $this->mysqli->escape_string($params['price_top_x']);

        if ($price_top == 1)
            {
                $price_top_x = 'price_top_1';
            }
        if ($price_top == 2)
            {
                $price_top_x = 'price_top_2';
            }
        if ($price_top == 3)
            {
                $price_top_x = 'price_top_3';
            }
        if ($price_top == 4)
            {
                $price_top_x = 'price_top_4';
            }

        $result = $this->mysqli->query("SELECT $price_top_x FROM `top_4_prices` WHERE country = $country_id AND city = $city_id AND section = $section_id AND category = $category_id AND subcategory = $subcategory_id LIMIT 1");

        if (empty($result)) 
            {
               $result = [];
               return $result;     
            }     
        else
            {
                $result = $result[0][$price_top_x];
                return $result;
            }  
    }    

    public function WrightTop4ClientsData(array $params): int
    {
        $this->mysqli->setTable('top_4_clients_payed_history');

        $user_id = $params['user_id'];
        $advert_id = $params['advert_id'];
        $top_position = $params['top_position'];
        $country = $params['country'];
        $city = $params['city'];
        $section = $params['section'];
        $category = $params['category'];
        $subcategory = $params['subcategory'];
        
        $result = $this->mysqli->query("SELECT id FROM `top_4_clients_payed_history` WHERE user_id = $user_id AND advert_id = $advert_id AND status = 1 AND top_position = $top_position AND country = $country AND city = $city AND section = $section AND category = $category AND subcategory = $subcategory LIMIT 1");     
             
        if (empty($result)) 
            {
               $result = $this->mysqli->insert($params);
               $this->mysqli->setTable('top_4_prices'); 
               return 1;
            }     
        else
            {
                $this->mysqli->setTable('top_4_prices');
                return 0;
            }
           
    }    

    public function TakeClientsPaymentTop(array $params): int
    {
        $this->mysqli->setTable('top_4_clients_payed_history');

        $id = $params['id'];
        $start = $this->mysqli->escape_string($params['start_date']);
        $end = $this->mysqli->escape_string($params['end_date']);
        $status = $params['status'];
      
        $result = $this->mysqli->query("UPDATE `top_4_clients_payed_history` SET start_date = '".$start."', end_date = '".$end."', status='".$status."' WHERE id = $id"); 
        
        $this->mysqli->setTable('top_4_prices');                 

        if ($result) 
            { 
               return 2;
            }     
        else
            {
                return 1;
            }  
    }

    public function AwayClientsPaymentTop(array $params): int
    {
        $this->mysqli->setTable('top_4_clients_payed_history');

        $id = $params['id'];
        $end = $params['end_date'];
        $status = $params['status'];
      
        $result = $this->mysqli->query("UPDATE `top_4_clients_payed_history` SET end_date = '".$end."', start_date = '', status='".$status."' WHERE id = $id"); 
        
        $this->mysqli->setTable('top_4_prices');                 

        if ($result) 
            { 
               return 4;
            }     
        else
            {
                return 3;
            }  
    }

    public function GetAdvertStatusInTop4(int $user_id, int $advert_id): int
    {
        $this->mysqli->setTable('top_4_clients_payed_history');
        $user_id = $this->mysqli->escape_string($user_id);
        $advert_id = $this->mysqli->escape_string($advert_id);

    $result = $this->mysqli->query("SELECT id FROM `top_4_clients_payed_history` WHERE user_id = $user_id AND advert_id = $advert_id AND status < 5 LIMIT 1");

        $this->mysqli->setTable('top_4_prices');

        if (!empty($result)) 
            {
               return 1;    
            }     
        else
            {
                return 0;
            }  
    }

    public function getAllClientsPaymentTop(): array
    {
        $this->mysqli->setTable('top_4_clients_payed_history');
        $result = $this->mysqli->select(['id', 'advert_id', 'user_id', 'pay_date', 'pay_sum', 'crypta_code', 'user_wallet', 'admin_wallet', 'status', 'start_date', 'end_date', 'days', 'top_position', 'country', 'city', 'section', 'category', 'subcategory'], '', 0, 'id DESC');
        $return = [];
        $this->mysqli->setTable('top_4_prices');

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToClientTop4($result, true);
            } else{
                foreach ($result as $row) {
                    $return[] = $this->ConvertArrayToClientTop4($row, true);
                }
            }
        }

        return $return;

    }

    public function getAllTopAdvertsIdByPosition(int $num_pos, int $country_id, int $city_id, int $sec_id, int $cat_id, int $subcat_id): array
    {
        $date = date("Y-m-d");

        $this->mysqli->setTable('top_4_clients_payed_history');
        $num_pos = $this->mysqli->escape_string($num_pos);
        $country_id = $this->mysqli->escape_string($country_id);
        $city_id = $this->mysqli->escape_string($city_id);
        $sec_id = $this->mysqli->escape_string($sec_id);
        $cat_id = $this->mysqli->escape_string($cat_id);
        $subcat_id = $this->mysqli->escape_string($subcat_id);

        $result = $this->mysqli->select(['advert_id'], "status = 2 AND top_position = '$num_pos' AND country = '$country_id' AND city = '$city_id' AND section = '$sec_id' AND category = '$cat_id' AND subcategory = '$subcat_id' AND start_date <= '$date' AND end_date >= '$date'");

        $this->mysqli->setTable('top_4_prices');
   
        $return = [];
        if ($result != array()) 
        {
            if ($this->mysqli->num_rows == 1) 
            {
                $return[] = $result['advert_id'];
            } 
            else
            {
                foreach ($result as $row) 
                {
                    $return[] = $row['advert_id'];
                }
            }
            
        }
        return $return;
    }    

    public function getOneClientPaymentTopRows(int $user_id): array
    {
        $this->mysqli->setTable('top_4_clients_payed_history');
        $user_id = $this->mysqli->escape_string($user_id);
        $result = $this->mysqli->select(['id', 'advert_id', 'user_id', 'pay_date', 'pay_sum', 'crypta_code', 'user_wallet', 'admin_wallet', 'status', 'start_date', 'end_date', 'days', 'top_position', 'country', 'city', 'section', 'category', 'subcategory'], "id = '$user_id'");
        $return = [];
        $this->mysqli->setTable('top_4_prices');

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToClientTop4($result, true);
            } else{
                foreach ($result as $row) {
                    $return[] = $this->ConvertArrayToClientTop4($row, true);
                }
            }
        }

        return $return;

    }    

    public function getClientsTop4RowCount(): int
    {
        $this->mysqli->setTable('top_4_clients_payed_history');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `top_4_clients_payed_history`");
        $count = $count[0];
        $this->mysqli->setTable('top_4_prices');

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function SavedAdvertsIdsMassives(array $params): int
    {
        $massive_ids = $params['massive_ids'];
        $num_position = $params['num_position'];
        
        $result = $this->mysqli->query("SELECT id, massive_ids FROM `adverts_random` WHERE num_position = $num_position LIMIT 1");

        $abc = false;        

        if (empty($result)) 
            {
                $params = [
                    'massive_ids' => $massive_ids,
                    'num_position' => $num_position
                ];
                $this->mysqli->setTable('adverts_random');
                $abc = $this->mysqli->insert($params); 
                $this->mysqli->setTable('top_4_prices');
            }     
        elseif (!empty($result))
            {  
                $params = [
                    'massive_ids' => $massive_ids
                ];
                $this->mysqli->setTable('adverts_random');
                $id = $result[0]['id'];
                $abc = $this->mysqli->update($params, "id = '$id'", 1); 
                $this->mysqli->setTable('top_4_prices');               
            }
        
        if ($abc) 
            {
               return 2;    
            }     
        else
            {
                return 1;
            }             
    }  

    public function getdAdvertsIdsMassives(int $num_pos): array
    {
        $this->mysqli->setTable('adverts_random');
        $num_pos = $this->mysqli->escape_string($num_pos);

        $result = $this->mysqli->select(['massive_ids'], "num_position = '$num_pos'");

        $this->mysqli->setTable('top_4_prices');
   
        $return = [];

        if ($result != array()) 
            {
                $result = json_decode($result['massive_ids'], true);
                $return[] = $result;
            }
        return $return;
    }               

    private function ConvertArrayToClientTop4(array $array): ClientTop4
    {
        $ClientTop4 = new ClientTop4();
        $ClientTop4->setId($array['id']);
        $ClientTop4->setAdvert($this->adverts->Get($array['advert_id']));
        $ClientTop4->setUser($this->users->Get($array['user_id']));
        
        $old_date = date($array['pay_date']);
        $new_date = date('d.m.Y H:i', strtotime($old_date));
        $ClientTop4->setPayDate($new_date);

        $ClientTop4->setPaySum($array['pay_sum']);
        $ClientTop4->setCryptaCode($array['crypta_code']);
        $ClientTop4->setUserWallet($array['user_wallet']);
        $ClientTop4->setAdminWallet($array['admin_wallet']);        

        $ClientTop4->setStatus($array['status']);

        $old_date_start = date($array['start_date']);
        $new_date_start = date('d.m.Y', strtotime($old_date_start));
        $ClientTop4->setStartDate($new_date_start);

        $old_date_end = date($array['end_date']);
        $new_date_end = date('d.m.Y', strtotime($old_date_end));
        $ClientTop4->setEndDate($new_date_end);
        
        $ClientTop4->setDays($array['days']);
        $ClientTop4->setTopPosition($array['top_position']);
        $ClientTop4->setCountry($array['country']);
        $ClientTop4->setCity($array['city']);
        $ClientTop4->setSection($array['section']);
        $ClientTop4->setCategory($array['category']);
        $ClientTop4->setSubCategory($array['subcategory']);

        return $ClientTop4;
    }  
}