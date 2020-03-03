<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 9:42
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Advert;
use LiveinCrypto\Types\Deal;
use LiveinCrypto\Types\Location;
use LiveinCrypto\Types\City;

class Adverts extends Config
{

    /**
     * @var Mysqli
     */
    public $mysqli;

    /**
     * @var Sections
     */
    private $sections;

    /**
     * @var Statuses
     */
    private $statuses;

    /**
     * @var Users
     */
    private $users;

    /**
     * @var Photos
     */
    private $photos;

    /**
     * @var Prices
     */
    private $prices;
    /**
     * @var ExchangeRates
     */
    private $rates;
    private $notifications;
    private $locations;
    private $locations_cities;


    /**
     * @var array
     */
    private $advert_params = [
        'id',
        'section',
        'category',
        'subcategory',
        'name',
        'condition_type',
        'description',
        'location_name',
        'city',
        'location',
        'photos',
        'prices',
        'author',
        'date',
        'status',
        'secure_deal',
        'views'
    ];

    /**
     * @var array
     */
    private $deal_params = [
        'id',
        'advert_id',
        'seller_id',
        'buyer_id',
        'admin_id',
        'buyer_wallet',
        'seller_wallet',
        'admin_wallet',
        'buyer_type',
        'status',
        'secure_deal',
        'price',
        'summ_to_seller',
        'royalty',
        'date',
        'incident_opener',
        'incident',
        'pay_date',
        'pay_confirmation_date',
        'chat',
        'send_product_date',
        'resive_confirmation_date',
        'send_pay_to_seller_date'
        
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('adverts');

        $this->sections = new Sections();
        $this->users = new Users();
        $this->photos = new Photos();
        $this->prices = new Prices();
        $this->rates = new ExchangeRates();
        $this->notifications = new Notifications();
        $this->locations = new Locations();

    }

    public function getCount(string $where = ''): int
    {
        $where = (!empty($where)) ? 'WHERE '.$where : '';
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `adverts` $where");

        if (!empty($count))
            { 
                $count = $count[0];
                return $count['count'];
            }
        else
            {
                return 0;
            }
    }

    public function getCountSecureDeals(): int
    {
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `deals` WHERE secure_deal = 1");

        if (!empty($count))
            { 
                $count = $count[0];
                return $count['count'];
            }
        else
            {
                return 0;
            }
    }    

    public function getAdvertFavoritesCount(int $advertId): int
    {
        $advertId = $this->mysqli->escape_string($advertId);
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `users` WHERE favorites LIKE '%$advertId,%' OR favorites LIKE '%$advertId]'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count']-0;
        return 0;
    }

    public function Create(array $params): ?int
    {

        $valid = true;

        foreach ($params as $key => $value) {
            if ($key == 'section'){
                if (!$this->sections->CheckSections('sections', $value)){
                    $valid = false;
                }
            } elseif($key == 'category'){
                if (!$this->sections->CheckSections('categories', $value)){
                    $valid = false;
                }
            } elseif($key == 'subcategory'){
                if (!$this->sections->CheckSections('subcategories', $value)){
                    $valid = false;
                }
            } elseif($key == 'name'){
                if (strlen($value) > 255){
                    $valid = false;
                }
            } elseif($key == 'description'){
                $value = strip_tags($value);
                if (strlen($value) > 65535){
                    $valid = false;
                } else{
                    $value = str_replace("\n", '</p><p>', $value);
                    $value = "<p>$value</p>";
                    $params['description'] = $value;
                }
            } elseif($key == 'author'){
                if (!$this->users->CheckUserId($value)){
                    $valid = false;
                }
            } elseif($key == 'photos'){
                json_decode($value);
                if (json_last_error() != JSON_ERROR_NONE){
                    $valid = false;
                }
            } elseif($key == 'secure_deal'){
                if ($value != '0' AND $value != '1'){
                    $valid = false;
                }
            }
        }

        if ($valid) {
            //print_r($params);
            if ($this->mysqli->insert($params)) {
                return $this->mysqli->insert_id;
            } else{
                return false;
            }
        } else{
            return false;
        }

    }
    

    public function Update(int $id, array $params): bool
    {

        if (!empty($params['status']) AND $params['status'] == 2){
            $advert = $this->Get($id);
            $user_id = $advert->getAuthor()->getId();
            $this->notifications->CreateNotification($user_id, 'adverts');
        }

        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update($params, "id = '$id'", 1);

    }

