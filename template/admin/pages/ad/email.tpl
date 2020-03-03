{include file='admin/elements/header.tpl'}

<script>
$(function()
{
    var country_status = $("input[name='mailing_status']").val();

    if (country_status == 2)
        {
            alert("Рассылка удалена из системы!");
            $("input[name='mailing_status']").val('');
        }
    if (country_status == 1)
        {
            alert("Удаление не получилось почему-то!");
            $("input[name='mailing_status']").val('');
        }
                    
    $('#new_edit_mailing').on('shown.bs.modal', function () {
      //#myInput - id элемента, которому необходимо установить фокус
      $("input[name='name_mailing']").focus();
    })           

    $(".btn-default.btn.btn-sm.delete_mailing").on('click', function () 
        { 
            let mailing_id = $(this).data('mailing-id');
            let mailing_name = $(this).data('mailing-name');
            let admin_id = $(this).data('admin-id');
            $(".modal-header h4").html('Удаление рассылки из системы');
            $("input[name='name_mailing']").val(mailing_name);
            $("input[name='mailing_name']").val(mailing_name);
            $("input[name='mailing_id']").val(mailing_id);
            $("input[name='admin_id']").val(admin_id);
            $(".modal-footer #del_mailing").html('Удалить');
            $("#mailing_run input[name='function']").val("del_mailing");
        });  

});
</script>

<div id="new_edit_mailing" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title country"></h4>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="mailing_run" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="mailing_id" value="">
        <input type="hidden" name="mailing_name" value="">
        <input type="hidden" name="admin_id" value="">
        <input type="hidden" name="mailing_status" value="{if isset($status)}{$status}{/if}">
          <div class="modal-body">
                <div class="form-group">
                    <div class="marketing-create__right">
                        <input type="text" class="form-control" value="" name="name_mailing" readonly>
                    </div>
                </div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
            <button id="del_mailing" type="submit" class="btn btn-primary">Сохранить изменения</button>
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
            <div class="">
                {include file='admin/elements/breadcrumbs.tpl'}
                <div class="page-title">
                    <h3>Рассылка</h3>
                    <div class="title_left">
                        <a href="/admin/ad.php?type=create-email&admin_id={$user->getId()}" class="btn btn-default btn-md">Создать</a>
                    </div>

                    <div class="title_right">
                        <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Поиск по имени или почте">
                                <span class="input-group-btn">
                      <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                    </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="x_panel">
                            <div class="x_content table-nstr">
                                <table id="clientstable" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>№<br>п/п</th>
                                        <th>Название рассылки</th>
                                        <th>Способ отправки</th>
                                        <th>Дата создания</th>
                                        <th>Дата рассылки</th>
                                        <th>Автор рассылки</th>
                                        <th>Заголовок письма</th>
                                        <th>Статус</th>
                                        <th>Действия</th>
                                        <th>Действия</th>
                                    </tr>
                                    </thead>
                                    {$i = 0}
                                    <tbody>
                                    {if isset($all_mailings) AND $all_mailings != array()}
                                    {foreach from=$all_mailings item=$mailing}
                                        <tr>
                                            {$i = $i + 1}
                                            <th>{$i}</th>
                                            <th>{$mailing->getNameMailing()}</th>
                                            <th class="nmb">
                                                {if $mailing->getMethod() == 1}
                                                    Почта
                                                {elseif $mailing->getMethod() == 2}
                                                    Всем
                                                {elseif $mailing->getMethod() == 3}
                                                    Приложения
                                                {/if}
                                            </th>
                                            <th class="nmb">{$mailing->getCreationDate()}</th>
                                            <th class="nmb">{$mailing->getMailingDate()}</th>
                                            <th class="nmb">{if $mailing->getAdmin() > 0}{$Users->Get($mailing->getAdmin())->getLogin()}{/if}</th>
                                            <th>{$mailing->getSubject()}</th>
                                            <th class="nmb">
                                                {if $mailing->getStatus() == 1}
                                                    В очереди
                                                {elseif $mailing->getStatus() == 2}
                                                    Опубликовано
                                                {elseif $mailing->getStatus() == 3}
                                                    В архиве
                                                {/if}
                                            </th>
                                            <th><a href="/admin/ad.php?type=edit-email&id={$mailing->getId()}&admin_id={$user->getId()}">Редактировать</a></th>
                                            <th class="nmb"><a href="#new_edit_mailing" class="btn-default btn btn-sm delete_mailing" data-toggle="modal" data-mailing-id="{$mailing->getId()}" data-mailing-name="{$mailing->getSubject()}" data-admin-id="{$user->getId()}">Удалить</a></th>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    {/foreach}
                                    {else}
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    {/if}
                                    </tbody>
                                </table>
                                <input type="hidden" class="val_text" value="В данном разделе в таблице отображаются все созданные рассылки. ">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

{include file='admin/elements/footer.tpl'}