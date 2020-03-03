<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:18
 */

namespace LiveinCrypto;

use LiveinCrypto\Types\User;
use LiveinCrypto\Types\UserBan;

class Users extends Config
{

    /**
     * @var Mysqli
     */
    public $mysqli;

    /**
     * @var array
     */
    private $user_params = [
        'id',
        'login',
        'email',
        'phone',
        'favorites',
        'avatar',
        'color',
        'wallets',
        'permissions',
        'password',
        'auth_key',
        'register_date',
        'banned',
        'banned_date',
        'banned_cause',
        'social_key'
    ];

    /**
     * @var array
     */
    private $banneds_params = [
        'id',
        'user_from',
        'user_to',
        'cause',
        'cause_date',
        'advert',
        'deal',
        'comment',
        'comment_date',
        'admin',
        'ban_unban'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('users');
    }

    public function Get(int $user_id, bool $full_info = true)
    {
        $result = $this->mysqli->select($this->user_params, "id = '$user_id'", 1);

        if (!empty($result)) 
            {
                return $this->ConvertArrayToUser($result, $full_info);
            } 
        else
            {
                return false;
            }

    }

    public function getByLogin(string $login)
    {
        $login = $this->mysqli->escape_string($login);

        $id = $this->mysqli->select(['id'], "login = '$login' OR email = '$login'", 1);
        if (!empty($id)) 
            {
                return $this->Get($id['id']);
            } 
        else
            {
                return false;
            }
    }    

    public function GetAll(string $where = '', ?string $limit = '0', bool $admin_info = false): array
    {

        $result = $this->mysqli->select($this->user_params, $where, $limit);

        $return = [];

        if ($this->mysqli->num_rows == 1) 
            {
                $return[] = $this->ConvertArrayToUser($result, true, $admin_info);
            } 
        else
            {
                foreach ($result as $array) 
                    {
                        $user = $this->ConvertArrayToUser($array, true, $admin_info);
                        $return[] = $user;
                    }
            }

        if (!empty($return)) 
            {
                return $return;
            } 
        else
            {
                return [];
            }

    }

    public function Register(array $params = [])
    {
        if (!empty($params['login']) AND !empty($params['email'])) 
            {
                $login = $this->mysqli->escape_string($params['login']);
                $email = $this->mysqli->escape_string($params['email']);

                $result = $this->mysqli->select(['id'], "login = '$login' OR email = '$email'", 1);

                if (empty($result)) 
                    {

                        $password = $params['password'];
                        $params['password'] = $this->PasswordHash($params['password']);

                        $params['avatar'] = 'avatars/12.png';
                        $params['color'] = 'fff';

                        $result = $this->mysqli->insert($params);

                        if ($result) 
                            {
                                return $this->Login($params['email'], $password);
                            } 
                        else
                            {
                                return _('Ошибка работы с базой данных. Пожалуйста, повторите попытку.');
                            }
                    } 
                else
                    {
                        return _('Такой логин, email или телефон уже зарегистрированы');
                    }
            } 
        else
            {
                return _('Пожалуйста, заполните все поля');
            }

    }

    public function Create(array $params): bool
    {
        $login = $params['login'];
        $result = $this->mysqli->select(['id'], "login = '$login'", 1);

        if (empty($result)) 
            {
                $params['password'] = $this->PasswordHash($params['password']);
                return $this->mysqli->insert($params);
            } 
        else
            {
                return false;
            }
    }

    public function AuthSocial(array $params){

        $social_key = $params['network'].'-'.$params['uid'];
        $user_id = $this->GetUserIdBySocial($social_key);

        $password = $this->GeneratePassword(8);

        if ($user_id == false) 
            {

                $user_params = [
                    'login' => $social_key,
                    'social_key' => $social_key,
                    'password' => $password
                ];
                if (!empty($params['email'])){
                    $user_params['email'] = $params['email'];
                }
                $this->Create($user_params);

                $this->Login($social_key, $password);
                header('Location: /');
                return;
            } 
        else
            {
                $this->Update($user_id, ['password' => $password]);
                header('Location: /');
                return;
            }

    }

    public function LoginBySocialKey(int $user_id, string $social_key): bool
    {
        $social_key = $this->mysqli->escape_string($social_key);
        $user_id = $this->mysqli->escape_string($user_id);

        $this->mysqli->select(['id'], "social_key = '$social_key' AND id = '$user_id'", 1);
        if ($this->mysqli->num_rows > 0) 
            {
                return true;
            } 
        else
            {
                return false;
            }
    }