    public function ToArchive(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update(['status' => 3], "id = '$id'", 1);
    }

    public function FromArchive(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update(['status' => 2], "id = '$id'", 1);
    }

    public function Get(int $id): Advert
    {

        $result = $this->mysqli->select($this->advert_params, "id = '$id'", 1);

        if (!empty($result)) {
            return $this->ConvertArrayToAdvert($result);
        } else{
            return new Advert();
        }
    }

    public function GetAll(string $where = '', int $limit = 0, array $order = [], int $offset = 0): array
    {
        if (!empty($order)){

            $order[0] = strtolower($order[0]);

            if ($order[0] == 'date'){
                $order_string = 'date DESC';
            } else if (!empty($order[1])) {
                $order_string = $order[1];
            }

        } else{
            $order_string = 'date DESC';
        }

        $result = $this->mysqli->select($this->advert_params, $where, $limit, $order_string, '', $offset);

        $return = [];

        if (!empty($result)) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToAdvert($result);
            } else{
                foreach ($result as $array) {
                    $return[] = $this->ConvertArrayToAdvert($array);
                }
            }
        }

        return $return;

    }

    public function UpdateOverallPrices(): void
    {
        $adverts = $this->GetAll('overall_price_update IS NULL', 50, ['id ASC']);
        if (empty($adverts)){
            $adverts = $this->GetAll('status = 2', 50, ['overall_price_update DESC']);
        }

        $rates = [];

        if (!empty($adverts)) {
            foreach ($adverts as $advert){
                $price = $advert->getFirstPrice();

                if (!key_exists($price['type'], $rates)){ //Нет нужного рейта, нужно получить
                    $rates[$price['type']] = $this->rates->GetActualRate($price['type']);
                }

                $overall_price = $price['value'] * $rates[$price['type']]->getRate();
                $date = date('Y-m-d H:i:s');

                $overall_price = $this->mysqli->escape_string($overall_price);
                $date = $this->mysqli->escape_string($date);

                $this->Update($advert->getId(), ['overall_price' => $overall_price, 'overall_price_update' => $date]);

            }
        }
    }

    public function GetRating(int $advert_id): float
    {
        $advert_id = $this->mysqli->escape_string($advert_id);
        $this->mysqli->setTable('rating');
        $result = $this->mysqli->select(['AVG(mark) as rating'], "advert_id = '$advert_id'");
        $this->mysqli->setTable('adverts');
        
        return (!empty($result['rating'])) ? (round($result['rating'] / 5) * 5) : 0;
    }

    public function GetUserPurchases(int $user_id, int $type): array
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $type = $this->mysqli->escape_string($type);
        return $this->GetAll("buyer = '$user_id' AND delivered = '$type'");
    }

    public function GetUserSells(int $user_id, string $type, bool $payed = true): array
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $type = $this->mysqli->escape_string($type);
        if ($payed){
            $payed = ' AND buy_date != \'0000-00-00 00:00:00\'';
        } else{
            $payed = ' AND buy_date = \'0000-00-00 00:00:00\'';
        }
        return $this->GetAll("author = '$user_id' AND delivered IN ($type) AND buyer IS NOT NULL $payed");
    }

    public function GetUserAdverts(int $user_id, int $type, int $limit = 16): array
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $type = $this->mysqli->escape_string($type);
        return $this->GetAll("author = '$user_id' AND status = '$type'", $limit);
    }

    public function GetOneAdvertById(int $advert_id): array
    {
        $advert_id = $this->mysqli->escape_string($advert_id);
        
        return $this->GetAll("id = '$advert_id'", 1);
    }    

    public function CreateDeal(int $advert_id, int $user_id, string $buyer_wallet, string $buyer_type, int $chatId, string $admin_wallet, string $seller_wallet): int
    {
        $advert = $this->Get($advert_id);

        if ($advert->getId() > 0) {

            $prices = $advert->getPrices();

            $params = [
                'advert_id' => $advert->getId(),
                'seller_id' => $advert->getAuthor()->getId(),
                'buyer_id' => $user_id,
                'buyer_wallet' => $buyer_wallet,
                'seller_wallet' => $seller_wallet,
                'admin_wallet' => $admin_wallet,
                'buyer_type' => $buyer_type,
                'price' => $prices[mb_strtoupper($buyer_type)],
                'status' => 0,
                'secure_deal' => (!empty($advert->getSecureDeal())) ? 1 : 0,
                'pay_date' => date('Y-m-d H:i:s'),
                'chat' => $chatId
            ];

            $this->mysqli->setTable('deals');
            $result = $this->mysqli->insert($params);
            $newDealId = $this->mysqli->insert_id;
            $this->mysqli->setTable('adverts');

            if ($result){

                $seller_id = $advert->getAuthor()->getId();
                $buyer_id = $params['buyer_id'];

                $this->notifications->CreateNotification($buyer_id, 'purchases');
                $this->notifications->CreateNotification($seller_id, 'sells');

                return $newDealId;
            } else{
                return 0;
            }
        } else{
            return 0;
        }
    }

    public function GetDeals(string $where, int $limit = 0): array
    {

        $this->mysqli->setTable('deals');
        $result = $this->mysqli->select($this->deal_params, $where, $limit, 'id DESC');
        $this->mysqli->setTable('adverts');

        $return = [];

        if (!empty($result)) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToDeal($result);
            } else{
                foreach ($result as $array) {
                    $return[] = $this->ConvertArrayToDeal($array);
                }
            }
        }

        return $return;
    }

    public function GetAllSecureDeals(): array
    {

        $this->mysqli->setTable('deals');
        $result = $this->mysqli->select($this->deal_params, "secure_deal = 1", 0, 'id DESC');
        $this->mysqli->setTable('adverts');

        $return = [];

        if (!empty($result)) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToDeal($result);
            } else{
                foreach ($result as $array) {
                    $return[] = $this->ConvertArrayToDeal($array);
                }
            }
        }

        return $return;
    }    

    public function GetDeal(int $id): Deal
    {
        $id = $this->mysqli->escape_string($id);
        if ($id > 0)
            {
                $this->mysqli->setTable('deals');
                $result = $this->mysqli->select($this->deal_params, "id = '$id'", 1);
                $this->mysqli->setTable('adverts');

                return $this->ConvertArrayToDeal($result);
            }
    }

    public function UpdateDeal(int $id, array $params): bool
    {
        $id = $this->mysqli->escape_string($id);

        $this->mysqli->setTable('deals');
        $result = $this->mysqli->update($params, "id = '$id'", 1);
        $this->mysqli->setTable('adverts');

        return $result;
    }

    public function UpdatePayed(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-open');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-open');

        if ($type) {

            return $this->UpdateDeal($deal->getId(), ['status' => 1]);
        } else{
            return $this->OpenIncident($deal->getId(), 1);
        }
    }

    public function UpdateSecureDealPayed(array $params): int
    {
        $id = $params['id'];

        $deal = $this->GetDeal($id);

        $admin_id = $this->mysqli->escape_string($params['admin_id']);
        $pay_conf_date = date('Y-m-d H:i:s');
        $summ_to_seller = $this->mysqli->escape_string($params['summ_to_seller']);
        $royalty = $this->mysqli->escape_string($params['royalty']);
        $status = $params['status'];

        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-open');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-open');
      
        $result = $this->mysqli->query("UPDATE `deals` SET admin_id = '".$admin_id."', pay_confirmation_date = '".$pay_conf_date."', summ_to_seller = '".$summ_to_seller."', royalty = '".$royalty."', status = '".$status."' WHERE id = $id");                 

        if ($result) 
            { 
               return 2;
            }     
        else
            {
                return 1;
            }  
    }    

    public function UpdateNoPayed(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');

        if ($type) 
        {
            $this->OpenIncident($deal->getId(), 3);

            return $this->UpdateDeal($deal->getId(), ['status' => 6]);
        }
    } 

    public function UpdateSecureDealNoPayed(array $params): int
    {
        $id = $params['id'];

        $deal = $this->GetDeal($id);

        $admin_id = $this->mysqli->escape_string($params['admin_id']);

        $status = $params['status'];

        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
      
        $result = $this->mysqli->query("UPDATE `deals` SET admin_id = '".$admin_id."', status = '".$status."' WHERE id = $id");                 
        
        $this->OpenIncident($deal->getId(), 3);

        if ($result) 
            { 
               return 2;
            }     
        else
            {
                return 1;
            }  
    }       

    public function UpdateDelivered(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-open');
              
        if ($type) {
            return $this->UpdateDeal($deal->getId(), ['status' => 2, 'send_product_date' => date('Y-m-d H:i:s')]);
        } else{
            return $this->OpenIncident($deal->getId(), 1);
        }
    }
    
    public function UpdateNoDelivered(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');               
        if ($type) 
            {
                $this->OpenIncident($deal->getId(), 3);

                return $this->UpdateDeal($deal->getId(), ['status' => 7]);
            }
    }    

    public function UpdateReceived(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');                      
        if ($type) {
            return $this->UpdateDeal($deal->getId(), ['status' => 4, 'resive_confirmation_date' => date('Y-m-d H:i:s')]);
                   
        } else{
            return $this->OpenIncident($deal->getId(), 3);
        }
    }

    public function UpdateSendPayToSellerDate(int $deal_id): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');                      
        return $this->UpdateDeal($deal->getId(), ['send_pay_to_seller_date' => date('Y-m-d H:i:s')]);
                   
    }

    public function UpdateNoReceived(int $deal_id, bool $type): bool
    {
        $deal = $this->GetDeal($deal_id);
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');                     
        if ($type) 
            {
                $this->OpenIncident($deal->getId(), 3);
                return $this->UpdateDeal($deal->getId(), ['status' => 8]);
            }
    }

    public function SecureDealArbitrationDelete(array $params): int
    {
        $id = $params['id'];

        $deal = $this->GetDeal($id);

        $incident_opener = 0;
        $incident = 0;

        $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close');
        $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
      
        $result = $this->mysqli->query("UPDATE `deals` SET incident_opener = '".$incident_opener."', incident = '".$incident."' WHERE id = $id");                 

        if ($result) 
            { 
               return 2;
            }     
        else
            {
                return 1;
            }  
    }               

    public function CloseDeal(int $deal_id, bool $like, string $comment, int $rating): bool
    {
        $deal = $this->GetDeal($deal_id);

        if ($deal->GetStatus() == 4 || $deal->GetStatus() == 6 || $deal->GetStatus() == 7 || $deal->GetStatus() == 8) 
        {
            //echo 'test';

            if ($this->SendLike($deal, $like, $comment, $_COOKIE['id'])){
                if ($this->RateAdvert($deal, $rating, $_COOKIE['id'])) {

                    $this->notifications->CreateNotification($deal->getSeller()->getId(), 'sells-close');
                    $this->notifications->CreateNotification($deal->getBuyer()->getId(), 'purchases-close'); 
                    
                    return true;
                } else{
                    return false;
                }
            } else{
                return false;
            }
        } 
        else
        {
            return false;
        }
    }   

    private function SendLike(Deal $deal, bool $type, string $comment, int $userFromId): bool
    {
        $userToId = ($deal->getBuyer()->getId() == $userFromId) ? $deal->getSeller()->getId() : $deal->getBuyer()->getId();

        $this->mysqli->setTable('likes');
        $params = [
            'deal_id' => $deal->getId(),
            'user_from' => $userFromId,
            'user_to' => $userToId,
            'type' => ($type) ? 1 : 0,
            'comment' => $comment
        ];
        $result = $this->mysqli->insert($params);

        $this->mysqli->setTable('adverts');
        return true;
    }

    public function CreateCauseUserBan(int $deal, int $advert, int $idfrom, int $idto, string $report, string $date): bool
    {
        $idfrom = $this->mysqli->escape_string($idfrom);
        $idto = $this->mysqli->escape_string($idto);
        $report = $this->mysqli->escape_string($report);
        $date = $this->mysqli->escape_string($date);
        $advert = $this->mysqli->escape_string($advert);
        $deal = $this->mysqli->escape_string($deal);

        $this->mysqli->setTable('banneds');
        $params = [
            'user_from' => $idfrom,
            'user_to' => $idto,
            'cause' => $report,
            'cause_date' => $date,
            'advert' => $advert,
            'deal' => $deal
        ];
        $result = $this->mysqli->insert($params);

        $this->mysqli->setTable('adverts');
        
        if ($result)
            {
                return true;
            }
        else
            {
                return false;
            }
    }    

    public function OpenIncident(int $deal_id, int $opener = 0): bool
    {
        return $this->UpdateDeal($deal_id, ['incident' => 1, 'incident_opener' => $opener]);
    }

    public function isUserBuyer(int $user_id, int $deal_id): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $deal_id = $this->mysqli->escape_string($deal_id);

        $this->mysqli->setTable('deals');
        if ($this->mysqli->select(['id'], "id = '$deal_id' AND buyer_id = '$user_id'", 1) AND $this->mysqli->num_rows > 0){
            $result = true;
        } else{
            $result = false;
        }
        $this->mysqli->setTable('adverts');
        return $result;
    }

    public function isUserSeller(int $user_id, int $deal_id): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $deal_id = $this->mysqli->escape_string($deal_id);

        $this->mysqli->setTable('deals');
        if ($this->mysqli->select(['id'], "id = '$deal_id' AND seller_id = '$user_id'", 1) AND $this->mysqli->num_rows > 0){
            $result = true;
        } else{
            $result = false;
        }
        $this->mysqli->setTable('adverts');
        return $result;
    }

    public function isUserAuthor(int $user_id, int $advert_id): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $advert_id = $this->mysqli->escape_string($advert_id);

        if ($this->mysqli->select(['id'], "id = '$advert_id' AND author = '$user_id'", 1) AND $this->mysqli->num_rows > 0){
            return true;
        } else{
            return false;
        }
    }

    public function ToggleItemFromFavorites(int $user_id, int $advert_id)
    {
        if ($this->users->CheckUserId($user_id)){
            if ($this->CheckAdvertId($advert_id)){

                $user = $this->users->Get($user_id);
                $favorites = $user->getFavorites();

                if (is_array($favorites) AND !in_array($advert_id, $favorites)){

                    $favorites[] = $advert_id;
                    $status = 1;

                } else{

                    if (is_array($favorites)) {

                        foreach ($favorites as $i => $favorite){
                            if ($favorite == $advert_id){
                                unset($favorites[$i]);
                                break;
                            }
                        }
                        $status = 0;

                    } else{
                        $favorites = [$advert_id];
                        $status = 1;
                    }

                }

                $favorites = array_unique($favorites);
                $count = count($favorites);

                $this->mysqli->setTable('users');
                $result = $this->mysqli->update(['favorites' => json_encode($favorites)], "id = '$user_id'", 1);
                $this->mysqli->setTable('adverts');

                if ($result){
                    return [
                        'status' => $status,
                        'count' => $count
                    ];
                } else{
                    return 'Ошибка работы с базой данных';
                }

            } else{
                return 'Такого объявления не существует';
            }
        } else{
            return 'Такого пользователя не существует';
        }
    }

    public function CheckAdvertId(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id'], "id = '$id'", 1);
        if (!empty($result)){
            return true;
        } else{
            return false;
        }
    }

    public function RateAdvert(Deal $deal, int $rating, int $userFromId): bool
    {
        $this->mysqli->setTable('rating');

        $params = [
            'advert_id' => $deal->getAdvert()->getId(),
            'from_id' => $userFromId,
            'deal_id' => $deal->getId(),
            'mark' => ($rating > 0 AND $rating <= 5) ? $rating : 5
        ];

        $result = $this->mysqli->insert($params);
        $this->mysqli->setTable('adverts');

        return true;
    }

    public function GetDealFeedback(int $deal_id, int $userId)
    {
        $deal_id = $this->mysqli->escape_string($deal_id);
        $userId = $this->mysqli->escape_string($userId);

        $this->mysqli->setTable('likes');
        $like = $this->mysqli->select(['type', 'comment'], "deal_id = '$deal_id' AND user_to = '$userId'", 1);

        if (empty($like)) return [];

        $this->mysqli->setTable('rating');
        $rating = $this->mysqli->select(['mark'], "deal_id = '$deal_id' AND from_id != '$userId'", 1);
        $this->mysqli->setTable('adverts');

        return [
            'rating' => $rating['mark'],
            'like' => $like['type'],
            'text' => $like['comment']
        ];
    }

    private function ConvertArrayToAdvert(array $array): Advert
    {
        $advert = new Advert();
        $advert->setId($array['id']);
        $advert->setSection($this->sections->GetSection($array['section']));
        $advert->setCategory($this->sections->GetCategory($array['category']));
        $advert->setSubcategory($this->sections->GetSubcategory($array['subcategory']));
        $advert->setName($array['name']);
        $advert->setConditionType($array['condition_type']);
        $advert->setDescription($array['description']);
        $advert->setLocationName($array['location_name']);

            $this->mysqli->setTable('locations_cities');
            $city_id = $array['city'];
            $result = $this->mysqli->select(['id', 'name', 'country', 'author'], "id = '$city_id'", 1);
            
        $advert->setCity((isset($result['name']) && !empty($result['name'])) ? $result['name'] : '');        
                
        
        $this->mysqli->setTable('adverts');

        $advert->setLocation((!empty($array['location']) && $array['location'] > 0 && $array['location'] != 220) ? $this->locations->GetLocation($array['location']) : new Location());
        $advert->setPhotos(json_decode($array['photos'], true));
        $advert->setPrices(json_decode($array['prices'], true));
        $advert->setAuthor($this->users->Get($array['author']));
        $advert->setDate($array['date']);
        $advert->setStatus($array['status']);
        $advert->setSecureDeal(($array['secure_deal'] == 1) ? true : false);
        $advert->setViews($array['views']);
        $advert->setRating($this->GetRating($advert->getId()));

        return $advert;
    }

    private function ConvertArrayToDeal(array $array): Deal
    {
        $deal = new Deal();
        $deal->setId($array['id']);
        $deal->setAdvert($this->Get($array['advert_id']));
        $deal->setSeller($this->users->Get($array['seller_id']));
        $deal->setBuyer($this->users->Get($array['buyer_id']));

        $deal->setAdmin(($array['admin_id'] > 0) ? $array['admin_id'] : '');

        $deal->setBuyerWallet($array['buyer_wallet']);

        $deal->setSellerWallet(($array['seller_wallet'] != null) ? $array['seller_wallet'] : '');
        $deal->setAdminWallet(($array['admin_wallet'] != null) ? $array['admin_wallet'] : '');

        $deal->setBuyerType($array['buyer_type']);
        $deal->setStatus($array['status']);
        $deal->setSecureDeal($array['secure_deal']);
        $deal->setPrice($array['price']);

        $deal->setSummToSeller(($array['summ_to_seller'] != null) ? $array['summ_to_seller'] : 0.0);
          
        $deal->setRoyalty(($array['royalty'] != null) ? $array['royalty'] : 0.0);      

        $old_date = date($array['date']);
        $new_date = date('d.m.Y H:i', strtotime($old_date));
        $deal->setDate($new_date);

        $deal->setIncidentOpener($array['incident_opener']);
        $deal->setIncident($array['incident']);

        $old_pay_date = date($array['pay_date']);
        $new_pay_date = date('d.m.Y H:i', strtotime($old_pay_date));
        $deal->setPayDate($new_pay_date);

        if ($array['pay_confirmation_date'] != null)
            {
                $old_pay_confirmation_date = date($array['pay_confirmation_date']);
                $new_pay_confirmation_date = date('d.m.Y H:i', strtotime($old_pay_confirmation_date));
                $deal->setPayConfirmationDate($new_pay_confirmation_date);
            }
        else
            {
                $deal->setPayConfirmationDate('');
            }

        if ($array['send_product_date'] != null)
            {
                $old_send_product_date = date($array['send_product_date']);
                $new_send_product_date = date('d.m.Y H:i', strtotime($old_send_product_date));
                $deal->setSendProductDate($new_send_product_date);
            }
        else
            {
                $deal->setSendProductDate('');
            }

        if ($array['resive_confirmation_date'] != null)
            {
                $old_resive_confirmation_date = date($array['resive_confirmation_date']);
                $new_resive_confirmation_date = date('d.m.Y H:i', strtotime($old_resive_confirmation_date));
                $deal->setResiveConfirmationDate($new_resive_confirmation_date);
            }
        else
            {
                $deal->setResiveConfirmationDate('');
            }                        

        if ($array['send_pay_to_seller_date'] != null)
            {
                $old_send_pay_to_seller_date = date($array['send_pay_to_seller_date']);
                $new_send_pay_to_seller_date = date('d.m.Y H:i', strtotime($old_send_pay_to_seller_date));
                $deal->setSendPayToSellerDate($new_send_pay_to_seller_date);
            }
        else
            {
                $deal->setSendPayToSellerDate('');
            }        

        $deal->setChat($array['chat']);

        if ($array['status'] == 4 || $array['status'] == 6 || $array['status'] == 7 || $array['status'] == 8) {
            $id = $this->mysqli->escape_string($array['id']);

            $this->mysqli->setTable('rating');
            $result = $this->mysqli->select(['mark'], "deal_id = '$id'", 1);
            if (isset($result['mark'])) $deal->setRating($result['mark']);

            $this->mysqli->setTable('likes');
            $result = $this->mysqli->select(['type'], "deal_id = '$id'", 1);
            if (isset($result['type'])) $deal->setLike($result['type']);

            $this->mysqli->setTable('adverts');

            if (!empty($array['like'])) $deal->setLike($array['like']);
        }

        return $deal;
    }

}