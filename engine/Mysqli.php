<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 15.08.2018
 * Time: 0:18
 */

namespace LiveinCrypto;


class Mysqli extends Config
{

    /**
     * @var \mysqli
     */
    private $mysqli;

    /**
     * @var string
     */
    private $table;

    /**
     * @var int
     */
    public $num_rows = 0;

    /**
     * @var int
     */
    public $insert_id = 0;

    /**
     * Mysqli constructor.
     */
    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new \mysqli($this->mysqli_host, $this->mysqli_user, $this->mysqli_password, $this->mysqli_database);
        $this->mysqli->set_charset('utf8');
    }

    /**
     * @return string
     */
    public function getTable(): string
    {
        return $this->table;
    }

    /**
     * @param string $table
     */
    public function setTable(string $table): void
    {
        $this->table = $table;
    }

    public function insert(array $params)
    {
        foreach ($params as $key => $value) {
            unset($params[$key]);
            $key = mysqli_escape_string($this->mysqli, $key);
            if ((empty($value) OR $value == 'NULL') AND $value !== '0' AND $value !== 0) {
                $value = 'NULL';
            } else{
                $value = '\''.mysqli_escape_string($this->mysqli, $value).'\'';
            }
            $params[$key] = $value;
        }
        /*echo 'INSERT INTO '.$this->table.' ('.implode(',', array_keys($params)).') VALUES ('.implode(',', $params).')';
        die();*/

        $result = $this->mysqli->query('INSERT INTO '.$this->table.' ('.implode(',', array_keys($params)).') VALUES ('.implode(',', $params).')');

        if ($result) {
            $this->insert_id = $this->mysqli->insert_id;
        }

        return $result;
    }

    public function update(array $params, string $where, int $limit = 0): bool
    {
        if ($limit == 0) {
            $limit = '';
        } else{
            $limit = ' LIMIT '.$limit;
        }

        if (!empty($where)) {
            $where = ' WHERE '.$where;
        }

        $update_string = [];

        foreach ($params as $key => $value) {
            $key = mysqli_escape_string($this->mysqli, $key);
            if (empty($value) OR $value == 'NULL') {
                $value = 'NULL';
            } else{
                $value = '\''.mysqli_escape_string($this->mysqli, $value).'\'';
            }
            $update_string[] = $key.' = '.$value;
        }

        //echo 'UPDATE '.$this->table.' SET '.implode(',', $update_string).$where.$limit;

        return $this->mysqli->query('UPDATE '.$this->table.' SET '.implode(',', $update_string).$where.$limit);
    }

    public function select(array $params, string $where = null, ?string $limit = '0', string $order = '', string $group = '', int $offset = 0): array
    {
        if ($limit == '0' OR empty($limit)) {
            $limit = '';
        } else{
            $limit = ' LIMIT '.$limit;
        }

        if ($offset > 0){
            $limit .= ' OFFSET '.$offset;
        }

        if (!empty($where)) {
            $where = ' WHERE '.$where;
        }

        if (!empty($order)){
            $order = " ORDER BY $order ";
        }

        if (!empty($group)){
            $group = " GROUP BY $group ";
        }

        //echo 'SELECT '.implode(',', $params).' FROM '.$this->table.$where.$order.$group.$limit."\n";

        $result = $this->mysqli->query('SELECT '.implode(',', $params).' FROM '.$this->table.$where.$order.$group.$limit);

        $return = array();

        $this->num_rows = mysqli_num_rows($result);    

        if (mysqli_num_rows($result) == 1) {

            $return = mysqli_fetch_assoc($result);

        } elseif(mysqli_num_rows($result) > 1) {

            while ($row = mysqli_fetch_assoc($result)) {
                $return[] = $row;
               
            }
        }

        return $return;

    }

    public function delete(string $where, int $limit = 0): bool
    {
        if ($limit == 0) {
            $limit = '';
        } else{
            $limit = ' LIMIT '.$limit;
        }

        if (!empty($where)) {
            $where = ' WHERE '.$where;
        }

        return $this->mysqli->query('DELETE FROM '.$this->table.$where.$limit);
    }

    /**
     * Произвольный запрос в БД. Нужно обязательно все строки провести через escape_string
     * @param string $query Строка query
     * @return array
     */
    public function query(string $query): array
    {
        $result = $this->mysqli->query($query);

        if (stripos($query, 'SELECT') !== false) {

            $this->num_rows = mysqli_num_rows($result);

            if (mysqli_num_rows($result) == 1) {
                return [mysqli_fetch_assoc($result)];
            } else{

                $return = [];
                while ($row = mysqli_fetch_assoc($result)) {
                    $return[] = $row;
                }
                return $return;
            }
        } else{
            return [];
        }
    }

    public function row_id(): int
    {
        return $this->mysqli->insert_id;
    }

    public function escape_string(string $string): string
    {
        return mysqli_escape_string($this->mysqli, $string);
    }

}