    public function GetUserIdBySocial(string $social_key): ?int
    {
        $social_key = $this->mysqli->escape_string($social_key);
        $registered = $this->mysqli->select(['id'], "social_key = '$social_key'", 1);

        if ($this->mysqli->num_rows > 0)
            {
                return $registered['id'];
            } 
        else
            {
                return false;
            }
    }

    public function Login(string $login, string $password): bool
    {
        $login = $this->mysqli->escape_string($login);
        $password = $this->PasswordHash($password);

        $user_id = $this->mysqli->select(['id'], "(email = '$login' OR id = '$login') AND password = '$password'", 1);

        if (!empty($user_id)) 
            {
                $user_id = $user_id['id'];
                $auth_key = $this->AuthKeyUpdate($user_id);
                $user = $this->Get($user_id);
                $permissions = $user->getPermissions();

                if (!empty($auth_key)) 
                    {

                        $cookie_valid = time() + 604800;

                        if (setcookie('id', $user_id, $cookie_valid, '/') AND setcookie('auth_key', $auth_key, $cookie_valid, '/') AND setcookie('permissions', $permissions, $cookie_valid, '/') AND setcookie('session', 1, $cookie_valid, '/')) 
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
                        return false;
                    }
            } 
        else 
            {
                return false;
            }

    }

    public function Logout(): bool
    {
        if (setcookie('user_id', '', 0, '/') AND setcookie("auth_key", '', 0, '/')) 
            {
                return true;
            } 
        else
            {
                return false;
            }
    }

    public function Verify()
    {
        if (!empty($_COOKIE['id']) AND !empty($_COOKIE['auth_key'])) 
            {
                $user_id = $this->mysqli->escape_string($_COOKIE['id']);
                $auth_key = $this->mysqli->escape_string($_COOKIE['auth_key']);

                $user = $this->mysqli->select(['id'], "id = '$user_id' AND auth_key = '$auth_key'", 1);

                if (!empty($user)) 
                    {
                        return $this->Get($user['id']);
                    } 
                else
                    {
                        return false;
                    }
            } 
        else
            {
                return false;
            }
    }

