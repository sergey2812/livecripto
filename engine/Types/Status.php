<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 14:03
 */

namespace LiveinCrypto\Types;


class Status
{

    /**
     * @var int
     */
    private $id;
    /**
     * @var name
     */
    private $name;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    /**
     * @return name
     */
    public function getName(): name
    {
        return $this->name;
    }

    /**
     * @param name $name
     */
    public function setName(name $name): void
    {
        $this->name = $name;
    }

}