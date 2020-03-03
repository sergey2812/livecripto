<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 06.09.2018
 * Time: 16:26
 */

namespace LiveinCrypto\Types;


class Ad
{

    /**
     * @var null|int
     */
    private $id;
    /**
     * @var null|int
     * 1 - В очереди
     * 2 - Опубликовано
     * 3 - В архиве
     */
    private $status;
    /**
     * @var null|string
     */
    private $name;
    /**
     * @var null|string
     */
    private $title;
    /**
     * @var null|string
     */
    private $description;
    /**
     * @var null|string
     */
    private $content;
    /**
     * @var null|string
     */
    private $date_start;
    /**
     * @var null|string
     */
    private $date_end;
    /**
     * @var null|int
     */
    private $section;
    /**
     * @var null|int
     */
    private $category;
    /**
     * @var null|int
     */
    private $subcategory;
    /**
     * @var int
     */
    private $position;

    /**
     * @return int|null
     */
    public function getSection(): ?int
    {
        return $this->section;
    }

    /**
     * @param int|null $section
     */
    public function setSection(?int $section): void
    {
        $this->section = $section;
    }

    /**
     * @return int
     */
    public function getPosition(): int
    {
        return $this->position;
    }

    /**
     * @param int $position
     */
    public function setPosition(int $position): void
    {
        $this->position = $position;
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
     * @return int|null
     */
    public function getStatus(): ?int
    {
        return $this->status;
    }

    /**
     * @param int|null $status
     */
    public function setStatus(?int $status): void
    {
        $this->status = $status;
    }

    /**
     * @return null|string
     */
    public function getName(): ?string
    {
        return $this->name;
    }

    /**
     * @param null|string $name
     */
    public function setName(?string $name): void
    {
        $this->name = $name;
    }

    /**
     * @return null|string
     */
    public function getTitle(): ?string
    {
        return $this->title;
    }

    /**
     * @param null|string $title
     */
    public function setTitle(?string $title): void
    {
        $this->title = $title;
    }

    /**
     * @return null|string
     */
    public function getDescription(): ?string
    {
        return $this->description;
    }

    /**
     * @param null|string $description
     */
    public function setDescription(?string $description): void
    {
        $this->description = $description;
    }

    /**
     * @return null|string
     */
    public function getContent(): ?string
    {
        return $this->content;
    }

    /**
     * @param null|string $content
     */
    public function setContent(?string $content): void
    {
        $this->content = $content;
    }

    /**
     * @return int|null
     */
    public function getPublish(): ?int
    {
        return $this->publish;
    }

    /**
     * @param int|null $publish
     */
    public function setPublish(?int $publish): void
    {
        $this->publish = $publish;
    }

    /**
     * @return null|string
     */
    public function getDateStart(): ?string
    {
        return $this->date_start;
    }

    /**
     * @param null|string $date_start
     */
    public function setDateStart(?string $date_start): void
    {
        $this->date_start = $date_start;
    }

    /**
     * @return null|string
     */
    public function getDateEnd(): ?string
    {
        return $this->date_end;
    }

    /**
     * @param null|string $date_end
     */
    public function setDateEnd(?string $date_end): void
    {
        $this->date_end = $date_end;
    }

    /**
     * @return int|null
     */
    public function getCategory(): ?int
    {
        return $this->category;
    }

    /**
     * @param int|null $category
     */
    public function setCategory(?int $category): void
    {
        $this->category = $category;
    }

    /**
     * @return int|null
     */
    public function getSubcategory(): ?int
    {
        return $this->subcategory;
    }

    /**
     * @param int|null $subcategory
     */
    public function setSubcategory(?int $subcategory): void
    {
        $this->subcategory = $subcategory;
    }

}