    public function Update(int $user_id, array $params, bool $ignoreNewPassword = false): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);

        if (!empty($params['password'])) 
            {
                $new_password = $params['password'];
                $params['password'] = $this->PasswordHash($params['password']);
            }

        if (!empty($params['login']))
            {
                $login = $this->mysqli->escape_string($params['login']);
                $this->mysqli->select(['id'], "login = '$login'", 1);
                if ($this->mysqli->num_rows > 0) 
                    {
                        unset($params['login']);
                    }
            }
        if (!empty($params['email']))
            {
                $email = $this->mysqli->escape_string($params['email']);
                $this->mysqli->select(['id'], "email = '$email'", 1);
                if ($this->mysqli->num_rows > 0) 
                    {
                        unset($params['email']);
                    }
            }
        if (!empty($params['phone']))
            {
                $phone = $this->mysqli->escape_string($params['phone']);
                $this->mysqli->select(['id'], "phone = '$phone'", 1);
                if ($this->mysqli->num_rows > 0) 
                    {
                        unset($params['phone']);
                    }
            }

        if (!empty($params)) 
            {
                if ($this->mysqli->update($params, "id = '$user_id'", 1)) 
                    {
                        $user = $this->Get($user_id, false);
                        if (!$ignoreNewPassword AND !empty($new_password)) 
                            {
                                return $this->Login($user->getLogin(), $new_password);
                            } 
                        else
                            {
                                return true;
                            }
                    } 
                else
                    {
                        return false;
                    }
            } 
        else
            {
                return false;
            }
    }

    public function UpdateWallet(array $wallets, int $user_id): bool
    {

        foreach ($wallets as $type => $wallet)
            {
                if (empty($wallet))
                    {
                        unset($wallets[$type]);
                    } 
                else
                    {
                        continue;
                    }
            }

        $uWallets = [];
        foreach (array_reverse($wallets) as $type => $wallet) 
            {
                if (empty($uWallets[$type])) 
                    {
                        $uWallets[$type] = $wallet;
                    }
            }
        $wallets = $uWallets;

        $params = [
            'wallets' => json_encode($wallets)
        ];

        $user_id = $this->mysqli->escape_string($user_id);

        $result = $this->mysqli->update($params, "id = '$user_id'", 1);

        if ($result == true) 
            {
                return true;
            } 
        else
            {
                return false;
            }
    }

    public function CheckUserId(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id'], "id = '$id'", 1);
        if (!empty($result))
            {
                return true;
            } 
        else
            {
                return false;
            }
    }

    public function GetMarksUser(int $userId): array
    {
        $this->mysqli->setTable('likes');
        $likes = $this->mysqli->select(['COUNT(*) AS count', 'SUM(type) AS sum'], "user_to = '$userId'");
        $comments = $this->mysqli->select(['comment'], "user_to = '$userId'", 5, 'id DESC');
        if ($this->mysqli->num_rows == 1)
            {
                $comments = [$comments];
            }
        $this->mysqli->setTable('rating');
        $rating = $this->mysqli->select(['AVG(mark) as rating'], "advert_id IN (SELECT id FROM adverts WHERE author = '$userId') AND from_id != $userId");
        $this->mysqli->setTable('users');        

        $result = [
            'likes' => 0,
            'dislikes' => 0,
            'rating' => (!empty($rating['rating'])) ? $rating['rating'] : 0,
            'comments' => []
        ];

        if (!empty($likes)) 
            {
                if (!empty($likes['sum'])) 
                    {
                        $result['likes'] = $likes['sum'];
                    } 
                else
                    {
                        $result['likes'] = 0;
                        $likes['sum'] = 0;
                    }
                $result['dislikes'] = $likes['count'] - $likes['sum'];
            }
        if (!empty($comments)) 
            {
                $all_comments = [];
                foreach ($comments as $comment)
                    {
                        $all_comments[] = $comment['comment'];
                    }
                $result['comments'] = $all_comments;
            }

        return $result;

    }

    public function getAdvertsCount(int $userId, int $status = 0): int
    {
        $userId = $this->mysqli->escape_string($userId);
        if ($status <= 0) 
            {
                $status = 2;
            }

        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `adverts` WHERE author = '$userId' AND `status` = $status");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getSellsCount(int $userId, string $statuses = ''): int
    {
        $userId = $this->mysqli->escape_string($userId);
        if (empty($statuses)) 
            {
                $statuses = '0';
            }

        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `deals` WHERE seller_id = '$userId' AND `status` IN ($statuses)");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getBuyCount(int $userId, string $statuses = ''): int
    {
        $userId = $this->mysqli->escape_string($userId);
        if (empty($statuses)) 
            {
                $statuses = '0';
            }

        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `deals` WHERE buyer_id = '$userId' AND `status` IN ($statuses)");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getSells(int $userId): int
    {
        $userId = $this->mysqli->escape_string($userId);
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `deals` WHERE seller_id = '$userId'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getBuys(int $userId): int
    {
        $userId = $this->mysqli->escape_string($userId);
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `deals` WHERE buyer_id = '$userId'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getMessagesCount(int $userId, $type = ''): int
    {
        $userId = $this->mysqli->escape_string($userId);
        if (empty($type)) {
            $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `messages` WHERE `chat_id` IN (SELECT `id` FROM `chats` WHERE `from_id` = '$userId' OR `to_id` = '$userId') AND `read_status` = 0 AND `from_id` != '$userId'");
        } else{
            if ($type == 'buy') {
                $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `messages` WHERE `chat_id` IN (SELECT `id` FROM `chats` WHERE `from_id` = '$userId') AND `read_status` = 0 AND `from_id` != '$userId'");
            } else{
                $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `messages` WHERE `chat_id` IN (SELECT `id` FROM `chats` WHERE `to_id` = '$userId') AND `read_status` = 0 AND `from_id` != '$userId'");
            }
        }
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getAdminMessagesCount(int $userId, $type = ''): int
    {
        $userId = $this->mysqli->escape_string($userId);
       
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `messages_admin` WHERE `chat_id` IN (SELECT `id` FROM `chats_with_admin` WHERE `from_id` = '$userId' OR `to_id` = '$userId') AND `read_status` = 2 AND `from_id` != '$userId'");
        
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getFavoritesRealCount(array $favorites): int
    {
        $result = $this->mysqli->query("SELECT COUNT(*) as count FROM `adverts` WHERE `status` = 2 AND `id` IN (".implode(',', $favorites).")");
        if (!empty($result)) 
            {
                return $result[0]['count'];
            } 
        else
            {
                return 0;
            }
    }

    public function getLogin(int $userId): string
    {
        $userId = $this->mysqli->escape_string($userId);
        $login = $this->mysqli->query("SELECT login FROM users WHERE id = '$userId' LIMIT 1");

        if (!empty($login)) 
            {
                return $login[0]['login'];
            } 
        else
            {
                return '';
            }
    }

    public function getLastComments(int $userId, int $limit = 10): array
    {
        $userId = $this->mysqli->escape_string($userId);

        $likes = $this->mysqli->query("SELECT likes.user_from as 'from', likes.type, likes.comment, likes.date, likes.deal_id, rating.mark as 'rating', users.avatar, users.color FROM likes
INNER JOIN rating ON likes.deal_id = rating.deal_id AND rating.from_id != $userId
INNER JOIN users ON users.id = likes.user_from
WHERE user_to = $userId ORDER BY date DESC");

        if (!empty($likes)) 
            {
                foreach ($likes as $key => $like) 
                    {
                        $likes[$key]['date'] = date('d.m.Y', strtotime($like['date']));
                    }
            }
        return $likes;
    }

    public function GetIdLastRowUserBanned(int $user_to): ?int
    {
        $user_to = $this->mysqli->escape_string($user_to);
        $last_row_id = $this->mysqli->query("SELECT id FROM banneds WHERE user_to = $user_to AND comment = '' ORDER BY id DESC LIMIT 1");

        if ($this->mysqli->num_rows == 1)
            {
                return $last_row_id[0]['id'];
            } 
        else
            {
                return 0;
            }
    }

    public function UpdateLastRowUserBanned(int $id_lastrow, string $comment, string $comment_date, int $id_admin): bool
    {
        $id_lastrow = $this->mysqli->escape_string($id_lastrow);
        $comment = $this->mysqli->escape_string($comment);
        $comment_date = $this->mysqli->escape_string($comment_date);
        $id_admin = $this->mysqli->escape_string($id_admin);
        $this->mysqli->setTable('banneds');

        $params = [
            'comment' => $comment,
            'comment_date' => $comment_date,
            'admin' => $id_admin,
            'ban_unban' => 1
        ];

        $result = $this->mysqli->update($params, "id = '$id_lastrow'", 1);

        $this->mysqli->setTable('users');

        if ($result)
            {
                return true;
            }
        else
            {
                return false;
            }
    }

    public function CreateAdminCommentForUserBanned(int $idto, string $comment, string $comment_date, int $id_admin, int $ban_unban): bool
    {
        $idto = $this->mysqli->escape_string($idto);
        $comment = $this->mysqli->escape_string($comment);
        $comment_date = $this->mysqli->escape_string($comment_date);
        $id_admin = $this->mysqli->escape_string($id_admin);
        $ban_unban = $this->mysqli->escape_string($ban_unban);
        $this->mysqli->setTable('banneds');

        $params = [
            'user_to' => $idto,
            'comment' => $comment,
            'comment_date' => $comment_date,
            'admin' => $id_admin,
            'ban_unban' => $ban_unban
        ];

        $result = $this->mysqli->insert($params);

        $this->mysqli->setTable('users');

        if ($result)
            {
                return true;
            }
        else
            {
                return false;
            }
    }

    public function GetAllRowForUserBanned(int $user_to): array
    {
        $user_to = $this->mysqli->escape_string($user_to);
        $this->mysqli->setTable('banneds');
        $result = $this->mysqli->select($this->banneds_params, "user_to = '$user_to'", 0, 'id DESC');       

        $return = [];

        if ($this->mysqli->num_rows > 0) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {
                        $return[] = $this->ConvertArrayToUserBan($result);
                    } 
                else
                    {
                        foreach ($result as $rowresult) 
                            {
                                $return[] = $this->ConvertArrayToUserBan($rowresult);
                            }
                    }
            }
        $this->mysqli->setTable('users');
        return $return;
    }        

    private function ConvertArrayToUserBan(array $array): UserBan
        {
            $UserBan = new UserBan();
            $UserBan->setId($array['id']);
            $UserBan->setUserBanFromId($array['user_from']);
            $UserBan->setUserBanToId($array['user_to']);
            $UserBan->setUserBanCause($array['cause']);

            $old_cause_date = date($array['cause_date']);
            $new_cause_date = date('d.m.Y H:i', strtotime($old_cause_date));
            $UserBan->setUserBanCauseDate($new_cause_date);

            $UserBan->setUserBanAdvertId($array['advert']);
            $UserBan->setUserBanDealId($array['deal']);
            $UserBan->setUserBanComment($array['comment']);

            $old_comment_date = date($array['comment_date']);
            $new_comment_date = date('d.m.Y H:i', strtotime($old_comment_date));        
            $UserBan->setUserBanCommentDate($new_comment_date);
            $UserBan->setUserBanAdminId($array['admin']);
            $UserBan->setUserBanStatus($array['ban_unban']);

    //        $UserBan->setCities($this->GetCountryCities($array['id']));
            return $UserBan;
        }    

    private function ConvertArrayToUser(array $result, bool $full_info = true, bool $admin_info = false): User
    {
        $user = new User();
        $user->setId($result['id']);
        $user->setLogin($result['login']);
        $user->setEmail($result['email']);
        $user->setPhone($result['phone']);

        $fav = json_decode($result['favorites'], true);
        if ($fav === null)
            {
                $fav = [];
            }
        $user->setFavorites($fav);
        $user->setAvatar(!empty($result['avatar']) ? $result['avatar'] : 'avatars/12.png');
        $user->setColor($result['color']);
        $user->setWallets(json_decode($result['wallets'], true));
        $user->setPermissions($result['permissions']);
        $user->setPassword($result['password']);
        $user->setAuthKey($result['auth_key']);

        $old_register_date = date($result['register_date']);
        $new_register_date = date('d.m.Y H:i', strtotime($old_register_date));
        $user->setRegisterDate($new_register_date);

        $user->setSocialKey($result['social_key']);
        $user->setBanned($result['banned']);

        $old_banned_date = date($result['banned_date']);
        $new_banned_date = date('d.m.Y H:i', strtotime($old_banned_date));
        $user->setBannedDate($new_banned_date);

        $user->setBannedCause($result['banned_cause']);
        $user_likes = $this->GetMarksUser($user->getId());
        $user->setRating($user_likes['rating']);
        $user->setLikes($user_likes['likes']);
        $user->setDislikes($user_likes['dislikes']);
        $user->setLastComments($user_likes['comments']);

        if ($admin_info)
            {
                $this->mysqli->setTable('adverts');
                $stats ['adverts_active'] = $this->mysqli->select(['COUNT(*) AS count'], 'author = \''.$user->getId().'\' AND status = \'2\'')['count'];

                $this->mysqli->setTable('top_4_clients_payed_history');
                $stats ['adverts_in_top'] = $this->mysqli->select(['COUNT(*) AS count'], 'user_id = \''.$user->getId().'\' AND status = \'2\'')['count'];           

                $this->mysqli->setTable('banneds');
                $stats ['blocks'] = $this->mysqli->select(['COUNT(*) AS count'], 'user_to = \''.$user->getId().'\' AND ban_unban = "1"')['count'];

                $this->mysqli->setTable('deals');
                $stats['buys'] = $this->mysqli->select(['COUNT(*) AS count'], 'buyer_id = \''.$user->getId().'\'')['count'];

                $user->setStats($stats);

                $this->mysqli->setTable('users');
            }

        return $user;
    }

    private function GeneratePassword($length = 8) 
        {
            $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            $count = mb_strlen($chars);

            for ($i = 0, $result = ''; $i < $length; $i++) 
                {
                    $index = rand(0, $count - 1);
                    $result .= mb_substr($chars, $index, 1);
                }

            return $result;
        }

    private function PasswordHash(string $string): string
        {
            return md5($string.crypt('salt', 'yeah!'));
        }

    private function AuthKeyUpdate(int $user_id): string
        {
            $auth_key = md5(date("Y-m-d H:i:s").crypt($user_id, "auth_key"));

            if ($this->mysqli->update(['auth_key' => $auth_key], "id = '$user_id'", 1)) 
                {
                    return $auth_key;
                } 
            else
                {
                    return false;
                }
        }

}