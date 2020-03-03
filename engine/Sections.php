<?php
/**
 * Created by PhpStorm.
 * Project: CryptoMarketPlace
 * User: Sergey Konovalov <internet-restoran@rambler.ru>
 * Date: 17.08.2018
 * Time: 14:06
 */

namespace LiveinCrypto;


use LiveinCrypto\Types\Category;
use LiveinCrypto\Types\Section;
use LiveinCrypto\Types\Subcategory;

class Sections extends Config
{

    /**
     * @var Mysqli
     */
    private $mysqli;

    public function __construct()
    {
        parent::__construct();
        $this->mysqli = new Mysqli();
    }

    public function NewSection(string $section_name): int
    {
        $this->mysqli->setTable('sections');

        $name = $this->mysqli->escape_string($section_name);

        $result = $this->mysqli->select(['id', 'name'], "name = '$name'"); 

        if ($result)
            {
                return 1;
            }
        else
            {
                    $section_params = [
                        'name' => $name
                    ];
                $this->mysqli->insert($section_params);
                return 2; 
            }
                          
    }    

    public function EditSection(string $section_name, int $section_id): int
    {
        $this->mysqli->setTable('sections');

        $name = $this->mysqli->escape_string($section_name);
        $id = $this->mysqli->escape_string($section_id);

                $section_params = [
                    'name' => $name
                ];        
                
        $result = $this->mysqli->update($section_params, "id = '$id'", 1);
        
        if($result)
            {
                return 4;
            } 
        else
            {
                return 3;
            }              
    }    

