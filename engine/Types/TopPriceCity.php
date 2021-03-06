<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 04.10.2018
 * Time: 21:23
 */

namespace LiveinCrypto\Types;


class TopPriceCity
{

    /**
     * @var int
     */
    private $id;
    /**
     * @var string
     */
    private $name;
    /**
     * @var array
     */
    private $data;
    /**
     * @var null|array
     */
    private $prices;
    /**
     * @var int
     */
    private $country;
    /**
     * @var int
     */
    private $region;

    /**
     * @return int
     */
    public function getCountry(): int
    {
        return $this->country;
    }

    /**
     * @param int $country
     */
    public function setCountry(int $country): void
    {
        $this->country = $country;
    }

    /**
     * @return int
     */
    public function getRegion(): int
    {
        return $this->region;
    }

    /**
     * @param int $region
     */
    public function setRegion(int $region): void
    {
        $this->region = $region;
    }

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
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * @return array
     */
    public function getData(): array
    {
        return $this->data;
    }

    /**
     * @param array $data
     */
    public function setData(array $data): void
    {
        $this->data = $data;
    }

    /**
     * @return array|null
     */
    public function getPrices(): ?array
    {
        return $this->prices;
    }

    /**
     * @param array|null $prices
     */
    public function setPrices(?array $prices): void
    {
        $this->prices = $prices;
    }

}