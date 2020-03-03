{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var category_status = $("input[name='category_status']").val();

    if (category_status == 2)
        {
            alert("Новая категория добавлена в систему!");
            $("input[name='category_status']").val('');
        }
    if (category_status == 1)
        {
            alert("Такая категория уже есть в системе! Для добавления укажите новое имя или перейдите в редактирование!");
            $("input[name='category_status']").val('');
        }
                
    if (category_status == 4)
        {
            alert("Название категории исправлено и загружено в систему!");
            $("input[name='category_status']").val('');
        }
    if (category_status == 3)
        {
            alert("Название категории НЕ исправлено! Повторите редактирование или обратитесь к суперадмину!!");
            $("input[name='category_status']").val('');
        }

    if (category_status == 6)
        {
            alert("Категория удалена из системы!");
            $("input[name='category_status']").val('');
        }
    if (category_status == 5)
        {
            alert("Категория НЕ удалена! Повторите попытку удаления или обратитесь к суперадмину!");
            $("input[name='category_status']").val('');
        }

    $('#new_edit_category').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("input[name='name_category']").focus();
    })             

    $(".btn.btn-default.btn-md.new_category").on('click', function () 
        { 
            $(".modal-header h4").html('Создание новой категории');
            $("input[name='name_category']").val('');
            $(".modal-footer #del_category").html('Сохранить');
            $("#category_run input[name='function']").val("new_category");
            let section_id = $(this).data('section-id');
            $("input[name='section_id']").val(section_id);
            let section_name = $(this).data('section-name');
            $("input[name='section_name']").val(section_name);
        });
    
    $(".btn-default.btn.btn-sm.edit_category").on('click', function () 
        { 
            let section_id = $(this).data('section-id');
            let section_name = $(this).data('section-name');
            let category_id = $(this).data('category-id');
            let category_name = $(this).data('category-name');
            $(".modal-header h4").html('Редактирование названия категории');
            $("input[name='name_category']").val(category_name);
            $("input[name='category_name']").val(category_name);
            $("input[name='category_id']").val(category_id);
            $("input[name='section_id']").val(section_id);
            $("input[name='section_name']").val(section_name);
            $(".modal-footer #del_category").html('Сохранить изменения');
            $("#category_run input[name='function']").val("edit_category");
        });
    $(".btn-default.btn.btn-sm.delete_category").on('click', function () 
        { 
            let section_id = $(this).data('section-id');
            let section_name = $(this).data('section-name');
            let category_id = $(this).data('category-id');
            let category_name = $(this).data('category-name');
            $(".modal-header h4").html('Удаление категории из системы');
            $("input[name='name_category']").val(category_name);
            $("input[name='category_name']").val(category_name);
            $("input[name='category_id']").val(category_id);
            $("input[name='section_id']").val(section_id);
            $("input[name='section_name']").val(section_name);
            $(".modal-footer #del_category").html('Удалить');
            $("#category_run input[name='function']").val("del_category");
        }); 

        $("input[name='name_category']").on('change', function () 
            {
                if (!isNaN($("input[name='name_category']").val()))  
                    {
                        // It is a number
                        alert('В названии должны быть только буквы!');
                        $("input[name='name_category']").val('');
                    }
            });           
});
</script>

<div id="new_edit_category" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title category"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="category_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="section_id" value="">
        <input type="hidden" name="section_name" value="">
        <input type="hidden" name="category_id" value="">
        <input type="hidden" name="category_name" value="">
        <input type="hidden" name="category_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_category" placeholder="Впишите название категории" required>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button id="del_category" type="submit" class="btn btn-primary">Сохранить изменения</button>
          </div>
      </form>
    </div>
  </div>
</div>

<div class="container body">
    <div class="main_container">

        {include file='admin/elements/sidebar.tpl'}

        {include file='admin/elements/top_line.tpl'}
        <div class="right_col" role="main">
            <div>
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Категории для раздела {$section_name}</h3>
                <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=sections" class="btn btn-default btn-md">Вернуться назад, выбрать другой раздел</a>
                </div>                    
                    <div class="title_left">
                        <a href="#new_edit_category" class="btn btn-default btn-md new_category" data-toggle="modal" data-section-id="{$section_id}" data-section-name="{$section_name}">Создать новую категорию</a>
                    </div>
                </div>
                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего категорий в разделе {$section_name}, загруженных в систему, {$categories_count} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№ п/п</th>
                                        <th>Название категории</th>
                                        <th>Действие</th> 
                                        <th>Действие</th>
                                        <th>Подкатегории</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                        {foreach from=$all_categories item=$category}
                                            <tr>
                                                {$i = $i + 1}
                                                <th>{$i}</th>
                                                <th>{$category->getName()}</th>
                                                <th class="nmb"><a href="#new_edit_category" class="btn-default btn btn-sm edit_category" data-toggle="modal" data-category-id="{$category->getId()}" data-category-name="{$category->getName()}" data-section-id="{$section_id}" data-section-name="{$section_name}">Редактировать</a></th>
                                                <th class="nmb"><a href="#new_edit_category" class="btn-default btn btn-sm delete_category" data-toggle="modal" data-category-id="{$category->getId()}" data-category-name="{$category->getName()}" data-section-id="{$section_id}" data-section-name="{$section_name}">Удалить</a></th>
                                                <th class="nmb"><a href="/admin/settings.php?type=subcats&category_id={$category->getId()}&category_name={$category->getName()}&section_id={$section_id}&section_name={$section_name}" class="btn btn-success btn-sm">Открыть</a></th>
                                            </tr>
                                        {foreachelse}  
                                            <tr>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        {/foreach}  
                                    </tbody>
                                </table>
                                <input type="hidden" class="val_text" value="На данной странице отображаются категории, загруженные в систему">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}