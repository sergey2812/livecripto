<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 11.09.2018
 * Time: 4:27
 */

namespace LiveinCrypto\Types;


class Currency
{

    /**
     * @var string
     */
    private $name;
    /**
     * @var Rate[]
     */
    private $rates;

    public function getCurrentRate(): ?float
    {
        $rate = 0;
        if (!empty($this->rates)) {
            $rate = $this->rates[0]->getRate();
        }
        return $rate;
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
     * @return Rate[]
     */
    public function getRates(): array
    {
        return $this->rates;
    }

    /**
     * @param Rate[] $rates
     */
    public function setRates(array $rates): void
    {
        $this->rates = $rates;
    }

}