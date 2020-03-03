<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:18
 */

namespace LiveinCrypto;

use LiveinCrypto\Types\Update_price;
use LiveinCrypto\Types\ClientUpdate;

class Update_prices extends Config
{
    /**
     * @var Mysqli
     */
    public $mysqli;

    /**
     * @var array
     */
    private $update_prices_params = [
        'id',
        'country',
        'city',
        'section',
        'category',
        'subcategory',
        'price_for_update'
    ];

    /**
     * @var array
     */
    private $update_clients_params = [
        'id',
        'advert_id',
        'user_id',
        'pay_date',
        'pay_sum',
        'crypta_code',
        'user_wallet',
        'admin_wallet',
        'start_date',
        'away_date',        
        'status',
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
        $this->mysqli->setTable('update_prices');

        $this->sections = new Sections();
        $this->adverts = new Adverts();
        $this->users = new Users();       
    }

    public function WrightUpdatePrices(array $params): int
    {
        $this->mysqli->setTable('update_prices');
        $country_id = $params['country'];
        $city_id = $params['city'];
        $section_id = $params['section'];
        $category_id = $params['category'];
        $subcategory_id = $params['subcategory'];
        $price_for_update = $params['price_for_update'];

        
        $result = $this->mysqli->query("SELECT id, country, city, section, category, subcategory, price_for_update FROM `update_prices` WHERE country = $country_id AND city = $city_id AND section = $section_id AND category = $category_id AND subcategory = $subcategory_id LIMIT 1");

        $update_params = [
            'country' => $country_id,
            'city' => $city_id,
            'section' => $section_id,
            'category' => $category_id,
            'subcategory' => $subcategory_id,
            'price_for_update' => $price_for_update
        ];         

        if (empty($result)) 
            {                
                $abc = $this->mysqli->insert($update_params);
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
                $update_id = $result[0]['id'];
                $abc = $this->mysqli->update($update_params, "id = '$update_id'", 1);
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

    public function GetUpdatePrices(array $params): string
    {
        $country_id = $this->mysqli->escape_string($params['country']);
        $city_id = $this->mysqli->escape_string($params['city']);
        $section_id = $this->mysqli->escape_string($params['section']);
        $category_id = $this->mysqli->escape_string($params['category']);
        $subcategory_id = $this->mysqli->escape_string($params['subcategory']);

        $result = $this->mysqli->query("SELECT price_for_update FROM `update_prices` WHERE country = $country_id AND city = $city_id AND section = $section_id AND category = $category_id AND subcategory = $subcategory_id LIMIT 1");

        if (empty($result)) 
            {
               $result = [];
               return $result;     
            }     
        else
            {
                $result = $result[0]['price_for_update'];
                return $result;
            }  
    }    

    public function WrightUpdateClientsData(array $params): int
    {
        $this->mysqli->setTable('update_clients_payed_history');

        $user_id = $params['user_id'];
        $advert_id = $params['advert_id'];
        $country = $params['country'];
        $city = $params['city'];
        
        $result = $this->mysqli->query("SELECT id, status, country, city FROM `update_clients_payed_history` WHERE user_id = $user_id AND advert_id = $advert_id AND status = 1 AND country = $country AND city = $city LIMIT 1");     
             
        if (empty($result)) 
            {
               $result = $this->mysqli->insert($params);
               $this->mysqli->setTable('update_prices'); 
               return 1;
            }     
        else
            {
                $this->mysqli->setTable('update_prices');
                return 0;
            }
           
    } 

    public function TakeClientsPaymentUpdate(array $params): int
    {
        $id = $params['id'];
        $start = $params['start_date'];
        $status = $params['status'];
        $update_date = date('Y-m-d H:i:s');
        $advert_id = $params['advert_id'];
      
        $result = $this->mysqli->query("UPDATE `update_clients_payed_history` SET start_date = '".$start."', status='".$status."' WHERE id = $id");

        $result2 = $this->mysqli->query("UPDATE `adverts` SET `date` = '".$update_date."' WHERE id = $advert_id"); 

        if ($result && $result2) 
            { 
               return 2;
            }     
        else
            {
                return 1;
            }  
    }

    public function AwayClientsPaymentUpdate(array $params): int
    {
        $this->mysqli->setTable('update_clients_payed_history');

        $id = $params['id'];
        $end = $params['away_date'];
        $status = $params['status'];
      
        $result = $this->mysqli->query("UPDATE `update_clients_payed_history` SET away_date = '".$end."', start_date = '', status='".$status."' WHERE id = $id"); 
        
        $this->mysqli->setTable('update_prices');                 

        if ($result) 
            { 
               return 4;
            }     
        else
            {
                return 3;
            }  
    }       

    public function GetAdvertStatusInUpdate(int $user_id, int $advert_id): int
    {
        $this->mysqli->setTable('update_clients_payed_history');
        $user_id = $this->mysqli->escape_string($user_id);
        $advert_id = $this->mysqli->escape_string($advert_id);

    $result = $this->mysqli->query("SELECT id FROM `update_clients_payed_history` WHERE user_id = $user_id AND advert_id = $advert_id AND status < 5 LIMIT 1");

        $this->mysqli->setTable('update_prices');

        if (!empty($result)) 
            {
               return 1;    
            }     
        else
            {
                return 0;
            }  
    }
       
    public function getClientsUpdateRowCount(): int
    {
        $this->mysqli->setTable('update_clients_payed_history');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `update_clients_payed_history`");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getAllClientsPaymentUpdate(): array
    {
        $this->mysqli->setTable('update_clients_payed_history');
        $result = $this->mysqli->select(['id', 'advert_id', 'user_id', 'pay_date', 'pay_sum', 'crypta_code', 'user_wallet', 'admin_wallet', 'status', 'start_date', 'away_date', 'country', 'city', 'section', 'category', 'subcategory'], '', 0, 'id DESC');
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToClientUpdate($result, true);
            } else{
                foreach ($result as $row) {
                    $return[] = $this->ConvertArrayToClientUpdate($row, true);
                }
            }
        }

        return $return;

    }

    private function ConvertArrayToClientUpdate(array $array): ClientUpdate
    {
        $ClientUpdate = new ClientUpdate();
        $ClientUpdate->setId($array['id']);
        $ClientUpdate->setAdvert($this->adverts->Get($array['advert_id']));
        $ClientUpdate->setUser($this->users->Get($array['user_id']));
        
        $old_date = date($array['pay_date']);
        $new_date = date('d.m.Y H:i', strtotime($old_date));
        $ClientUpdate->setPayDate($new_date);

        $ClientUpdate->setPaySum($array['pay_sum']);
        $ClientUpdate->setCryptaCode($array['crypta_code']);
        $ClientUpdate->setUserWallet($array['user_wallet']);
        $ClientUpdate->setAdminWallet($array['admin_wallet']);        

        $ClientUpdate->setStatus($array['status']);

        $old_date_start = date($array['start_date']);
        $new_date_start = date('d.m.Y', strtotime($old_date_start));
        $ClientUpdate->setStartDate($new_date_start);

        $old_date_away = date($array['away_date']);
        $new_date_away = date('d.m.Y', strtotime($old_date_away));
        $ClientUpdate->setAwayDate($new_date_away);       

        $ClientUpdate->setCountry($array['country']);
        $ClientUpdate->setCity($array['city']);
        $ClientUpdate->setSection($this->sections->GetSection($array['section']));
        $ClientUpdate->setCategory($this->sections->GetCategory($array['category']));
        $ClientUpdate->setSubCategory($this->sections->GetSubcategory($array['subcategory']));

        return $ClientUpdate;
    }      
  
}