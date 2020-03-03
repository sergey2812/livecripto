<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 4:18
 */

namespace LiveinCrypto;

use LiveinCrypto\Types\Crypto;

class Currencies extends Config
{

    /**
     * @var Mysqli
     */
    public $mysqli;

    /**
     * @var array
     */
    private $currencies_params = [
        'id',
        'name',
        'code',
        'wallets_address',
        'bs_min_price'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('currencies');
    }

    public function GetCryptoByCode(string $cur_code)
    {

        $cur_code = $this->mysqli->escape_string($cur_code);

        $result = $this->mysqli->select($this->currencies_params, "code = '$cur_code'", 1);

        if (!empty($result)) {
            return $this->ConvertArrayToCrypto($result);
        } else{
            return false;
        }

    }

    public function GetCryptoById(int $cur_id)
    {

        $cur_id = $this->mysqli->escape_string($cur_id);

        $result = $this->mysqli->select($this->currencies_params, "id = '$cur_id'", 1);

        if (!empty($result)) {
            return $this->ConvertArrayToCrypto($result);
        } else{
            return false;
        }

    }    

    public function getAllCryptos(): array
    {
        $all_cryptos = $this->mysqli->query("SELECT id, name, code, wallets_address, bs_min_price FROM `currencies`");
        return $all_cryptos;
    }    

    public function getAllCryptosBs(): array
    {
        $all_cryptos_bs = $this->mysqli->query("SELECT id, name, code, wallets_address, bs_min_price FROM `currencies` WHERE bs_min_price != 0");
        return $all_cryptos_bs;
    }    

    public function Create(array $params): bool
    {
        $currency_code = $params['code'];
        $result = $this->mysqli->select(['code'], "code = '$currency_code'", 1);

        if (empty($result)) {
            return $this->mysqli->insert($params);
        } else{
            return false;
        }
    }

    public function Update(array $params): bool
    {
        $currency_id = $params['id'];
        $result = $this->mysqli->select(['id'], "id = '$currency_id'", 1);

        if (!empty($result)) {
            return $this->mysqli->update($params, "id = '$currency_id'", 1);
        } else{
            return false;
        }
    }

    public function RemoveCrypto(int $id): bool
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->delete("id = '$id'", 1);
    }

    public function getCryptoCount(): int
    {
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `currencies`");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }    

    private function ConvertArrayToCrypto(array $array): Crypto
    {
        $Crypto = new Crypto();
        $Crypto->setId($array['id']);
        $Crypto->setName($array['name']);
        $Crypto->setCode($array['code']);
        $Crypto->setWalletsAddress($array['wallets_address']);
        $Crypto->setBsMinPrice($array['bs_min_price']);

        return $Crypto;
    }  

    public function UploadCryptoImg($file, $code): ?string
    {
        $pathinfo = pathinfo($file['name']);
        $pathinfo['extension'] = strtolower($pathinfo['extension']);
        $name = strtolower($code);

        if (($pathinfo['extension'] == 'png' AND $file['size'] <= $this->max_file_size)) 
            {
                $new_filename = $name.'.'.$pathinfo['extension'];

                if (move_uploaded_file($file['tmp_name'], $this->files_crypto_img.$new_filename))
                    {                       
                        return $new_filename;
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
}