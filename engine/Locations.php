<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 14:06
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Location;
use LiveinCrypto\Types\City;

class Locations extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    /**
     * @var Users
     */
    private $users;    

    /**
     * @var array
     */
    private $country_params = [
        'id',
        'name'
    ];    

    /**
     * @var array
     */
    private $city_params = [
        'id',
        'name',
        'country',
        'author'
    ];

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('locations');
    }

    public function GetLocation(int $id): Location
    {
        $id = $this->mysqli->escape_string($id);
        $this->mysqli->setTable('locations');
        $result = $this->mysqli->select(['id', 'name'], "id = '$id'", 1);

        return $this->ConvertArrayToLocation($result);
    }

    public function GetCountryIdByName(string $name): int
    {
        $this->mysqli->setTable('locations');
        $name = $this->mysqli->escape_string($name);
        $result = $this->mysqli->select(['id', 'name'], "name = '$name'", 1);

        return $result['id'];
    }

    public function GetLocations(): array
    {
        $this->mysqli->setTable('locations');
        $result = $this->mysqli->select(['id', 'name']);
        $return = [];

        if (!empty($result)) {
            foreach ($result as $category) {
                $return[] = $this->ConvertArrayToLocation($category);
            }
        }

        return $return;
    } 

    public function GetCountryCities(int $country_id): array
    {
        $this->mysqli->setTable('locations_cities');
        $country_id = $this->mysqli->escape_string($country_id);
        $result = $this->mysqli->select(['id', 'name', 'country', 'author'], "country = '$country_id'", 0, 'name ASC');
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToCity($result);
            } else{
                foreach ($result as $category) {
                    $return[] = $this->ConvertArrayToCity($category);
                }
            }
        }

        return $return;
    }    

    public function GetCitiesOfCountry(int $id): array
    {
        $this->mysqli->setTable('locations_cities');
        $result = $this->mysqli->select(['id', 'name', 'country', 'author'], "country = '$id'");
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToCity($result, true);
            } else{
                foreach ($result as $gorod) {
                    $return[] = $this->ConvertArrayToCity($gorod, true);
                }
            }
        }

        return $return;
    }

    private function ConvertArrayToLocation(array $array): Location
    {
        $location = new Location();
        $location->setId($array['id']);
        $location->setName($array['name']);
 //       $location->setCities($this->GetCountryCities($array['id']));
        return $location;
    }   

    private function ConvertArrayToCity(array $array): City
    {
        $city = new City();
        $city->setId($array['id']);
        $city->setName($array['name']);
        $city->setCountry($array['country']);
        $city->setAuthor($array['author']);

        return $city;
    }

    public function GetCityById(int $id): array
    {
        $this->mysqli->setTable('locations_cities');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id', 'name', 'country', 'author'], "id = '$id'", 1);
        $return = [];
        $return[] = $this->ConvertArrayToCity($result, true);

        return $return;
    }

    public function GetCityIdByName(string $name): int
    {
        $this->mysqli->setTable('locations_cities');
        $name = $this->mysqli->escape_string($name);
        $result = $this->mysqli->select(['id', 'name'], "name = '$name'", 1);

        return $result['id'];
    }    

    public function GetCity(int $id): City
    {
        $this->mysqli->setTable('locations_cities');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id', 'name', 'country', 'author'], "id = '$id'", 1);

        return $this->ConvertArrayToCity($result);
    }

    public function GetCityName(int $id): string
    {
        $this->mysqli->setTable('locations_cities');
        
        $result = $this->mysqli->select(['name'], "id = '$id'", 1);

        return $result['name'];
    }

    public function GetCities(): array
    {
        $this->mysqli->setTable('locations_cities');
        $result = $this->mysqli->select(['id', 'name', 'country', 'author']);
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToCity($result, true);
            } else{
                foreach ($result as $gorod) {
                    $return[] = $this->ConvertArrayToCity($gorod, true);
                }
            }
        }

        return $return;
    }    

    public function CreateCity(array $params): int
    {
        $this->mysqli->setTable('locations_cities');

        $name = $this->mysqli->escape_string($params['name']);
        $country = $this->mysqli->escape_string($params['country']);
        $author = $this->mysqli->escape_string($params['author']);

        $result = $this->mysqli->select(['id', 'name'], "country = '$country'", 1); 

                $city_params = [
                    'name' => $name,
                    'country' => $country,
                    'author' => $author
                ];
        if ($result)
            {          
                if ($result['name'] == $name)
                    {
                        return $result['id'];
                    }
                else
                    {                               
                        $result = $this->mysqli->insert($city_params);
                        $city_last_id = $this->mysqli->row_id();

                        return $city_last_id;
                    } 
            }
        else
            {
                $result = $this->mysqli->insert($city_params);
                $city_last_id = $this->mysqli->row_id();

                return $city_last_id;
            }             
    }    

    public function UpdateCity(int $id, array $params): bool
    {
        $this->mysqli->setTable('locations_cities');
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update($params, "id = '$id'", 1);
    }   


    public function CheckLocationsCity(string $name, int $id): bool
    {
        $this->mysqli->setTable($name);
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id'], "country = '$id'", 1);

        if (!empty($result)) {
            return true;
        } else{
            return false;
        }
    } 

    public function getCountryCount(): int
    {
        $this->mysqli->setTable('locations');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `locations`");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }        

    public function getCityCountByCountry(int $country_id): int
    {
        $this->mysqli->setTable('locations_cities');
        $country_id = $this->mysqli->escape_string($country_id);

        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `locations_cities` WHERE country = '$country_id'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function NewCity(array $params): int
    {
        $this->mysqli->setTable('locations_cities');

        $name = $this->mysqli->escape_string($params['name']);
        $country = $this->mysqli->escape_string($params['country']);
        $author = $this->mysqli->escape_string($params['author']);

        $result = $this->mysqli->select(['name'], "country = '$country'"); 

                $city_params = [
                    'name' => $name,
                    'country' => $country,
                    'author' => $author
                ];        

        if ($this->mysqli->num_rows > 0) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {                        
                        if ($result['name'] == $name)
                            {
                                return 1;
                            }
                        else
                            {                               
                                $this->mysqli->insert($city_params);
                                return 2;
                            }  
                    } 
                else
                    {
                        $name_exist = 0;
                        foreach ($result as $city) 
                            {
                                if ($city['name'] == $name)
                                    {
                                        $name_exist = 1;
                                        return 1;
                                    }
                            }

                        if ($name_exist != 1)
                            {                                        
                                $this->mysqli->insert($city_params);
                                return 2;
                            }
                        else
                            {
                               return 1; 
                            }
                    }
            } 
        else
            {
                $result = $this->mysqli->insert($city_params);
                if($result)
                    {
                        return 2;
                    } 
                else
                    {
                        return 1;
                    }
            }              
    }    

    public function EditCity(array $params): int
    {
        $this->mysqli->setTable('locations_cities');

        $id = $this->mysqli->escape_string($params['id']);
        $name = $this->mysqli->escape_string($params['name']);
        $country = $this->mysqli->escape_string($params['country']);
        $author = $this->mysqli->escape_string($params['author']);

        $city_params = [
            'name' => $name,
            'country' => $country,
            'author' => $author
        ];
                
        $result = $this->mysqli->update($city_params, "id = '$id'", 1);
        
        if($result)
            {
                return 4;
            } 
        else
            {
                return 3;
            }              
    }

    public function DeleteCity(array $params): int
    {
        $this->mysqli->setTable('locations_cities');

        $id = $this->mysqli->escape_string($params['id']);
                
        $result = $this->mysqli->delete("id = '$id'", 1);
        
        if($result)
            {
                return 6;
            } 
        else
            {
                return 5;
            }              
    }

    public function NewCountry(string $country_name): int
    {
        $this->mysqli->setTable('locations');

        $name = $this->mysqli->escape_string($country_name);

        $result = $this->mysqli->select(['id', 'name'], "name = '$name'"); 

        if ($result)
            {
                return 1;
            }
        else
            {
                    $country_params = [
                        'name' => $name
                    ];
                $this->mysqli->insert($country_params);
                return 2; 
            }
                          
    }    

    public function EditCountry(string $country_name, int $country_id): int
    {
        $this->mysqli->setTable('locations');

        $name = $this->mysqli->escape_string($country_name);
        $id = $this->mysqli->escape_string($country_id);

                $country_params = [
                    'name' => $name
                ];        
                
        $result = $this->mysqli->update($country_params, "id = '$id'", 1);
        
        if($result)
            {
                return 4;
            } 
        else
            {
                return 3;
            }              
    }

    public function DeleteCountry(int $country_id): int
    {
        $this->mysqli->setTable('locations');

        $id = $this->mysqli->escape_string($country_id);
                
        $result_country = $this->mysqli->delete("id = '$id'", 1);

        $this->mysqli->setTable('locations_cities');
                
        $result_cities = $this->mysqli->delete("country = '$id'");        
        
        if($result_country AND $result_cities)
            {
                return 6;
            } 
        else
            {
                return 5;
            }              
    }

}