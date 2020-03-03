<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 25.08.2018
 * Time: 13:25
 */

namespace LiveinCrypto\Helpers;


use LiveinCrypto\Config;

class UploadFiles extends Config
{

    public function UploadFile($file): ?string
    {

        $path_info = pathinfo($file['name']);
        $filename = time().'-'.rand(100, 999).'-'.rand(100, 999).'.'.$path_info['extension'];

        if (move_uploaded_file($file['tmp_name'], $this->files_storage.$filename)){
            return $filename;
        } else{
            return false;
        }

    }

}