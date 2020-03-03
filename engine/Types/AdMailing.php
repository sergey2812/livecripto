<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 06.09.2018
 * Time: 16:26
 */

namespace LiveinCrypto\Types;


class AdMailing
{

    /**
     * @var null|int
     */
    private $id;
    /**
     * @var null|int
     * 1 - В очереди
     * 2 - Отправляется
     * 3 - В архиве
     */
    private $status;
    /**
     * @var null|string
     */
    private $name_mailing;
    /**
     * @var null|string
     */
    private $subject;

    /**
     * @var null|string
     */
    private $content;
    /**
     * @var null|string
     */
    private $content_html;

    /**
     * @var null|string
     */
    private $creation_date;
    /**
     * @var null|string
     */
    private $mailing_date;
    /**
     * @var null|int
     */
    private $method;
    /**
     * @var int
     */
    private $author_admin; 

    /**
     * @return int
     */
    public function getMethod(): int
    {
        return $this->method;
    }

    /**
     * @param int $position
     */
    public function setMethod(int $method): void
    {
        $this->method = $method;
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
    public function getNameMailing(): ?string
    {
        return $this->name_mailing;
    }

    /**
     * @param null|string $name
     */
    public function setNameMailing(?string $name_mailing): void
    {
        $this->name_mailing = $name_mailing;
    }

    /**
     * @return null|string
     */
    public function getSubject(): ?string
    {
        return $this->subject;
    }

    /**
     * @param null|string $title
     */
    public function setSubject(?string $subject): void
    {
        $this->subject = $subject;
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
     * @return null|string
     */
    public function getContentHtml(): ?string
    {
        return $this->content_html;
    }

    /**
     * @param null|string $content
     */
    public function setContentHtml(?string $content_html): void
    {
        $this->content_html = $content_html;
    }

    /**
     * @return null|string
     */
    public function getCreationDate(): ?string
    {
        return $this->creation_date;
    }

    /**
     * @param null|string $date_start
     */
    public function setCreationDate(?string $creation_date): void
    {
        $this->creation_date = $creation_date;
    }

    /**
     * @return null|string
     */
    public function getMailingDate(): ?string
    {
        return $this->mailing_date;
    }

    /**
     * @param null|string $date_end
     */
    public function setMailingDate(?string $mailing_date): void
    {
        $this->mailing_date = $mailing_date;
    }

    /**
     * @return int
     */
    public function getAdmin()
    {
        return $this->author_admin;
    }

    /**
     * @param User $author_admin
     */
    public function setAdmin($author_admin)
    {
        $this->author_admin = $author_admin;
    } 

}