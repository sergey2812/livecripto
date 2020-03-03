<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 6:27
 */

namespace LiveinCrypto\Types;


class Top_4_price
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var int
     */
    private $country = 0;

    /**
     * @var int
     */
    private $city = 0;   

    /**
     * @var int
     */
    private $section = 0;

    /**
     * @var int
     */
    private $category = 0;

    /**
     * @var int
     */
    private $subcategory = 0;

    /**
     * @var JSON
     */
    private $price_top_1 = null;   

    /**
     * @var JSON
     */
    private $price_top_2 = null;

    /**
     * @var JSON
     */
    private $price_top_3 = null;

    /**
     * @var JSON
     */
    private $price_top_4 = null;

}