    public function DeleteSection(int $section_id): int
    {
        $this->mysqli->setTable('sections');

        $sec_id = $this->mysqli->escape_string($section_id);
                
        $result_section = $this->mysqli->delete("id = '$sec_id'", 1);

        $this->mysqli->setTable('categories');

        $cats = $this->mysqli->select(['id'], "section = '$sec_id'");        

        if ($this->mysqli->num_rows > 0) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {                        
                        $cat_id = $cats['id'];
        
                        $result_category = $this->mysqli->delete("id = '$cat_id'", 1);

                        $this->mysqli->setTable('subcategories');
                                
                        $result_subcategory = $this->mysqli->delete("category = '$cat_id'");   
                    } 
                else
                    {
                        foreach ($cats as $cat) 
                            {
                                $this->mysqli->setTable('categories');

                                $cat_id = $cat['id'];

                                $result_category = $this->mysqli->delete("id = '$cat_id'", 1);

                                $this->mysqli->setTable('subcategories');
                                        
                                $result_subcategory = $this->mysqli->delete("category = '$cat_id'"); 
                            }
                    }
                
                if($result_section AND $result_category AND $result_subcategory)
                    {
                        return 6;
                    } 
                else
                    {
                        return 5;
                    }                    
            } 
        else
            {
                if($result_section)
                    {
                        return 6;
                    } 
                else
                    {
                        return 5;
                    }       
            }                           
    }     

    public function GetSection(int $id): Section
    {
        $this->mysqli->setTable('sections');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id', 'name'], "id = '$id'", 1);

        return $this->ConvertArrayToSection($result);
    }
    public function GetSections(): array
    {
        $this->mysqli->setTable('sections');
        $result = $this->mysqli->select(['id', 'name']);
        $return = [];

        if (!empty($result)) {
            foreach ($result as $section) {
                $return[] = $this->ConvertArrayToSection($section);
            }
        }

        return $return;
    }
    public function GetSectionCategories(int $section_id): array
    {
        $this->mysqli->setTable('categories');
        $section_id = $this->mysqli->escape_string($section_id);
        $result = $this->mysqli->select(['id', 'name', 'icon'], "section = '$section_id'", 0, 'name ASC');
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToCategory($result);
            } else{
                foreach ($result as $category) {
                    $return[] = $this->ConvertArrayToCategory($category);
                }
            }
        }

        return $return;
    }

    public function GetCategory(int $id): Category
    {
        $this->mysqli->setTable('categories');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id', 'name', 'icon'], "id = '$id'", 1);

        return $this->ConvertArrayToCategory($result);
    }
    public function GetCategories(): array
    {
        $this->mysqli->setTable('categories');
        $result = $this->mysqli->select(['id', 'name', 'icon']);
        $return = [];

        if (!empty($result)) {
            foreach ($result as $category) {
                $return[] = $this->ConvertArrayToCategory($category);
            }
        }

        return $return;
    }

    public function CreateCategory(string $name, int $section_id, ?string $icon = null): bool
    {
        $this->mysqli->setTable('categories');
        return $this->mysqli->insert(['name' => $name, 'section' => $section_id, 'icon' => $icon]);
    }

    public function NewCategory(array $params): int
    {
        $this->mysqli->setTable('categories');

        $name = $this->mysqli->escape_string($params['name']);
        $section = $this->mysqli->escape_string($params['section']);

        $result = $this->mysqli->select(['name'], "section = '$section'"); 

                $category_params = [
                    'name' => $name,
                    'section' => $section
                ];        

        if ($this->mysqli->num_rows > 0) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {                        
                        if ($result['name'] == $name)
                            {
                                return 1;
                            }
                        else
                            {                               
                                $this->mysqli->insert($category_params);
                                return 2;
                            }  
                    } 
                else
                    {
                        $name_exist = 0;
                        foreach ($result as $category) 
                            {
                                if ($category['name'] == $name)
                                    {
                                        $name_exist = 1;
                                        return 1;
                                    }
                            }

                        if ($name_exist != 1)
                            {                                        
                                $this->mysqli->insert($category_params);
                                return 2;
                            }
                        else
                            {
                               return 1; 
                            }
                    }
            } 
        else
            {
                $result = $this->mysqli->insert($category_params);
                if($result)
                    {
                        return 2;
                    } 
                else
                    {
                        return 1;
                    }
            }              
    }

    public function UpdateCategory(int $id, array $params): bool
    {
        $this->mysqli->setTable('categories');
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update($params, "id = '$id'", 1);
    }

    public function EditCategory(array $params): int
    {
        $this->mysqli->setTable('categories');

        $id = $this->mysqli->escape_string($params['id']);
        $name = $this->mysqli->escape_string($params['name']);
        $section = $this->mysqli->escape_string($params['section']);

        $category_params = [
            'name' => $name,
            'section' => $section
        ];
                
        $result = $this->mysqli->update($category_params, "id = '$id'", 1);
        
        if($result)
            {
                return 4;
            } 
        else
            {
                return 3;
            }              
    } 

    public function DeleteCategory(int $category_id): int
    {
        $this->mysqli->setTable('categories');

        $id = $this->mysqli->escape_string($category_id);
                
        $result_category = $this->mysqli->delete("id = '$id'", 1);

        $this->mysqli->setTable('subcategories');
                
        $result_subcategory = $this->mysqli->delete("category = '$id'");        
        
        if($result_category AND $result_subcategory)
            {
                return 6;
            } 
        else
            {
                return 5;
            }              
    }       

    public function GetCategorySubcategories(int $category_id): array
    {
        $this->mysqli->setTable('subcategories');
        $category_id = $this->mysqli->escape_string($category_id);
        $result = $this->mysqli->select(['id', 'name', 'icon'], "category = '$category_id'");
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToSubcategory($result);
            } else{
                foreach ($result as $category) {
                    $return[] = $this->ConvertArrayToSubcategory($category);
                }
            }
        }

        return $return;
    }

    public function GetSubcategory(int $id): Subcategory
    {
        $this->mysqli->setTable('subcategories');
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id', 'name', 'icon'], "id = '$id'", 1);

        return $this->ConvertArrayToSubcategory($result);
    }
    public function GetSubcategories(): array
    {
        $this->mysqli->setTable('subcategories');
        $result = $this->mysqli->select(['id', 'name', 'category', 'icon']);
        $return = [];

        if ($this->mysqli->num_rows > 0) {
            if ($this->mysqli->num_rows == 1) {
                $return[] = $this->ConvertArrayToSubcategory($result, true);
            } else{
                foreach ($result as $subcategory) {
                    $return[] = $this->ConvertArrayToSubcategory($subcategory, true);
                }
            }
        }

        return $return;
    }

    public function CreateSubcategory(string $name, int $category_id, ?string $icon = null): bool
    {
        $this->mysqli->setTable('subcategories');
        return $this->mysqli->insert(['name' => $name, 'category' => $category_id, 'icon' => $icon]);
    }

    public function NewSubcategory(array $params): int
    {
        $this->mysqli->setTable('subcategories');

        $name = $this->mysqli->escape_string($params['name']);
        $category = $this->mysqli->escape_string($params['category']);

        $result = $this->mysqli->select(['name'], "category = '$category'"); 

                $subcategory_params = [
                    'name' => $name,
                    'category' => $category
                ];        

        if ($this->mysqli->num_rows > 0) 
            {
                if ($this->mysqli->num_rows == 1) 
                    {                        
                        if ($result['name'] == $name)
                            {
                                return 1;
                            }
                        else
                            {                               
                                $this->mysqli->insert($subcategory_params);
                                return 2;
                            }  
                    } 
                else
                    {
                        $name_exist = 0;
                        foreach ($result as $subcategory) 
                            {
                                if ($subcategory['name'] == $name)
                                    {
                                        $name_exist = 1;
                                        return 1;
                                    }
                            }

                        if ($name_exist != 1)
                            {                                        
                                $this->mysqli->insert($subcategory_params);
                                return 2;
                            }
                        else
                            {
                               return 1; 
                            }
                    }
            } 
        else
            {
                $result = $this->mysqli->insert($subcategory_params);
                if($result)
                    {
                        return 2;
                    } 
                else
                    {
                        return 1;
                    }
            }              
    }

    public function UpdateSubcategory(int $id, array $params): bool
    {
        $this->mysqli->setTable('subcategories');
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->update($params, "id = '$id'", 1);
    }

    public function EditSubcategory(array $params): int
    {
        $this->mysqli->setTable('subcategories');

        $id = $this->mysqli->escape_string($params['id']);
        $name = $this->mysqli->escape_string($params['name']);
        $category = $this->mysqli->escape_string($params['category']);

        $subcategory_params = [
            'name' => $name,
            'category' => $category
        ];
                
        $result = $this->mysqli->update($subcategory_params, "id = '$id'", 1);
        
        if($result)
            {
                return 4;
            } 
        else
            {
                return 3;
            }              
    } 

    public function DeleteSubcategory(array $params): int
    {
        $this->mysqli->setTable('subcategories');

        $id = $this->mysqli->escape_string($params['id']);
                
        $result = $this->mysqli->delete("id = '$id'", 1);
        
        if($result)
            {
                return 6;
            } 
        else
            {
                return 5;
            }              
    }           

    public function GetLocationCities($id): array
    {
        $id = $this->mysqli->escape_string($id);
        return $this->mysqli->query("SELECT `location_name` FROM `adverts` WHERE `location` = '$id' GROUP BY `location_name` ORDER BY `location_name` ASC");
    }

    public function CheckSections(string $type, int $id): bool
    {
        $this->mysqli->setTable($type);
        $id = $this->mysqli->escape_string($id);
        $result = $this->mysqli->select(['id'], "id = '$id'", 1);

        if (!empty($result)) {
            return true;
        } else{
            return false;
        }
    }

    private function ConvertArrayToSection(array $array): Section
    {
        $section = new Section();
        $section->setId($array['id']);
        $section->setName($array['name']);
        $section->setCategories($this->GetSectionCategories($array['id']));

        return $section;
    }

    private function ConvertArrayToCategory(array $array): Category
    {
        $category = new Category();
        $category->setId($array['id']);
        $category->setName($array['name']);
        $category->setIcon($array['icon']);
        $category->setSubcategories($this->GetCategorySubcategories($array['id']));

        return $category;
    }

    private function ConvertArrayToSubcategory(array $array, bool $full_info = false): Subcategory
    {
        $subcategory = new Subcategory();
        $subcategory->setId($array['id']);
        $subcategory->setName($array['name']);
        $subcategory->setIcon($array['icon']);

        if ($full_info) {
            $subcategory->setParent($this->GetCategory($array['category']));
        }

        return $subcategory;
    }

    public function getSectionsCount(): int
    {
        $this->mysqli->setTable('sections');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `sections`");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getCategoriesBySectionIdCount(int $id_section): int
    {
        $this->mysqli->setTable('categories');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `categories` WHERE `section` = '$id_section'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }

    public function getSubCategoriesBySectionIdCount(int $id_category): int
    {
        $this->mysqli->setTable('subcategories');
        $count = $this->mysqli->query("SELECT COUNT(*) AS count FROM `subcategories` WHERE `category` = '$id_category'");
        $count = $count[0];

        if (!empty($count['count'])) return $count['count'];
        return 0;
    }                

}