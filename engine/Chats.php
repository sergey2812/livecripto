<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 16.08.2018
 * Time: 13:07
 */

namespace LiveinCrypto;

use function GuzzleHttp\Psr7\uri_for;
use LiveinCrypto\Types\Chat;
use LiveinCrypto\Types\Message;
use LiveinCrypto\Types\ChatAdmin;
use LiveinCrypto\Types\MessageAdmin;



class Chats extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var Users
     */
    private $users;
    /**
     * @var Adverts
     */
    private $adverts;
    private $notifications;

    private $chat_params = [
        'id',
        'from_id',
        'to_id',
        'subject',
        'date',
        'advert',
        'accept',
        'deal'
    ];

    private $chat_admin_params = [
        'id',
        'from_id',
        'to_id',
        'date',
        'accept',
        'status'
    ];

    public function __construct()
    {
        parent::__construct();

        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('chats');

        $this->users = new Users();
        $this->adverts = new Adverts();
    
    }

    public function getCountByType(string $type, int $id): int
    {
        if ($type == 'buy') {
            $res = $this->mysqli->select(['COUNT(*) as count'], "`from_id` = '$id'");
        } else{
            $res = $this->mysqli->select(['COUNT(*) as count'], "`to_id` = '$id'");
        }

        if (!empty($res) AND !empty($res['count'])) {
            return $res['count'];
        }

        return 0;
    }
   

    public function CreateChat(int $from, int $to, string $subject, string $message, int $advert_id = 0): bool
    {
        if ($this->users->CheckUserId($from)) {
            if ($this->users->CheckUserId($to)){

                $params = [
                    'from_id' => $from,
                    'to_id' => $to,
                    'subject' => $subject,
                    'advert' => $advert_id
                ];

                $result = $this->mysqli->insert($params);

                if ($result) {
global  $chat_last_id;
$chat_last_id = $this->mysqli->row_id();


                    return $this->SendMessage($from, $this->mysqli->row_id(), $message);
                } else{
                    return 'Ошибка создания чата';
                }
            } else{
                return 'Получателя не существует';
            }
        } else{
            return 'Отправителя не существует';
        }
    }   

    public function CreateChatWithAdmin(int $from, int $to, string $message): bool
    {
        if ($this->users->CheckUserId($from)) 
            {
                $params = [
                    'from_id' => $from,
                    'to_id' => $to,
                    'status' => 1 
                    // 1 - чат открыт
                    // 2 - чат заткрыт
                ];
                $this->mysqli->setTable('chats_with_admin');
                $result = $this->mysqli->insert($params);
                $this->mysqli->setTable('chats');

                if ($result) 
                    {
        global  $chat_admin_last_id;
        $chat_admin_last_id = $this->mysqli->row_id();

                        return $this->SendAdminMessage($from, $this->mysqli->row_id(), $message);
                    } 
                else
                    {
                        return 'Ошибка создания чата';
                    }
            } 
        else
            {
                return 'Отправителя не существует';
            }
    }

    public function AcceptChatWithAdmin(int $admin_id, int $chat_id): void
    {
        $admin_id = $this->mysqli->escape_string($admin_id);
        $chat_id = $this->mysqli->escape_string($chat_id);

        $this->mysqli->setTable('chats_with_admin');
        $this->mysqli->update(['to_id' => $admin_id], "id = '$chat_id'");
        $this->mysqli->setTable('chats');
    } 

    public function CloseAdminChat(int $chat_id): void
    {
        $chat_id = $this->mysqli->escape_string($chat_id);

        $this->mysqli->setTable('chats_with_admin');
        $this->mysqli->update(['status' => 2], "id = '$chat_id'");
        $this->mysqli->setTable('chats');
    }

    public function SendMessage(int $from, int $chat, string $message): bool
    {
        $message_text = $this->mysqli->escape_string($message);
        if ($this->CheckUserInChat($from, $chat)) {

            $params = [
                'from_id' => $from,
                'message' => $message_text,
                'chat_id' => $chat
            ];

            $this->mysqli->setTable('messages');
            $result = $this->mysqli->insert($params);
            $this->mysqli->setTable('chats');

            if ($result){
                return true;
            } else{
                return false;
            }
        } else{
            return 'У вас нет доступа к этому чату';
        }
    }

    public function CheckUserInChat(int $user_id, int $chat_id): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);

        $result = $this->mysqli->select(['id'], "(from_id = '$user_id' OR to_id = '$user_id') AND id = '$chat_id'", 1);
        if (!empty($result)) {
            return true;
        } else{
            return false;
        }
    }

    public function SendAdminMessage(int $from, int $chat, string $message): bool
    {
        $message_text = $this->mysqli->escape_string($message);

        if ($this->CheckUserInAdminChat($from, $chat)) 
            {
                $params = [
                    'from_id' => $from,
                    'message' => $message_text,
                    'chat_id' => $chat,
                    'read_status' => 2
                ];

                $this->mysqli->setTable('messages_admin');
                $result = $this->mysqli->insert($params);
                $this->mysqli->setTable('chats');

                if ($result){
                    return true;
                } else{
                    return false;
                }
            } 
        else
            {

                return 'У вас нет доступа к этому чату';
            } 
    }

    public function CheckUserInAdminChat(int $user_id, int $chat_id): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);
        $this->mysqli->setTable('chats_with_admin');
        $result = $this->mysqli->select(['id'], "(from_id = '$user_id' OR to_id = '$user_id') AND id = '$chat_id'", 1);

        $this->mysqli->setTable('chats');
        if (!empty($result)) {
            return true;
        } else{
            return false;
        }
    }    

    public function Get(int $chat_id, int $user_id, int $lastMessageId = 0): Chat
    {
        if ($this->CheckUserInChat($user_id, $chat_id)) {

            $chat_id = $this->mysqli->escape_string($chat_id);
            $chat = $this->mysqli->select($this->chat_params, "id = '$chat_id'", 1);

            if (!empty($chat)) {
                return $this->ConvertArrayToChat($chat, $lastMessageId);
            } else{
                return new Chat();
            }
        } else{
            return new Chat();
        }
    }

    public function GetForAdmin(int $chat_id, int $user_id, int $lastMessageId = 0): ChatAdmin
    {
        if ($this->CheckUserInAdminChat($user_id, $chat_id)) {

            $chat_id = $this->mysqli->escape_string($chat_id);
            $this->mysqli->setTable('chats_with_admin');

            $chat = $this->mysqli->select($this->chat_admin_params, "id = '$chat_id'", 1);

            $this->mysqli->setTable('chats');
            if (!empty($chat)) {
                return $this->ConvertArrayToAdminChat($chat, $lastMessageId);
            } else{
                return new ChatAdmin();
            }
        } else{
            return new ChatAdmin();
        }
    }    

    public function GetChatByUserId(int $chat_id_from, int $chat_id_to, string $subject, int $advert = 0): int
    {
        $chat_id_from = $this->mysqli->escape_string($chat_id_from);
        $chat_id_to = $this->mysqli->escape_string($chat_id_to);
        $subject = $this->mysqli->escape_string($subject);
        $advert = $this->mysqli->escape_string($advert);

        $result = $this->mysqli->select(['id'], "from_id IN ('$chat_id_from', '$chat_id_to') AND to_id IN ('$chat_id_from', '$chat_id_to') AND subject = '$subject' AND advert = '$advert'", 1, 'id DESC');
        if ($this->mysqli->num_rows > 0){
            return $result['id'];
        } else{
            return 0;
        }
    }

    public function GetAdminChatByUserId(int $chat_id_from, int $chat_id_to): int
    {
        $chat_id_from = $this->mysqli->escape_string($chat_id_from);
        $chat_id_to = $this->mysqli->escape_string($chat_id_to);
        $this->mysqli->setTable('chats_with_admin');
        $result = $this->mysqli->select(['id'], "from_id IN ('$chat_id_from', '$chat_id_to') AND to_id IN ('$chat_id_from', '$chat_id_to')", 1, 'id DESC');

        $this->mysqli->setTable('chats');
        if ($this->mysqli->num_rows > 0){
            return $result['id'];
        } else{
            return 0;
        }
    }

    public function GetDealIdFromChat(int $chat_id_from, int $chat_id_to, string $subject, int $advert = 0): int
    {

        $chat_id_from = $this->mysqli->escape_string($chat_id_from);
        $chat_id_to = $this->mysqli->escape_string($chat_id_to);
        $subject = $this->mysqli->escape_string($subject);
        $advert = $this->mysqli->escape_string($advert);

        $result = $this->mysqli->select(['deal'], "from_id IN ('$chat_id_from', '$chat_id_to') AND to_id IN ('$chat_id_from', '$chat_id_to') AND subject = '$subject' AND advert = '$advert'", 1, 'id DESC');
        
        if ($this->mysqli->num_rows > 0)
            {
                
                if ($result['deal'] > 0)
                    {
                        return $result['deal'];
                    } 
                else
                    {
                        return 0;
                    }
            } 
        else
            {
                return (0-1);
            }
    }

    public function GetChatsByUser(int $user_id, string $type = 'sell'): array
    {
//        $user_id = $this->mysqli->escape_string($user_id);

        $whereString = "to_id = '$user_id'";
        if ($type == 'buy') $whereString = "from_id = '$user_id'";


        $chats = $this->mysqli->select($this->chat_params, "$whereString AND `id` IN (SELECT DISTINCT `chat_id` FROM `messages`)");

        if (!empty($chats)) {
            if ($this->mysqli->num_rows == 1) {
                return [$this->ConvertArrayToChat($chats)];
            } else{
                $result = [];

                foreach ($chats as $chat) {
                    $result[] = $this->ConvertArrayToChat($chat);
                }
                usort($result, [$this, 'sortChats']);

                return $result;
            }
        } else{
            return [];
        }
    }

    public function GetChatsAdminByUser(int $user_id): array
    {
        $user_id = $this->mysqli->escape_string($user_id);

        $this->mysqli->setTable('chats_with_admin');

        $chats = $this->mysqli->select($this->chat_admin_params, "(from_id = '$user_id' OR to_id = '$user_id') AND `id` IN (SELECT DISTINCT `chat_id` FROM `messages_admin`)");

        if (!empty($chats)) {
            if ($this->mysqli->num_rows == 1) {
                return [$this->ConvertArrayToAdminChat($chats)];
            } else{
                $result = [];

                foreach ($chats as $chat) {
                    $result[] = $this->ConvertArrayToAdminChat($chat);
                }
                usort($result, [$this, 'sortAdminChats']);
                $this->mysqli->setTable('chats');

                return $result;
            }
        } else{
            $this->mysqli->setTable('chats');
            return [];
        }
    }

    public function GetLastChatAdminByUserId(int $user_id): array
    {
        $user_id = $this->mysqli->escape_string($user_id);

        $this->mysqli->setTable('chats_with_admin');

        $chat = $this->mysqli->select($this->chat_admin_params, "from_id = '$user_id' OR to_id = '$user_id'", 1, 'id DESC');

        if (!empty($chat)) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {
                        return [$this->ConvertArrayToAdminChat($chat)];
                    } 
                else
                    {
                        $result = [];

                        $this->mysqli->setTable('chats');

                        return $result;
                    }
            } 
        else
            {
                $this->mysqli->setTable('chats');
                return [];
            }
    }

    private function sortChats(Chat $a, Chat $b): int
    {
        if (empty($a->getMessages())) return -1;
        if (empty($b->getMessages())) return 1;

        $timeA = strtotime($a->getMessages()[count($a->getMessages()) - 1]->getDate());
        $timeB = strtotime($b->getMessages()[count($b->getMessages()) - 1]->getDate());

        if ($timeA > $timeB) {
            return -1;
        } elseif ($timeA < $timeB) {
            return 1;
        } else{
            return 0;
        }
    }

    private function sortAdminChats(ChatAdmin $a, ChatAdmin $b): int
    {
        $this->mysqli->setTable('chats_with_admin');
        if (empty($a->getMessages())) return -1;
        if (empty($b->getMessages())) return 1;

        $timeA = strtotime($a->getMessages()[count($a->getMessages()) - 1]->getDate());
        $timeB = strtotime($b->getMessages()[count($b->getMessages()) - 1]->getDate());

        $this->mysqli->setTable('chats');

        if ($timeA > $timeB) {
            return -1;
        } elseif ($timeA < $timeB) {
            return 1;
        } else{
            return 0;
        }
    }

    public function GetChatHistory(int $user_id, int $chat_id, int $lastMessageId = 0): array
    {
        $result = [];

        $chat = $this->Get($chat_id, $user_id, $lastMessageId);
        if (!empty($chat)) {
            $messages = $chat->getMessages();
            if (!empty($messages)) {
                foreach ($messages as $message) {
                    $result[] = [
                        'id' => $message->getId(),
                        'text' => $message->getText(),
                        'from' => ($message->getFrom() == $user_id),
                        'date' => date('d.m.Y', strtotime($message->getDate())),
                        'time' => date('H:i', strtotime($message->getDate())),
                        'avatar' => ($chat->getFrom()->getId() == $message->getFrom()) ? $chat->getFrom()->getAvatar() : $chat->getTo()->getAvatar()
                    ];
                }
            }
        }

        return $result;
    }

    public function GetAdminChatHistory(int $user_id, int $chat_id, int $lastMessageId = 0): array
    {
        $result = [];
        $this->mysqli->setTable('chats_with_admin');

        $chat = $this->GetForAdmin($chat_id, $user_id, $lastMessageId);

        if (!empty($chat)) {
            $messages = $chat->getMessages();
            if (!empty($messages)) {
                foreach ($messages as $message) {
                    $result[] = [
                        'id' => $message->getId(),
                        'text' => $message->getText(),
                        'from' => ($message->getFrom() == $user_id),
                        'date' => date('d.m.Y', strtotime($message->getDate())),
                        'time' => date('H:i', strtotime($message->getDate())),
                        'avatar' => ($chat->getFrom()->getId() == $message->getFrom()) ? $chat->getFrom()->getAvatar() : $chat->getTo()->getAvatar()
                    ];
                }
            }
        }
        $this->mysqli->setTable('chats');
        return $result;
    }

    public function accept(int $user_id, int $chat_id, int $newValue = 1): void
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);

        $this->mysqli->update(['accept' => $newValue], "id = '$chat_id' AND to_id = '$user_id'", 1);
    }

    public function acceptAdmin(int $user_id, int $chat_id, int $newValue = 1): void
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);
        $this->mysqli->setTable('chats_with_admin');

        $this->mysqli->update(['accept' => $newValue], "id = '$chat_id' AND to_id = '$user_id'", 1);

        $this->mysqli->setTable('chats');
    }

    public function paid(int $user_id, int $chat_id, string $fromWallet, string $type, string $toWallet, string $sellerWallet): void
    {
        $chat = $this->Get($chat_id, $user_id);

            $dealId = $this->adverts->CreateDeal($chat->getAdvert()->getId(), $user_id, $fromWallet, $type, $chat_id, $toWallet, $sellerWallet);
        
        if ($dealId > 0) {
            $chat_id = $this->mysqli->escape_string($chat_id);
            $this->mysqli->update(['deal' => $dealId], "id = '$chat_id'", 1);
        }
    }

    public function ReadMessages(int $user_id, int $chat_id): void
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);

        $this->mysqli->setTable('messages');
        $this->mysqli->update(['read_status' => 1], "chat_id = '$chat_id' AND from_id != '$user_id'");
        $this->mysqli->setTable('chats');
    }

    public function ReadAdminMessages(int $user_id, int $chat_id): void
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $chat_id = $this->mysqli->escape_string($chat_id);

        $this->mysqli->setTable('messages_admin');
        $this->mysqli->update(['read_status' => 1], "chat_id = '$chat_id' AND from_id != '$user_id'");
        $this->mysqli->setTable('chats');
    }

    public function GetReadStatusAdminMessages(int $user_id): int
    {
        $user_id = $this->mysqli->escape_string($user_id);

        $this->mysqli->setTable('messages_admin');
        $row_last_message = $this->mysqli->select(['read_status'], "from_id = '$user_id'", 1, 'id DESC');

        $this->mysqli->setTable('chats');

        if (!empty($row_last_message)) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {
                        return $row_last_message['read_status'];
                    } 
                else
                    {
                        return 0; // 0 - нет сообщения, 1 - прочитано, 2 - непрочитано
                    }
            } 
        else
            {
                return 0;
            }
    }

    private function GetMessages(int $chat_id, int $lastMessageId): array
    {
        $chat_id = $this->mysqli->escape_string($chat_id);
        $lastMessageId = $this->mysqli->escape_string($lastMessageId);

        $array = [];

        $this->mysqli->setTable('messages');
        $messages = $this->mysqli->select(['id', 'from_id', 'message', 'date', 'chat_id', 'read_status'], "chat_id = '$chat_id' AND `id` > $lastMessageId");
        $this->mysqli->setTable('chats');

        if (!empty($messages)) {
            if ($this->mysqli->num_rows == 1){
                $array[] = $this->ConvertArrayToMessage($messages);
            } else{
                foreach ($messages as $message){
                    $array[] = $this->ConvertArrayToMessage($message);
                }
            }
        }
        return $array;

    }

    private function GetAdminMessages(int $chat_id, int $lastMessageId): array
    {
        $chat_id = $this->mysqli->escape_string($chat_id);
        $lastMessageId = $this->mysqli->escape_string($lastMessageId);

        $array = [];

        $this->mysqli->setTable('messages_admin');
        $messages = $this->mysqli->select(['id', 'from_id', 'message', 'date', 'chat_id', 'read_status'], "chat_id = '$chat_id' AND `id` > $lastMessageId");
        $this->mysqli->setTable('chats');

        if (!empty($messages)) {
            if ($this->mysqli->num_rows == 1){
                $array[] = $this->ConvertArrayToAdminMessage($messages);
            } else{
                foreach ($messages as $message){
                    $array[] = $this->ConvertArrayToAdminMessage($message);
                }
            }
        }
        return $array;

    }

    public function getBeautifulDate(string $date): string
    {
        $time = (new \DateTime())->setTimestamp(strtotime($date));
        $currentTime = (new \DateTime())->setTimestamp(time());

        $diff = $time->diff($currentTime);

        $type = false;
        $digit = null;

        if ($diff->y > 0) {
            $digit = $diff->y;
        } elseif($diff->m > 0) {
            $type = 'month';
            $digit = $diff->m;
        } elseif($diff->d > 0) {
            $type = 'day';
            $digit = $diff->d;
        } else {
            return $time->format('H:i');
        }

        $word = ['год', 'года', 'лет'];
        if ($type == 'month') {
            $word = ['месяц', 'месяца', 'месяцев'];
        } elseif ($type == 'day') {
            $word = ['день', 'дня', 'дней'];
        }

        $number = $digit % 100;
        if ($number >= 11 && $number <= 19) {
            $ending = $word[2];
        } else{
            $i = $number % 10;
            switch ($i)
            {
                case (1): $ending = $word[0]; break;
                case (2):
                case (3):
                case (4): $ending = $word[1]; break;
                default: $ending = $word[2];
            }
        }

        return "$digit $ending назад";
    }

    private function ConvertArrayToMessage(array $array): Message
    {
        $message = new Message();
        $message->setId($array['id']);
        $message->setFrom($array['from_id']);
        $message->setDate($array['date']);
        $message->setText($array['message']);
        $message->setRead($array['read_status']);
        $message->setChatId($array['chat_id']);

        return $message;
    }

    private function ConvertArrayToChat(array $array, int $lastMessageId = 0): Chat
    {
        $from = $this->users->Get($array['from_id']);
        $to = $this->users->Get($array['to_id']);

        $chat = new Chat();
        $chat->setId($array['id']);
        $chat->setSubject($array['subject']);
        $chat->setAccept(boolval($array['accept']));
    
            
        $chat->setDeal(($array['deal'] != null) ? $this->adverts->GetDeal($array['deal']) : $array['deal']);
        

        $messages = $this->GetMessages($array['id'], $lastMessageId);
        $chat->setMessages($messages);

        if ($from != null)
            {
                $chat->setFrom($from);
            }

        $chat->setFrom($from);

        if ($to != null)
            {
                $chat->setTo($to);
            }
            
        if (!empty($array['advert'])) {
            $chat->setAdvert($this->adverts->Get($array['advert']));
        }

        return $chat;
    }

    private function ConvertArrayToAdminMessage(array $array): MessageAdmin
    {
        $messageadmin = new MessageAdmin();
        $messageadmin->setId($array['id']);
        $messageadmin->setFrom($array['from_id']);
        $messageadmin->setDate($array['date']);
        $messageadmin->setText($array['message']);
        $messageadmin->setRead($array['read_status']);
        $messageadmin->setChatId($array['chat_id']);

        return $messageadmin;
    }    

    private function ConvertArrayToAdminChat(array $array, int $lastMessageId = 0): ChatAdmin
    {

        $chatadmin = new ChatAdmin();
        $chatadmin->setId($array['id']);
        
        if ($array['to_id'] > 0)
            {
                $to = $this->users->Get($array['to_id']);
                $chatadmin->setTo($to);
            } 

        if ($array['from_id'] > 0)
            {
                $from = $this->users->Get($array['from_id']);
                $chatadmin->setFrom($from);
            }

        $chatadmin->setAccept(boolval($array['accept']));

        $messages = $this->GetAdminMessages($array['id'], $lastMessageId);
        $chatadmin->setMessages($messages);
        $chatadmin->setStatus($array['status']);

        return $chatadmin;
    }

}