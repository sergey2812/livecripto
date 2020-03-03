<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 25.08.2018
 * Time: 13:17
 */

namespace LiveinCrypto;


use LiveinCrypto\Helpers\UploadFiles;

class Avatars extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var UploadFiles
     */
    private $helper;

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('avatars');

        $this->helper = new UploadFiles();
    }

    public function Add(array $file): bool
    {
        $filename = $this->helper->UploadFile($file);
        if (!empty($filename)) {
            if ($this->mysqli->insert(['filename' => $filename])){
                return true;
            } else{
                return false;
            }
        } else{
            return false;
        }
    }

    public function Remove(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->delete("id = '$id'", 1);
    }

}