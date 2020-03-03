{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var city_status = $("input[name='city_status']").val();

    if (city_status == 2)
        {
            alert("Новый город добавлен в систему!");
            $("input[name='city_status']").val('');
        }
    if (city_status == 1)
        {
            alert("Такой город в системе уже есть! Для добавления укажите новое имя или перейдите в редактирование!");
            $("input[name='city_status']").val('');
        }
                
    if (city_status == 4)
        {
            alert("Название города исправлено и загружено в систему!");
            $("input[name='city_status']").val('');
        }
    if (city_status == 3)
        {
            alert("Название города не исправлено! Повторите редактирование или обратитесь к суперадмину!!");
            $("input[name='city_status']").val('');
        }

    if (city_status == 6)
        {
            alert("Город удален из системы!");
            $("input[name='city_status']").val('');
        }
    if (city_status == 5)
        {
            alert("Город НЕ удален! Повторите попытку удаления или обратитесь к суперадмину!");
            $("input[name='city_status']").val('');
        }

    $('#new_edit_country').on('shown.bs.modal', function () {
      //#new_edit_country - id элемента, которому необходимо установить фокус
      $("input[name='name_city']").focus();
    })        

    $(".btn.btn-default.btn-md.new_country").on('click', function () 
        { 
            $(".modal-header h4").html('Создание нового города');
            $("input[name='name_city']").val('');
            $(".modal-footer #del_cont").html('Сохранить');
            $("#city_country_run input[name='function']").val("new_city");
            let country_id = $(this).data('country-id');
            $("input[name='country_id']").val(country_id);
            let country_name = $(this).data('country-name');
            $("input[name='country_name']").val(country_name);
        });
    
    $(".btn-default.btn.btn-sm.edit_country").on('click', function () 
        { 
            let country_id = $(this).data('country-id');
            let country_name = $(this).data('country-name');
            let city_id = $(this).data('city-id');
            let city_name = $(this).data('city-name');
            $(".modal-header h4").html('Редактирование названия города');
            $("input[name='name_city']").val(city_name);
            $("input[name='country_name']").val(country_name);
            $("input[name='country_id']").val(country_id);
            $("input[name='city_name']").val(city_name);
            $("input[name='city_id']").val(city_id);
            $(".modal-footer #del_cont").html('Сохранить изменения');
            $("#city_country_run input[name='function']").val("edit_city");
        });
    $(".btn-default.btn.btn-sm.delete_country").on('click', function () 
        { 
            let country_id = $(this).data('country-id');
            let country_name = $(this).data('country-name');
            let city_id = $(this).data('city-id');
            let city_name = $(this).data('city-name');
            $(".modal-header h4").html('Удаление города из системы');
            $("input[name='name_city']").val(city_name);
            $("input[name='country_name']").val(country_name);
            $("input[name='country_id']").val(country_id);
            $("input[name='city_name']").val(city_name);
            $("input[name='city_id']").val(city_id);
            $(".modal-footer #del_cont").html('Удалить');
            $("#city_country_run input[name='function']").val("del_city");
        });   

        $("input[name='name_city']").on('change', function () 
            {
                if (!isNaN($("input[name='name_city']").val()))  
                    {
                        // It is a number
                        alert('В названии должны быть только буквы!');
                        $("input[name='name_city']").val('');
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
      <form id="city_country_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="country_id" value="">
        <input type="hidden" name="country_name" value="">
        <input type="hidden" name="city_id" value="">
        <input type="hidden" name="city_name" value="">        
        <input type="hidden" name="city_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_city" placeholder="Впишите название города" required>
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
                    <h3>Страна {$country_name}</h3>

                    <div class="back_btn_wallet">
                        <a href="/admin/settings.php?type=countries" class="btn btn-default btn-md">Вернуться назад, выбрать другую страну</a>
                    </div>
                    <div class="clearfix"></div>

                    <div class="title_left">
                        <a href="#new_edit_country" class="btn btn-default btn-md new_country" data-toggle="modal" data-country-id="{$country_id}" data-country-name="{$country_name}">Создать новый город</a>
                    </div>
                </div>
               
                <div class="clearfix"></div>
                    <div class="title_right wallet">
                        <h3>Всего городов для страны {$country_name}, загруженных в систему, {$cities_of_country_count} шт.</h3>
                    </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№ п/п</th>
                                        <th>Название города</th>
                                        <th>Действие</th> 
                                        <th>Действие</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                        {foreach from=$all_cities item=$city}
                                            <tr>
                                                {$i = $i + 1}
                                                <th>{$i}</th>
                                                <th>{$city->getName()}</th>
                                                <th class="nmb"><a href="#new_edit_country" class="btn-default btn btn-sm edit_country" data-toggle="modal" data-city-id="{$city->getId()}" data-city-name="{$city->getName()}" data-country-id="{$country_id}" data-country-name="{$country_name}">Редактировать</a></th>
                                                <th class="nmb"><a href="#new_edit_country" class="btn-default btn btn-sm delete_country" data-toggle="modal" data-city-id="{$city->getId()}" data-city-name="{$city->getName()}" data-country-id="{$country_id}" data-country-name="{$country_name}">Удалить</a></th>
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
                                <input type="hidden" class="val_text" value="На данной странице отображаются города страны {$country_name}, загруженные в систему">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}