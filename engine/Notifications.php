<?php
/**
 * Created by PhpStorm.
 * Project: liveincrypto
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 08.10.2018
 * Time: 13:29
 */

namespace LiveinCrypto;


class Notifications extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /** Types:
     * adverts - Мои объявления
     * sells - Мои продажи
     * purchases - Мои покупки
     * messages - Чат
     */

    /**
     * Notifications constructor.
     */
    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('notifications');
    }

    public function CreateNotification(int $user_id, string $type): bool
    {
        $user_id = $this->mysqli->escape_string($user_id);
        $type = $this->mysqli->escape_string($type);

        return $this->mysqli->insert(['user_id' => $user_id, 'type' => $type]);
    }

    public function RemoveNotification(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->delete("id = '$id'", 1);
    }

    public function RemoveNotifications(int $user_id, string $type): bool
    {

        $user_id = $this->mysqli->escape_string($user_id);
        $type = $this->mysqli->escape_string($type);

        return $this->mysqli->delete("user_id = '$user_id' AND type = '$type'");
    }

    public function GetNotifications(int $user_id): array
    {
//        $user_id = $this->mysqli->escape_string($user_id);

        $array = [
            'adverts' => 0,
            'sells' => 0,
            'purchases' => 0,
            'messages' => $this->GetUnreadMessages($user_id),

            'adverts-moderation' => 0,
            'adverts-open' => 0,
            'adverts-close' => 0,

            
            'sells-moderation' => 0,
            'sells-open' => 0,
            'sells-close' => 0,

            
            'purchases-moderation' => 0,
            'purchases-open' => 0,
            'purchases-close' => 0,
        ];

        $result = $this->mysqli->select(['type', 'COUNT(*) as count'], "user_id = '$user_id'", 0, '', 'type');
        if (!empty($result)){
            if ($this->mysqli->num_rows == 1){
                $result = [$result];
            }
            foreach ($result as $item){
                $array[$item['type']] = $item['count'];
            }
        }

        return $array;
    }

    private function GetUnreadMessages(int $user_id): int
    {
        $count = 0;

        $this->mysqli->setTable('chats');
        $chats = $this->mysqli->select(['id'], "from_id = '$user_id' OR to_id = '$user_id'");

        if (!empty($chats)){
            if ($this->mysqli->num_rows == 1){
                $chats = [$chats];
            }

            $ids = [];

            foreach ($chats as $chat){
                $ids[] = $chat['id'];
            }

            if (!empty($ids)){
                $this->mysqli->setTable('messages');
                $result = $this->mysqli->select(['COUNT(*) as count'], "read_status = 0 AND from_id != '$user_id' AND chat_id IN (".implode(', ', $ids).")");
                $count = $result['count'];
            }
        }

        $this->mysqli->setTable('notifications');

        return $count;
    }


}