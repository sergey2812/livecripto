<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 24.08.2018
 * Time: 19:32
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Photo;

class Photos extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;


    public function __construct()
    {
        parent::__construct();

        $this->mysqli = new Mysqli();
        $this->mysqli->setTable('photos');
    }

    public function Get(array $ids): array
    {
        foreach ($ids as $i => $id){
            unset($ids[$i]);
            if (is_numeric($id)){
                $ids[$i] = $this->mysqli->escape_string($id);
            } else{
                continue;
            }
        }

        $photos = $this->mysqli->select(['id', 'filename'], 'id IN ('.implode(', ', $ids).')', count($ids));

        $return = [];

        if (!empty($photos)){
            if (count($ids) == 1){
                $return[] = $this->ConvertArrayToPhoto($photos);
            } else{
                foreach ($photos as $photo){
                    $return[] = $this->ConvertArrayToPhoto($photo);
                }
            }
        }

        return $return;

    }

    public function Upload($file): ?string
    {
        $pathinfo = pathinfo($file['name']);
        $pathinfo['extension'] = strtolower($pathinfo['extension']);
        if (($pathinfo['extension'] == 'png' OR $pathinfo['extension'] == 'jpg' OR $pathinfo['extension'] == 'jpeg' OR $pathinfo['extension'] == 'gif') AND $file['size'] <= $this->max_file_size) {
            $new_filename = time().rand(10000, 99999).'.'.$pathinfo['extension'];

            if (move_uploaded_file($file['tmp_name'], $this->files_storage.$new_filename)){
                return $new_filename;
            } else{
                return false;
            }
        } else{
            return false;
        }

    }

    public function UploadAvatarImg($file): ?string
    {
        $pathinfo = pathinfo($file['name']);
        $pathinfo['extension'] = strtolower($pathinfo['extension']);

        if (($pathinfo['extension'] == 'png' OR $pathinfo['extension'] == 'jpg' OR $pathinfo['extension'] == 'jpeg' OR $pathinfo['extension'] == 'gif' OR $pathinfo['extension'] == 'svg' AND $file['size'] <= $this->max_file_size)) 
            {
                $new_filename = $file['name'];

                if (move_uploaded_file($file['tmp_name'], $this->files_avatars_img.$new_filename))
                    {                       
                        return $new_filename;
                    } 
                else
                    {
                        return false;
                    }
            } 
        else
            {
                return false;
            }

    }    

    public function UploadEmail($file): ?string
    {
        $pathinfo = pathinfo($file['name']);
        $pathinfo['extension'] = strtolower($pathinfo['extension']);

        if (($pathinfo['extension'] == 'tpl' OR $pathinfo['extension'] == 'html' AND $file['size'] <= $this->max_file_size)) 
            {
                $new_filename = $file['name'];

                if (move_uploaded_file($file['tmp_name'], $this->files_html_emails.$new_filename))
                    {   
                    $text = file_get_contents($this->files_html_emails.$new_filename);                    

                        return $text;
                    } 
                else
                    {
                        return false;
                    }
            } 
        else
            {
                return false;
            }

    } 

    private function ConvertArrayToPhoto($array): Photo
    {
        $photo = new Photo();
        $photo->setId($array['id']);
        $photo->setFilename($array['filename']);

        return $photo;
    }

}