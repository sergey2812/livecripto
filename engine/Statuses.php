<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 14:06
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Status;

class Statuses extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('statuses');
    }

    public function GetStatus(int $id): Status
    {
        return new Status();
    }  

}