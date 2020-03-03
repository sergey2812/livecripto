<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:18
 */

namespace LiveinCrypto;

use LiveinCrypto\Types\Banned;

class Banneds extends Config
{

    /**
     * @var Mysqli
     */
    public $mysqli; 

    /**
     * @var array
     */
    private $banned_params = [
        'id',
        'user_from',
        'user_to',
        'cause',
        'advert_id',
        'deal_id',
        'cause_date',
        'comment',
        'comment_date',
        'admin_id'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('banneds');
    }    

    public function GetAboutBannedUser(int $userto_id): array
    {
        $userto_id = $this->mysqli->escape_string($userto_id);
        
        $result = $this->mysqli->select($this->banned_params, "user_to = '$userto_id'", 0, 'cause_date DESC');

        $return = [];
      
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToBannedUser($result);

            } else{
                foreach ($result as $array) {
                    $return[] = $this->ConvertArrayToBannedUser($array);                  
                }
            }
        
        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }
    }

    public function GetAllBanned(string $where = '', ?string $limit = '0'): array
    {

        $result = $this->mysqli->select($this->banned_params, $where, $limit);

        $return = [];

        if ($this->mysqli->num_rows == 1) {
            $return[] = $this->ConvertArrayToBannedUser($result);
        } else{
            foreach ($result as $array) {
                $user = $this->ConvertArrayToBannedUser($array);
                $return[] = $user;
            }
        }

        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }

    }
    public function getCommentCount(int $userto_id): int
    {
        $userto_id = $this->mysqli->escape_string($userto_id);

        $result = $this->mysqli->query("SELECT COUNT(*) AS count FROM `banneds` WHERE user_to = '$userto_id'  AND `admin_id` != ''");
        
        if (!empty($result)) {
            return $result[0]['count'];
        } else{
            return 0;
        }
    }

    public function getCauseCount(int $userto_id): int
    {
        $userto_id = $this->mysqli->escape_string($userto_id);

        $result = $this->mysqli->query("SELECT COUNT(*) AS count FROM `banneds` WHERE user_to = '$userto_id'  AND `cause` != ''");
        if (!empty($result)) {
            return $result[0]['count'];
        } else{
            return 0;
        }
    }

    public function CreateClientCause(array $params): bool
    {
        $result = $this->mysqli->insert($params);

        if ($result) {
            return true;
        } else{
            return false;
        }
    } 

    public function GetLastCause(int $userto_id): array
    {
        $userto_id = $this->mysqli->escape_string($userto_id);

        $last_cause = $this->mysqli->query("SELECT * FROM banneds WHERE user_to = $userto_id ORDER BY user_to DESC LIMIT 1");

        $return = [];

        if ($this->mysqli->num_rows == 1) {
            $return[] = $this->ConvertArrayToBannedUser($last_cause);
        }

        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }
    }    

    public function AddAdminComment(int $userto_id, array $params): bool
    {
        $userto_id = $this->mysqli->escape_string($userto_id);

        $last_cause = $this->GetLastCause($userto_id);

        if (!empty($last_cause) && $last_cause['comment'] == '') 
            {
                // update
                $last_cause['comment'] = $params['comment'];
                $last_cause['comment_date'] = $params['comment_date'];
                $last_cause['admin_id'] = $params['admin_id'];
                if ($this->mysqli->update($last_cause)) 
                    {
                       return true; 
                    }
                else
                    {
                        return false;
                    }
            }
        else
            {
                // create
                if ($this->mysqli->insert($params)) 
                    {
                        return true;
                    } 
                else
                    {
                        return false;
                    }
            }
    }   

    private function ConvertArrayToBannedUser(array $result): Banned
    {
        $banned = new Banned();
        $banned->setId($result['id']);
        $banned->setBannedUserFrom($result['user_from']);
        $banned->setBannedUserTo($result['user_to']);
        $banned->setCause($result['cause']);

        $old_cause_date = date($result['cause_date']);
        $new_cause_date = date('d.m.Y H:i', strtotime($old_cause_date));
        $banned->setBannedCauseDate($new_cause_date);
        
        $banned->setBannedAdvert($result['advert']);
        $banned->setBannedDeal($result['deal']);
        $banned->setBannedComment($result['comment']);

        $old_comment_date = date($result['comment_date']);
        $new_comment_date = date('d.m.Y H:i', strtotime($old_comment_date));
        $banned->setBannedCommentDate($new_comment_date);

        $banned->setBannedAdmin($result['admin']);

        return $banned;
    }

}