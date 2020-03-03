<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 14.08.2018
 * Time: 5:58
 */

namespace LiveinCrypto\Types;


class Advert
{

    /**
     * @var int
     */
    private $id = 0;

    /**
     * @var Section
     */
    private $section;

    /**
     * @var Category
     */
    private $category;

    /**
     * @var Subcategory
     */
    private $subcategory;

    /**
     * @var string
     */
    private $name;
    /**
     * @var int
     */
    private $conditionType = 0;

    /**
     * @var string
     */
    private $description;

    /**
     * @var string|null
     */
    private $locationName;

    /**
     * @var City
     */
    private $city;

    /**
     * @var Location
     */
    private $location;

    /**
     * @var Price[]
     */
    private $prices;

    /**
     * @var array
     */
    private $photos;

    /**
     * @var User
     */
    private $author;

    /**
     * @var string
     */
    private $date;

    /**
     * @var int
     * 1 - На проверке
     * 2 - Открытое
     * 3 - Закрытое
     */
    private $status;
    /**
     * @var bool
     */
    private $secure_deal;
    /**
     * @var null|int
     */
    private $views;
    /**
     * @var null|float
     */
    private $rating = 0;

    /**
     * Функция для получения первой цены из массива цен для вывода в каталогах товаров
     *
     * @return array
     */
    public function getFirstPrice(): array
    {
        $value = reset($this->prices);
        $type = key($this->prices);
        return [
            'type' => $type,
            'value' => $value
        ];
    }

    /**
     * @return int
     */
    public function getConditionType(): int
    {
        return $this->conditionType;
    }

    /**
     * @param int $conditionType
     */
    public function setConditionType(int $conditionType): void
    {
        $this->conditionType = $conditionType;
    }

    /**
     * @return string|null
     */
    public function getLocationName(): ?string
    {
        return $this->locationName;
    }

    /**
     * @param string|null $locationName
     */
    public function setLocationName(?string $locationName): void
    {
        $this->locationName = $locationName;
    }

    /**
     * @return City
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * @param City $city
     */
    public function setCity($city)
    {
        $this->city = $city;
    }

    /**
     * @return Location
     */
    public function getLocation()
    {
        return $this->location;
    }

    /**
     * @param Location $location
     */
    public function setLocation($location)
    {
        $this->location = $location;
    }

    /**
     * @return float|null
     */
    public function getRating(): ?float
    {
        return $this->rating;
    }

    /**
     * @param float|null $rating
     */
    public function setRating(?float $rating): void
    {
        $this->rating = $rating;
    }

    /**
     * @return int|null
     */
    public function getViews(): ?int
    {
        return $this->views;
    }

    /**
     * @param int|null $views
     */
    public function setViews(?int $views): void
    {
        $this->views = $views;
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
     * @return Section
     */
    public function getSection(): Section
    {
        return $this->section;
    }

    /**
     * @param Section $section
     */
    public function setSection(Section $section): void
    {
        $this->section = $section;
    }

    /**
     * @return Category
     */
    public function getCategory(): Category
    {
        return $this->category;
    }

    /**
     * @param Category $category
     */
    public function setCategory(Category $category): void
    {
        $this->category = $category;
    }

    /**
     * @return Subcategory
     */
    public function getSubcategory(): Subcategory
    {
        return $this->subcategory;
    }

    /**
     * @param Subcategory $subcategory
     */
    public function setSubcategory(Subcategory $subcategory): void
    {
        $this->subcategory = $subcategory;
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
     * @return string
     */
    public function getDescription(): string
    {
        return $this->description;
    }

    /**
     * @param string $description
     */
    public function setDescription(string $description): void
    {
        $this->description = $description;
    }

    /**
     * @return Price[]
     */
    public function getPrices(): array
    {
        return $this->prices;
    }

    /**
     * @param Price[] $prices
     */
    public function setPrices(array $prices): void
    {
        $this->prices = $prices;
    }

    /**
     * @return array
     */
    public function getPhotos(): array
    {
        return $this->photos;
    }

    /**
     * @param array $photos
     */
    public function setPhotos(array $photos): void
    {
        $this->photos = $photos;
    }

    /**
     * @return User
     */
    public function getAuthor(): User
    {
        return $this->author;
    }

    /**
     * @param User $author
     */
    public function setAuthor(User $author): void
    {
        $this->author = $author;
    }

    /**
     * @return string
     */
    public function getDate(): string
    {
        return $this->date;
    }

    /**
     * @param string $date
     */
    public function setDate(string $date): void
    {
        $this->date = $date;
    }

    /**
     * @return int
     */
    public function getStatus(): int
    {
        return $this->status;
    }

    /**
     * @param int $status
     */
    public function setStatus(int $status): void
    {
        $this->status = $status;
    }

    /**
     * @return bool
     */
    public function getSecureDeal(): bool
    {
        return $this->secure_deal;
    }

    /**
     * @return bool
     */
    public function isSecureDeal(): bool
    {
        return $this->secure_deal;
    }

    /**
     * @param bool $secure_deal
     */
    public function setSecureDeal(bool $secure_deal): void
    {
        $this->secure_deal = $secure_deal;
    }

}