<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 04.10.2018
 * Time: 21:23
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\TopPriceCity;
use LiveinCrypto\Types\TopPriceCountry;
use LiveinCrypto\Types\TopPriceRegion;

class TopPrices extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var array
     */
    private $params = [
        'id',
        'name',
        'data',
        'default_prices'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
    }

    public function GetCountry(int $id): TopPriceCountry
    {
        $id = $this->mysqli->escape_string($id);
        $this->mysqli->setTable('countries');
        $result = $this->mysqli->select($this->params, "id = '$id'", 1);
        return $this->ConvertArrayToTopPriceCountry($result);
    }

    public function GetCountries(): array
    {
        return $this->GetList('countries');
    }

    public function AddPriceToCountry(int $id, string $type, float $price, int $position, int $section, int $category = 0, int $subcategory = 0): bool
    {
        $country = $this->GetCountry($id);
        $prices = $country->getPrices();
        if (!is_array($prices)){
            $prices = [];
        }
        $prices = $this->GetNewPrices($prices, $type, $price, $position, $section, $category, $subcategory);
        return $this->UpdatePricesCountry($id, $prices);

    }
    public function CreateCountry(string $name, string $data): int
    {
        return $this->InsertNew('countries', $name, $data);
    }

    private function UpdatePricesCountry(int $id, array $prices): bool
    {
        return $this->UpdatePrices('countries', $id, $prices);
    }


    public function GetRegion(int $id): TopPriceRegion
    {
        $id = $this->mysqli->escape_string($id);
        $this->mysqli->setTable('regions');

        $params = $this->params;
        $params[] = 'country';

        $result = $this->mysqli->select($params, "id = '$id'", 1);
        return $this->ConvertArrayToTopPriceRegion($result);
    }

    public function GetRegions(): array
    {
        return $this->GetList('regions');
    }

    public function AddPriceToRegion(int $id, string $type, float $price, int $position, int $section, int $category = 0, int $subcategory = 0): bool
    {
        $region = $this->GetRegion($id);
        $prices = $region->getPrices();
        if (!is_array($prices)){
            $prices = [];
        }
        $prices = $this->GetNewPrices($prices, $type, $price, $position, $section, $category, $subcategory);
        return $this->UpdatePricesRegion($id, $prices);

    }

    public function CreateRegion(string $name, string $data, int $country): int
    {
        return $this->InsertNew('regions', $name, $data, $country);
    }

    private function UpdatePricesRegion(int $id, array $prices): bool
    {
        return $this->UpdatePrices('regions', $id, $prices);
    }


    public function GetCity(int $id): TopPriceCity
    {
        $id = $this->mysqli->escape_string($id);
        $this->mysqli->setTable('cities');
        $params = $this->params;
        $params[] = 'country';
        $params[] = 'region';
        $result = $this->mysqli->select($params, "id = '$id'", 1);
        return $this->ConvertArrayToTopPriceCity($result);
    }

    public function GetCities(): array
    {
        return $this->GetList('cities');
    }

    public function AddPriceToCity(int $id, string $type, float $price, int $position, int $section, int $category = 0, int $subcategory = 0): bool
    {
        $city = $this->GetCity($id);
        $prices = $city->getPrices();
        if (!is_array($prices)){
            $prices = [];
        }
        $prices = $this->GetNewPrices($prices, $type, $price, $position, $section, $category, $subcategory);
        return $this->UpdatePricesCity($id, $prices);

    }

    public function CreateCity(string $name, string $data, int $country, int $region): int
    {
        return $this->InsertNew('cities', $name, $data, $country, $region);
    }

    private function UpdatePricesCity(int $id, array $prices): bool
    {
        return $this->UpdatePrices('cities', $id, $prices);
    }


    private function GetNewPrices(array $prices, string $type, float $price, int $position, int $section, int $category = 0, int $subcategory = 0): array
    {

        if (!array_key_exists($section, $prices)){
            $prices[$section] = [];
        }
        if (!array_key_exists($category, $prices[$section])){
            $prices[$section][$category] = [];
        }
        if (!array_key_exists($subcategory, $prices[$section][$category])){
            $prices[$section][$category][$subcategory] = [];
        }
        if (!array_key_exists($position, $prices[$section][$category][$subcategory])){
            $prices[$section][$category][$subcategory][$position] = [];
        }

        $prices[$section][$category][$subcategory][$position][$type] = $price;
        return $prices;

    }


    private function GetList(string $type): array
    {
        $this->mysqli->setTable($type);

        $params = $this->params;

        if ($type == 'regions'){
            $params[] = 'country';
        } elseif($type == 'cities'){
            $params[] = 'country';
            $params[] = 'region';
        }
        $result = $this->mysqli->select($params);
        if ($this->mysqli->num_rows == 1){
            $result = [$result];
        }

        $return = [];
        foreach ($result as $value){
            $return[] = $this->ConvertArrayToTopPriceCountry($value);
        }

        return $return;
    }

    private function InsertNew(string $type, string $name, string $data, int $country = 0, int $region = 0): int
    {
        $name = $this->mysqli->escape_string($name);
        $country = $this->mysqli->escape_string($country);
        $region = $this->mysqli->escape_string($region);

        $data = json_decode($data, true);
        $data = json_encode($data);

        $this->mysqli->setTable($type);

        $repeat = $this->mysqli->select(['id'], "name = '$name'", 1);

        if ($this->mysqli->num_rows == 0){
            if ($country > 0 AND $region > 0){
                $this->mysqli->insert(['name' => $name, 'data' => $data, 'country' => $country, 'region' => $region]);
            } elseif($country > 0) {
                $this->mysqli->insert(['name' => $name, 'data' => $data, 'country' => $country]);
            } else{
                $this->mysqli->insert(['name' => $name, 'data' => $data]);
            }
            return $this->mysqli->row_id();
        } else{
            return $repeat['id'];
        }
    }

    private function UpdatePrices(string $type, int $id, array $prices): bool
    {
        $id = $this->mysqli->escape_string($id);
        $prices = json_encode($prices);
        $this->mysqli->setTable($type);
        return $this->mysqli->update(['default_prices' => $prices], "id = '$id'", 1);
    }

    private function ConvertArrayToTopPriceCountry(array $array): TopPriceCountry
    {
        $price = new TopPriceCountry();
        $price->setId($array['id']);
        $price->setName($array['name']);
        $price->setData(json_decode($array['data'], true));
        $price->setPrices(json_decode($array['default_prices'], true));

        return $price;
    }

    private function ConvertArrayToTopPriceRegion(array $array): TopPriceRegion
    {
        $price = new TopPriceRegion();
        $price->setId($array['id']);
        $price->setName($array['name']);
        $price->setCountry($array['country']);
        $price->setData(json_decode($array['data'], true));
        $price->setPrices(json_decode($array['default_prices'], true));

        return $price;
    }

    private function ConvertArrayToTopPriceCity(array $array): TopPriceCity
    {
        $price = new TopPriceCity();
        $price->setId($array['id']);
        $price->setName($array['name']);
        $price->setCountry($array['country']);
        $price->setRegion($array['region']);
        $price->setData(json_decode($array['data'], true));
        $price->setPrices(json_decode($array['default_prices'], true));

        return $price;
    }

}