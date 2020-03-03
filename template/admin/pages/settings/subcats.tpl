{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var subcategory_status = $("input[name='subcategory_status']").val();

    if (subcategory_status == 2)
        {
            alert("Новая подкатегория добавлена в систему!");
            $("input[name='subcategory_status']").val('');
        }
    if (subcategory_status == 1)
        {
            alert("Такая подкатегория уже есть в системе! Для добавления укажите новое имя или перейдите в редактирование!");
            $("input[name='subcategory_status']").val('');
        }
                
    if (subcategory_status == 4)
        {
            alert("Название подкатегории исправлено и загружено в систему!");
            $("input[name='subcategory_status']").val('');
        }
    if (subcategory_status == 3)
        {
            alert("Название подкатегории НЕ исправлено! Повторите редактирование или обратитесь к суперадмину!!");
            $("input[name='subcategory_status']").val('');
        }

    if (subcategory_status == 6)
        {
            alert("Податегория удалена из системы!");
            $("input[name='subcategory_status']").val('');
        }
    if (subcategory_status == 5)
        {
            alert("Податегория НЕ удалена! Повторите попытку удаления или обратитесь к суперадмину!");
            $("input[name='subcategory_status']").val('');
        } 

    $('#new_edit_subcategory').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("input[name='name_subcategory']").focus();
    })           

    $(".btn.btn-default.btn-md.new_subcategory").on('click', function () 
        { 
            $(".modal-header h4").html('Создание новой подкатегории');
            $("input[name='name_subcategory']").val('');
            $(".modal-footer #del_subcategory").html('Сохранить');
            $("#subcategory_run input[name='function']").val("new_subcategory");
            let category_id = $(this).data('category-id');
            $("input[name='category_id']").val(category_id);
            let category_name = $(this).data('category-name');
            $("input[name='category_name']").val(category_name);
        });
    
    $(".btn-default.btn.btn-sm.edit_subcategory").on('click', function () 
        { 
            let category_id = $(this).data('category-id');
            let category_name = $(this).data('category-name');
            let subcategory_id = $(this).data('subcategory-id');
            let subcategory_name = $(this).data('subcategory-name');
            $(".modal-header h4").html('Редактирование названия подкатегории');
            $("input[name='name_subcategory']").val(subcategory_name);
            $("input[name='subcategory_name']").val(subcategory_name);
            $("input[name='subcategory_id']").val(subcategory_id);
            $("input[name='category_id']").val(category_id);
            $("input[name='category_name']").val(category_name);
            $(".modal-footer #del_subcategory").html('Сохранить изменения');
            $("#subcategory_run input[name='function']").val("edit_subcategory");
        });
    $(".btn-default.btn.btn-sm.delete_subcategory").on('click', function () 
        { 
            let category_id = $(this).data('category-id');
            let category_name = $(this).data('category-name');
            let subcategory_id = $(this).data('subcategory-id');
            let subcategory_name = $(this).data('subcategory-name');
            $(".modal-header h4").html('Удаление подкатегории из системы');
            $("input[name='name_subcategory']").val(subcategory_name);
            $("input[name='subcategory_name']").val(subcategory_name);
            $("input[name='subcategory_id']").val(subcategory_id);
            $("input[name='category_id']").val(category_id);
            $("input[name='category_name']").val(category_name);
            $(".modal-footer #del_subcategory").html('Удалить');
            $("#subcategory_run input[name='function']").val("del_subcategory");
        });    

        $("input[name='name_subcategory']").on('change', function () 
            {
                if (!isNaN($("input[name='name_subcategory']").val()))  
                    {
                        // It is a number
                        alert('В названии должны быть только буквы!');
                        $("input[name='name_subcategory']").val('');
                    }
            });     
});
</script>

<div id="new_edit_subcategory" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title subcategory"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="subcategory_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="category_id" value="">
        <input type="hidden" name="category_name" value="">
        <input type="hidden" name="subcategory_id" value="">
        <input type="hidden" name="subcategory_name" value="">
        <input type="hidden" name="subcategory_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_subcategory" placeholder="Впишите название подкатегории" required>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button id="del_subcategory" type="submit" class="btn btn-primary">Сохранить изменения</button>
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
                    <h3>Подкатегории для категории {$category_name}</h3>
                <div class="back_btn_wallet">
                <a href="/admin/settings.php?type=cats&section_id={$section_id}&section_name={$section_name}" class="btn btn-default btn-md">Вернуться назад, выбрать другую категорию</a>
                </div>                    
                    <div class="title_left">
                        <a href="#new_edit_subcategory" class="btn btn-default btn-md new_subcategory" data-toggle="modal" data-category-id="{$category_id}" data-category-name="{$category_name}">Создать новую подкатегорию</a>
                    </div>
                </div>
                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего подкатегорий в категории {$category_name}, загруженных в систему, {$subcategories_count} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№ п/п</th>
                                        <th>Название подкатегории</th>
                                        <th>Действие</th> 
                                        <th>Действие</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                        {foreach from=$all_subcategories item=$subcategory}
                                            <tr>
                                                {$i = $i + 1}
                                                <th>{$i}</th>
                                                <th>{$subcategory->getName()}</th>
                                                <th class="nmb"><a href="#new_edit_subcategory" class="btn-default btn btn-sm edit_subcategory" data-toggle="modal" data-subcategory-id="{$subcategory->getId()}" data-subcategory-name="{$subcategory->getName()}" data-category-id="{$category_id}" data-category-name="{$category_name}">Редактировать</a></th>
                                                <th class="nmb"><a href="#new_edit_subcategory" class="btn-default btn btn-sm delete_subcategory" data-toggle="modal" data-subcategory-id="{$subcategory->getId()}" data-subcategory-name="{$subcategory->getName()}" data-category-id="{$category_id}" data-category-name="{$category_name}">Удалить</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются подкатегории, загруженные в систему">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}