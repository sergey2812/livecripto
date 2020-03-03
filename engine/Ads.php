<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 06.09.2018
 * Time: 16:30
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Ad;
use LiveinCrypto\Types\AdMailing;

class Ads extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var array
     */
    private $ad_params = [
        'id',
        'status',
        'name',
        'title',
        'description',
        'content',
        'date_start',
        'date_end',
        'section',
        'category',
        'subcategory',
        'position'
    ];

    /**
     * @var array
     */
    private $ad_mailing_params = [
        'id',
        'name_mailing',
        'method',
        'status',
        'subject',
        'content',
        'content_html',
        'creation_date',
        'mailing_date',
        'author_admin'
    ];  

    /* данные для подкючения */
    private $config = [
        'smpt_host' => '127.0.0.1', 
        'smpt_port' => '25', 
        'smtp_login' => 'admin@liveincrypto.com', 
        'smtp_pass' => 'Test12345Test$', 
        'charset' => 'utf-8', 
        'from_name' => 'Admin', 
        'from_email' => 'admin@liveincrypto.com', 
        'email_errors' => 'admin@liveincrypto.com', 
    ];      

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('ads');

        $this->users = new Users();

    }

    public function Get(int $id): Ad
    {
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select($this->ad_params, "id = '$id'", 1);

        if ($this->mysqli->num_rows > 0){
            return $this->ConvertArrayToAd($result);
        } else{
            return new Ad();
        }
    }

    public function GetMailing(int $id): AdMailing
    {
        $this->mysqli->setTable('ads_mailing');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select($this->ad_mailing_params, "id = '$id'", 1);

        $this->mysqli->setTable('ads');

        if ($this->mysqli->num_rows > 0){
            return $this->ConvertArrayToAdMailing($result);
        } else{
            return new AdMailing();
        }
    }

    public function GetIcon(int $id): Ad
    {
        $this->mysqli->setTable('ads_icons');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select($this->ad_params, "id = '$id'", 1);
        $this->mysqli->setTable('ads');

        if ($this->mysqli->num_rows > 0){
            return $this->ConvertArrayToAd($result);
        } else{
            return new Ad();
        }
    }

    public function Return(int $position, int $section_id = 0, int $category_id = 0, int $subcategory_id = 0): string
    {
        $position = $this->mysqli->escape_string($position);

        $date = date("Y-m-d");

        $filters = [];
        $filters[] = "position = '$position'";
        $filters[] = "status = 2";
        $filters[] = "date(date_start) <= '$date'";
        $filters[] = "date(date_end) >= '$date'";
        if ($section_id > 0){
            $section_id = $this->mysqli->escape_string($section_id);
            $filters[] = "section = '$section_id'";
        } else{
            $filters[] = "section IS NULL";
        }
        if ($category_id > 0){
            $category_id = $this->mysqli->escape_string($category_id);
            $filters[] = "category = '$category_id'";
        } else{
            $filters[] = "category IS NULL";
        }
        if ($subcategory_id > 0){
            $subcategory_id = $this->mysqli->escape_string($subcategory_id);
            $filters[] = "subcategory = '$subcategory_id'";
        } else{
            $filters[] = "subcategory IS NULL";
        }

        $result = $this->mysqli->select($this->ad_params, implode(' AND ', $filters));

        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows > 1){
                $random = count($result);
                $random--;
                $random = rand(0, $random);
                $result = $result[$random];
            }
            $ad = $this->ConvertArrayToAd($result);
            return $ad->getContent();
        } else{
            return '';
        }
    }

    public function ReturnIcon(int $section_id = 0, int $category_id = 0, int $subcategory_id = 0): array
    {
        $date = date("Y-m-d");

        $filters = [];
        $filters[] = "status = 2";
        $filters[] = "date(date_start) <= '$date'";
        $filters[] = "date(date_end) >= '$date'";
        if ($section_id > 0){
            $section_id = $this->mysqli->escape_string($section_id);
            $filters[] = "section = '$section_id'";
        } else{
            $filters[] = "section IS NULL";
        }
        if ($category_id > 0){
            $category_id = $this->mysqli->escape_string($category_id);
            $filters[] = "category = '$category_id'";
        } else{
            $filters[] = "category IS NULL";
        }
        if ($subcategory_id > 0){
            $subcategory_id = $this->mysqli->escape_string($subcategory_id);
            $filters[] = "subcategory = '$subcategory_id'";
        } else{
            $filters[] = "subcategory IS NULL";
        }

        $this->mysqli->setTable('ads_icons');
        $result = $this->mysqli->select($this->ad_params, implode(' AND ', $filters));
        $this->mysqli->setTable('ads');

        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows > 1){
                $ads = [];
                foreach ($result as $ad) {
                    $ads[] = $this->ConvertArrayToAd($ad);
                }
                return $ads;
            } else{
                return [$this->ConvertArrayToAd($result)];
            }
        } else{
            return [];
        }
    }

    public function CronUpdate(): void
    {
        $date = date('Y-m-d');

        $filters = [];
        $filters[] = 'status = 1';
        $filters[] = "date(date_start) <= '$date'";
        $filters[] = "date(date_end) >= '$date'";

        $ads = $this->mysqli->select(['id'], implode(' AND ', $filters), 50);
        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows == 1){
                $ads = [$ads];
            }
            foreach ($ads as $ad){
                $this->Update($ad['id'], ['status' => 2]);
            }
        }

        $filters = [];
        $filters[] = 'status = 2';
        $filters[] = "date(date_end) < '$date'";

        $ads = $this->mysqli->select(['id'], implode(' AND ', $filters), 50);
        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows == 1){
                $ads = [$ads];
            }
            foreach ($ads as $ad){
                $this->Update($ad['id'], ['status' => 3]);
            }
        }
    }

    public function CronUpdateIconsStatuses(): void
    {
        $date = date('Y-m-d');
        $this->mysqli->setTable('ads_icons');

        $filters = [];
        $filters[] = 'status = 1';
        $filters[] = "date(date_start) <= '$date'";
        $filters[] = "date(date_end) >= '$date'";

        $ads = $this->mysqli->select(['id'], implode(' AND ', $filters), 50);
        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows == 1){
                $ads = [$ads];
            }
            foreach ($ads as $ad){
                $this->Update($ad['id'], ['status' => 2]);
            }
        }

        $filters = [];
        $filters[] = 'status = 2';
        $filters[] = "date(date_end) < '$date'";

        $ads = $this->mysqli->select(['id'], implode(' AND ', $filters), 50);
        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows == 1){
                $ads = [$ads];
            }
            foreach ($ads as $ad){
                $this->Update($ad['id'], ['status' => 3]);
            }
        }
        $this->mysqli->setTable('ads');
    }

    public function CronUpdateTopStatuses(): void
    {
        $date = date('Y-m-d');
        $this->mysqli->setTable('top_4_clients_payed_history');

        $filters = [];
        $filters[] = 'status = 2';
        $filters[] = "date(end_date) < '$date'";

        $ads = $this->mysqli->select(['id'], implode(' AND ', $filters), 50);
        if ($this->mysqli->num_rows > 0){
            if ($this->mysqli->num_rows == 1){
                $ads = [$ads];
            }
            foreach ($ads as $ad){
                $this->Update($ad['id'], ['status' => 4]);
            }
        }

        $this->mysqli->setTable('ads');
    }

    public function CronMailing(): void
    {
        $date = date('Y-m-d');
        $this->mysqli->setTable('ads_mailing');

        $filters = [];
        $filters[] = 'status = 1';
        $filters[] = "date(mailing_date) = '$date'";

        $ads = $this->mysqli->select(['id', 'subject', 'content', 'content_html', 'author_admin'], implode(' AND ', $filters), 1);
       
        if ($this->mysqli->num_rows > 0)
            {
                $subject = $ads['subject'];

                $this->Update($ads['id'], ['status' => 2]);

                if ($ads['content'] != '')
                    {
                        $content2 = $ads['content'];
                    }
                else
                    {
                        $content2 = $ads['content_html'];
                    }                    
                $all_users = $this->users->GetAll("email = 'internet-restoran@rambler.ru'");

                /* Для отправки HTML-почты надо установить шапку Content-type. */
                $unsub = 'http://liveincrypto.com/';


                foreach ($all_users as $user)
                    {
                        $to_login = $user->getLogin();
                        $content = 'Здравствуйте, '.$to_login.'!<br><br>';
                        $content .= $content2.'<br><br>';
                         
                        $to_email = array(
                            'email' => $user->getEmail(),
                            'name'  => $to_login,
                        );

                        $this->send($to_email, $subject, $content, $unsub);                        
                       
                    }
                                 
                $this->Update($ads['id'], ['status' => 3]);
            }

        $this->mysqli->setTable('ads');
    }

    /* функция отправки сообщений */
    public static function send($email, $subject, $message, $unsub, $list_id = '', $headers = '', $type = 'html') 
    {
        $config = [
            'smpt_host' => 'mail.liveincrypto.com', 
            'smpt_port' => 465, 
            'smtp_login' => 'admin@liveincrypto.com', 
            'smtp_pass' => 'Test12345Test$', 
            'charset' => 'utf-8', 
            'from_name' => 'Admin', 
            'from_email' => 'admin@liveincrypto.com', 
            'email_errors' => 'admin@liveincrypto.com', 
        ]; 
        /* проверка существования заголовков */
        if(empty($headers)) {
            $headers = '';
            $headers = "Date: ".date("D, d M Y H:i:s") . " UT\r\n";
            $headers .= "Subject: =?" . $config['charset'] . "?B?" . base64_encode($subject) . "=?=\r\n";
            $headers .= "Reply-To: " . $config['from_name'] . " <" . $config['from_email'] . ">\r\n";
            $headers .= "MIME-Version: 1.0\r\n";
            $headers .= "Content-Type: text/" . $type . "; charset=\"" . $config['charset'] . "\"\r\n";
            $headers .= "Content-Transfer-Encoding: 8bit\r\n";
            $headers .= "From: " . $config['from_name'] . " <" . $config['from_email'] . ">\r\n";
            $headers .= "To: " . $email['name'] . " <" . $email['email'] . ">\r\n";
            $headers .= "Errors-To: <" . $config['email_errors'] . ">\r\n";
            $headers .= "X-Complaints-To: " . $config['email_errors'] . "\r\n";
            $headers .= "List-Unsubscribe: <{$unsub}>\r\n";
            if(!empty($list_id)) $headers .= "List-id: <" . $list_id . ">\r\n";
            $headers .= "Precedence: bulk\r\n";
        }
        /* добавление заголовков к сообщению */
        $message = $headers . $message;
        $server_name = $_SERVER["SERVER_NAME"];
       
        /* создание сокета для подключения к SMTP-серверу */
        if(!$socket = fsockopen($config['smpt_host'], $config['smpt_port'], $errno, $errstr, 30)) {
            echo $errno . "<br />" . $errstr;
            return false;
        }

        fputs($socket, "EHLO " . $config['smpt_host'] . "\r\n");
        fputs($socket, "AUTH LOGIN\r\n");
        fputs($socket, base64_encode($config['smtp_login']) . "\r\n");
        fputs($socket, base64_encode($config['smtp_pass']) . "\r\n");
        fputs($socket, "MAIL FROM: <" . $config['from_email'] . ">\r\n");
        fputs($socket, "RCPT TO: <" . $email['email'] . ">\r\n");
        fputs($socket, "DATA\r\n");
        fputs($socket, $message . "\r\n.\r\n");
        fputs($socket, "QUIT\r\n");
        fclose($socket);

        return true;
    }

    public function GetBySection(int $section_id = 0, int $category_id = 0, int $subcategory_id = 0): Ad
    {
        $where = '';
        if ($section_id > 0){
            $section_id = $this->mysqli->escape_string($section_id);
            $where .= "section = '$section_id'";
        } else{
            $where .= "section IS NULL";
        }
        if ($category_id > 0){
            $category_id = $this->mysqli->escape_string($category_id);
            $where .= " AND category = '$category_id'";
        } else{
            $where .= " AND category IS NULL";
        }
        if ($subcategory_id > 0){
            $subcategory_id = $this->mysqli->escape_string($subcategory_id);
            $where .= " AND subcategory = '$subcategory_id'";
        } else{
            $where .= " AND subcategory IS NULL";
        }

        $date = date("Y-m-d");

        $where .= " AND date(date_start) <= '$date'";
        $where .= " AND date(date_end) >= '$date'";
        $where .= " AND status = '2'";

        $result = $this->mysqli->select($this->ad_params, $where, 1);

        if ($this->mysqli->num_rows > 0){
            return $this->ConvertArrayToAd($result);
        } else{
            if ($category_id != 0 AND $subcategory_id != 0){
                return $this->GetBySection();
            } else{
                return new Ad();
            }
        }
    }

    public function GetAll(string $where = '', $limit = 0): array
    {
        $result = $this->mysqli->select($this->ad_params, $where, $limit, 'position ASC');
        $return = [];

        if ($this->mysqli->num_rows == 1) {
            $return[] = $this->ConvertArrayToAd($result);
        } else{
            foreach ($result as $array) {
                $user = $this->ConvertArrayToAd($array);
                $return[] = $user;
            }
        }

        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }

    }

    public function GetAllIcons(string $where = '', $limit = 0): array
    {
        $this->mysqli->setTable('ads_icons');
        $result = $this->mysqli->select($this->ad_params, $where, $limit);
        $this->mysqli->setTable('ads');

        $return = [];

        if ($this->mysqli->num_rows == 1) {
            $return[] = $this->ConvertArrayToAd($result);
        } else{
            foreach ($result as $array) {
                $user = $this->ConvertArrayToAd($array);
                $return[] = $user;
            }
        }

        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }

    }

    public function GetAllMailings(string $where = '', $limit = 0): array
    {
        $this->mysqli->setTable('ads_mailing');
        $result = $this->mysqli->select($this->ad_mailing_params, $where, $limit);
        $this->mysqli->setTable('ads');

        $return = [];

        if ($this->mysqli->num_rows == 1) {
            $return[] = $this->ConvertArrayToAdMailing($result);
        } else{
            foreach ($result as $array) {
                $user = $this->ConvertArrayToAdMailing($array);
                $return[] = $user;
            }
        }

        if (!empty($return)) {
            return $return;
        } else{
            return [];
        }

    }

    public function Create(array $params): bool
    {
        return $this->mysqli->insert($params);
    }

    public function CreateIcon(array $params): bool
    {
        $this->mysqli->setTable('ads_icons');
        $r = $this->mysqli->insert($params);
        $this->mysqli->setTable('ads');

        return $r;
    }

    public function CreateMailing(array $params): bool
    {
        $this->mysqli->setTable('ads_mailing');
        $r = $this->mysqli->insert($params);
        $this->mysqli->setTable('ads');

        return $r;
    }

    public function Update(int $id, array $params): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update($params, "id = '$id'", 1);
    }

    public function UpdateIcon(int $id, array $params): bool
    {
        $this->mysqli->setTable('ads_icons');
        $id = $this->mysqli->escape_string($id);
        $r = $this->mysqli->update($params, "id = '$id'", 1);
        $this->mysqli->setTable('ads');
        
        return $r;
    }

    public function UpdateMailing(int $id, array $params): bool
    {
        $this->mysqli->setTable('ads_mailing');
        $id = $this->mysqli->escape_string($id);
        $r = $this->mysqli->update($params, "id = '$id'", 1);
        $this->mysqli->setTable('ads');
        
        return $r;
    }

    public function DeleteMailing(array $params): int
    {
        $this->mysqli->setTable('ads_mailing');

        $id = $this->mysqli->escape_string($params['id']);
                
        $result = $this->mysqli->delete("id = '$id'", 1);

        $this->mysqli->setTable('ads');
        
        if($result)
            {
                return 2;
            } 
        else
            {
                return 1;
            }              
    }    

    private function ConvertArrayToAd(array $array): Ad
    {
        $ad = new Ad();
        $ad->setId($array['id']);
        $ad->setStatus($array['status']);
        $ad->setName($array['name']);
        $ad->setTitle($array['title']);
        $ad->setDescription($array['description']);
        $ad->setContent($array['content']);

        $old_date = date($array['date_start']);
        $new_date_start = date('d.m.Y H:i', strtotime($old_date));        
        $ad->setDateStart($new_date_start);
        

        $old_date = date($array['date_end']);
        $new_date_end = date('d.m.Y H:i', strtotime($old_date));
        $ad->setDateEnd($new_date_end);
        
        $ad->setSection($array['section']);
        $ad->setCategory($array['category']);
        $ad->setSubcategory($array['subcategory']);
        $ad->setPosition($array['position']);

        return $ad;
    }

    private function ConvertArrayToAdMailing(array $array): AdMailing
    {
        $adMailing = new AdMailing();
        $adMailing->setId($array['id']);
        $adMailing->setNameMailing($array['name_mailing']);
        $adMailing->setMethod($array['method']);
        $adMailing->setStatus($array['status']);
        $adMailing->setSubject($array['subject']);
        $adMailing->setContent($array['content']);
        $adMailing->setContentHtml($array['content_html']);

        $old_creation_date = date($array['creation_date']);
        $new_creation_date = date('d.m.Y', strtotime($old_creation_date));        
        $adMailing->setCreationDate($new_creation_date);
        

        $old_mailing_date = date($array['mailing_date']);
        $new_mailing_date = date('d.m.Y', strtotime($old_mailing_date));
        $adMailing->setMailingDate($new_mailing_date);

        $adMailing->setAdmin(($array['author_admin'] > 0) ? $array['author_admin'] : '');

        return $adMailing;
    }

}