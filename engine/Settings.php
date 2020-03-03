<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 03.09.2018
 * Time: 18:49
 */

namespace LiveinCrypto;


class Settings extends Config
{

    public $telegram_link = 'https://t.me/';
    public $reddit_link = 'https://reddit.com/';
    public $vkontakte_link = 'https://vk.com/';
    public $instagram_link = 'https://instagram.com/';

    public $btc_wallet = '1f2d27d0fbef91d19e1f65333532451f';
    public $ltc_wallet = 'a0fd93745cc899339a801548c6a156e2';
    public $eth_wallet = 'f46ff046b18b56eb8d9239c5971286cf';

    /**
     * @var Mysqli
     */
    private $mysqli;

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('settings');
    }

    public function CreateSetting(string $name, string $value): bool
    {

        $name = $this->mysqli->escape_string($name);
        $value = $this->mysqli->escape_string($value);

        $params = [
            'name' => $name,
            'value' => $value
        ];

        return $this->mysqli->insert($params);
    }

    public function Get(string $name){
        $name = $this->mysqli->escape_string($name);
        return $this->mysqli->select(['value'], "name = '$name'", 1)['value'];
    }

    public function Update(array $params): void
    {
        foreach ($params as $name => $value) {
            $name = $this->mysqli->escape_string($name);
            $value = $this->mysqli->escape_string($value);

            $this->mysqli->update(['value' => $value], "name = '$name'", 1);
        }
    }

}