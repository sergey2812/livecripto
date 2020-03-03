<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 4:25
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Currency;
use LiveinCrypto\Types\Rate;

class ExchangeRates extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var array
     */
    private $rate_params = [
        'id',
        'rate',
        'currency',
        'date'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('rates');
    }

    public function getCurrencies(): array
    {
        $currencies = $this->mysqli->query("SELECT name, code FROM `currencies`");
        return $currencies;
    }    

    public function GetExchangeRate(string $currency, int $days = 7): Currency
    {
        
        $result = $this->mysqli->select($this->rate_params, "currency = '$currency'", $days, 'id DESC');

        $rates = [];

        if ($this->mysqli->num_rows > 0){
            $last_rate = 0;
            $result = array_reverse($result);
            foreach ($result as $index => $rate){
                if ($index > 0) {
                    if ($rate['rate'] > $last_rate) {
                        $rate['difference'] = round(100 - $last_rate / ($rate['rate'] / 100), 2);
                    } else{
                        $rate['difference'] = round(100 - $rate['rate'] / ($last_rate / 100), 2) * -1;
                    }
                    $rates[] = $this->ConvertArrayToRate($rate);
                }
                $last_rate = $rate['rate'];
            }
            $rates = array_reverse($rates);
        }

        return $this->GetCurrencyObject($currency, $rates);
    }

    public function GetLastExchangeRates(int $limit = 30): array
    {

        $result = $this->mysqli->select(['id', 'id as id_main', 'currency', 'currency as currency_main', 'rate', 'date', '(SELECT rate FROM rates WHERE currency = currency_main AND id < id_main ORDER BY id DESC LIMIT 1) as before_rate'], '', $limit, 'id DESC');

        $rates = [];

        if ($this->mysqli->num_rows > 0){

            foreach ($result as $index => $rate){

                if ($rate['rate'] > $rate['before_rate']) {
                    $rate['difference'] = round(100 - $rate['before_rate'] / ($rate['rate'] / 100), 2);
                } else{
                    $rate['difference'] = round(100 - $rate['rate'] / ($rate['before_rate'] / 100), 2) * -1;
                }

                $rates[] = $this->ConvertArrayToRate($rate);
            }

        }

        return $rates;
    }

    public function GetActualRate(string $type): Rate
    {
        $type = $this->mysqli->escape_string($type);
        $rate = $this->mysqli->select($this->rate_params, "currency = '$type'", 1, 'id DESC');
        return $this->ConvertArrayToRate($rate, false);
    }

    public function Add(array $array): bool
    {
        $currency = $array['currency'];
        $date = date('Y-m-d');

        $this->mysqli->select(['id'], "currency = '$currency' AND date = '$date'", 1);

        if ($this->mysqli->num_rows == 0){

            $array['date'] = $date;
            return $this->mysqli->insert($array);

        } else{
            return true;
        }
    }

    private function ConvertArrayToRate(array $array, bool $full_info = true): Rate
    {
        $rate = new Rate();
        $rate->setId($array['id']);
        $rate->setRate($array['rate']);
        $rate->setCurrency($array['currency']);

        if ($full_info){
            $rate->setDate($array['date']);
            $rate->setRateDifference($array['difference']);
        }

        return $rate;
    }

    private function GetCurrencyObject(string $name, array $rates): Currency
    {
        $currency = new Currency();
        $currency->setName($name);
        $currency->setRates($rates);
        return $currency;
    }

}