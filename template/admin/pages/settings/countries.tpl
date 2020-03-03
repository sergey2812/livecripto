{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var country_status = $("input[name='country_status']").val();

    if (country_status == 2)
        {
            alert("Новая страна добавлена в систему!");
            $("input[name='country_status']").val('');
        }
    if (country_status == 1)
        {
            alert("Такая страна уже есть в системе! Для добавления укажите новое имя или перейдите в редактирование!");
            $("input[name='country_status']").val('');
        }
                
    if (country_status == 4)
        {
            alert("Название страны исправлено и загружено в систему!");
            $("input[name='country_status']").val('');
        }
    if (country_status == 3)
        {
            alert("Название страны НЕ исправлено! Повторите редактирование или обратитесь к суперадмину!!");
            $("input[name='country_status']").val('');
        }

    if (country_status == 6)
        {
            alert("Страна удалена из системы!");
            $("input[name='country_status']").val('');
        }
    if (country_status == 5)
        {
            alert("Страна НЕ удалена! Повторите попытку удаления или обратитесь к суперадмину!");
            $("input[name='country_status']").val('');
        } 
    
    $('#new_edit_country').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("input[name='name_country']").focus();
    })           

    $(".btn.btn-default.btn-md.new_country").on('click', function () 
        { 
            $(".modal-header h4").html('Создание новой страны');
            $("input[name='name_country']").val('');
            $(".modal-footer #del_cont").html('Сохранить');
            $("#country_city_run input[name='function']").val("new_country");
            let country_id = $(this).data('country-id');
            $("input[name='country_id']").val(country_id);
            let country_name = $(this).data('country-name');
            $("input[name='country_name']").val(country_name);
        });
    
    $(".btn-default.btn.btn-sm.edit_country").on('click', function () 
        { 
            let country_id = $(this).data('country-id');
            let country_name = $(this).data('country-name');
            $(".modal-header h4").html('Редактирование названия страны');
            $("input[name='name_country']").val(country_name);
            $("input[name='country_name']").val(country_name);
            $("input[name='country_id']").val(country_id);
            $(".modal-footer #del_cont").html('Сохранить изменения');
            $("#country_city_run input[name='function']").val("edit_country");
        });
    $(".btn-default.btn.btn-sm.delete_country").on('click', function () 
        { 
            let country_id = $(this).data('country-id');
            let country_name = $(this).data('country-name');
            $(".modal-header h4").html('Удаление страны из системы');
            $("input[name='name_country']").val(country_name);
            $("input[name='country_name']").val(country_name);
            $("input[name='country_id']").val(country_id);
            $(".modal-footer #del_cont").html('Удалить');
            $("#country_city_run input[name='function']").val("del_country");
        });  

        $("input[name='name_country']").on('change', function () 
            {
                if (!isNaN($("input[name='name_country']").val()))  
                    {
                        // It is a number
                        alert('В названии должны быть только буквы!');
                        $("input[name='name_country']").val('');
                    }
            });
});
</script>

<div id="new_edit_country" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title country"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="country_city_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="country_id" value="">
        <input type="hidden" name="country_name" value="">
        <input type="hidden" name="country_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_country" placeholder="Впишите название страны" required>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button id="del_cont" type="submit" class="btn btn-primary">Сохранить изменения</button>
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
                    <h3>Страны</h3>
                    <div class="title_left">
                        <a href="#new_edit_country" class="btn btn-default btn-md new_country" data-toggle="modal">Создать страну</a>
                    </div>
                </div>

                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего стран, загруженных в систему, {$countries->getCountryCount()-1} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№ п/п</th>
                                        <th>Название страны</th>
                                        <th>Действие</th> 
                                        <th>Действие</th>
                                        <th>Города</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                        {foreach from=$all_countries item=$country}
                                            <tr>
                                                {$i = $i + 1}
                                                <th>{$i}</th>
                                                <th>{$country->getName()}</th>
                                                <th class="nmb"><a href="#new_edit_country" class="btn-default btn btn-sm edit_country" data-toggle="modal" data-country-id="{$country->getId()}" data-country-name="{$country->getName()}">Редактировать</a></th>
                                                <th class="nmb"><a href="#new_edit_country" class="btn-default btn btn-sm delete_country" data-toggle="modal" data-country-id="{$country->getId()}" data-country-name="{$country->getName()}">Удалить</a></th>
                                                <th class="nmb"><a href="/admin/settings.php?type=cities&country_id={$country->getId()}&country_name={$country->getName()}&city=all" class="btn btn-success btn-sm">Открыть</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются страны, загруженные в систему">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}