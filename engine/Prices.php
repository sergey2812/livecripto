<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 24.08.2018
 * Time: 19:42
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Price;

class Prices extends Config
{

    public function __construct()
    {
        parent::__construct();
    }

    public function Get(array $prices): array
    {

        $return = [];

        foreach ($prices as $name => $amount){
            $return[] = $this->ConvertArrayToPrices([
                'name' => $name,
                'amount' => $amount
            ]);
        }

        return $return;

    }

    private function ConvertArrayToPrices(array $array): Price
    {
        $price = new Price();
        $price->setName($array['name']);
        $price->setAmount($array['amount']);

        return $price;
    }

}