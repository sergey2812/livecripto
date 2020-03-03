<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 4:26
 */

namespace LiveinCrypto\Types;


class Rate
{

    /**
     * @var null|int
     */
    private $id;
    /**
     * @var null|float
     */
    private $rate;
    /**
     * @var null|string
     */
    private $date;
    /**
     * @var null|float
     */
    private $rate_difference;
    /**
     * @var null|string
     */
    private $currency;

    /**
     * @return null|string
     */
    public function getCurrency(): ?string
    {
        return $this->currency;
    }

    /**
     * @param null|string $currency
     */
    public function setCurrency(?string $currency): void
    {
        $this->currency = $currency;
    }

    /**
     * @return float|null
     */
    public function getRateDifference(): ?float
    {
        return $this->rate_difference;
    }

    /**
     * @param float|null $rate_difference
     */
    public function setRateDifference(?float $rate_difference): void
    {
        $this->rate_difference = $rate_difference;
    }

    /**
     * @return int|null
     */
    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @param int|null $id
     */
    public function setId(?int $id): void
    {
        $this->id = $id;
    }

    /**
     * @return float|null
     */
    public function getRate(): ?float
    {
        return $this->rate;
    }

    /**
     * @param float|null $rate
     */
    public function setRate(?float $rate): void
    {
        $this->rate = $rate;
    }

    /**
     * @return null|string
     */
    public function getDate(): ?string
    {
        return $this->date;
    }

    /**
     * @param null|string $date
     */
    public function setDate(?string $date): void
    {
        $this->date = $date;
    }

}