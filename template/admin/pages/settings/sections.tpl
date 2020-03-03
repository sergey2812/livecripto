{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var section_status = $("input[name='section_status']").val();

    if (section_status == 2)
        {
            alert("Новый раздел добавлен в систему!");
            $("input[name='section_status']").val('');
        }
    if (section_status == 1)
        {
            alert("Такой раздел уже есть в системе! Для добавления укажите новое имя или перейдите в редактирование!");
            $("input[name='section_status']").val('');
        }
                
    if (section_status == 4)
        {
            alert("Название раздела исправлено и загружено в систему!");
            $("input[name='section_status']").val('');
        }
    if (section_status == 3)
        {
            alert("Название раздела НЕ исправлено! Повторите редактирование или обратитесь к суперадмину!!");
            $("input[name='section_status']").val('');
        }

    if (section_status == 6)
        {
            alert("Раздел удален из системы!");
            $("input[name='section_status']").val('');
        }
    if (section_status == 5)
        {
            alert("Раздел НЕ удален! Повторите попытку удаления или обратитесь к суперадмину!");
            $("input[name='section_status']").val('');
        }

    $('#new_edit_section').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("input[name='name_section']").focus();
    })            

    $(".btn.btn-default.btn-md.new_section").on('click', function () 
        { 
            $(".modal-header h4").html('Создание нового раздела');
            $("input[name='name_section']").val('');
            $(".modal-footer #del_section").html('Сохранить');
            $("#section_run input[name='function']").val("new_section");
            let section_id = $(this).data('section-id');
            $("input[name='section_id']").val(section_id);
            let section_name = $(this).data('section-name');
            $("input[name='section_name']").val(section_name);
        });
    
    $(".btn-default.btn.btn-sm.edit_section").on('click', function () 
        { 
            let section_id = $(this).data('section-id');
            let section_name = $(this).data('section-name');
            $(".modal-header h4").html('Редактирование названия раздела');
            $("input[name='name_section']").val(section_name);
            $("input[name='section_name']").val(section_name);
            $("input[name='section_id']").val(section_id);
            $(".modal-footer #del_section").html('Сохранить изменения');
            $("#section_run input[name='function']").val("edit_section");
        });
    $(".btn-default.btn.btn-sm.delete_section").on('click', function () 
        { 
            let section_id = $(this).data('section-id');
            let section_name = $(this).data('section-name');
            $(".modal-header h4").html('Удаление раздела из системы');
            $("input[name='name_section']").val(section_name);
            $("input[name='section_name']").val(section_name);
            $("input[name='section_id']").val(section_id);
            $(".modal-footer #del_section").html('Удалить');
            $("#section_run input[name='function']").val("del_section");
        });  

        $("input[name='name_section']").on('change', function () 
            {
                if (!isNaN($("input[name='name_section']").val()))  
                    {
                        // It is a number
                        alert('В названии должны быть только буквы!');
                        $("input[name='name_section']").val('');
                    }
            });          
});
</script>

<div id="new_edit_section" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title section"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="section_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="section_id" value="">
        <input type="hidden" name="section_name" value="">
        <input type="hidden" name="section_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_section" placeholder="Впишите название раздела" required>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button id="del_section" type="submit" class="btn btn-primary">Сохранить изменения</button>
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
                    <h3>Разделы</h3>
                    <div class="title_left">
                        <a href="#new_edit_section" class="btn btn-default btn-md new_section" data-toggle="modal">Создать новый раздел</a>
                    </div>
                </div>

                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего разделов, загруженных в систему, {$sections_count} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№ п/п</th>
                                        <th>Название раздела</th>
                                        <th>Действие</th> 
                                        <th>Действие</th>
                                        <th>Категории</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                        {foreach from=$sections item=$section}
                                            <tr>
                                                {$i = $i + 1}
                                                <th>{$i}</th>
                                                <th>{$section->getName()}</th>
                                                <th class="nmb"><a href="#new_edit_section" class="btn-default btn btn-sm edit_section" data-toggle="modal" data-section-id="{$section->getId()}" data-section-name="{$section->getName()}">Редактировать</a></th>
                                                <th class="nmb"><a href="#new_edit_section" class="btn-default btn btn-sm delete_section" data-toggle="modal" data-section-id="{$section->getId()}" data-section-name="{$section->getName()}">Удалить</a></th>
                                                <th class="nmb"><a href="/admin/settings.php?type=cats&section_id={$section->getId()}&section_name={$section->getName()}" class="btn btn-success btn-sm">Открыть</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются разделы, загруженные в систему">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}