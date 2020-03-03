{include file='elements/main/header.tpl'}

{include file='elements/main/breadcrubms.tpl'}
<div class="lk">
    <div class="container">
        <div class="row lk-row">
            {include file='dashboard/elements/sidebar.tpl'}
            <div class="col-xs-9 lk-col-9">
                {include file='dashboard/elements/header_menu.tpl'}
                <div class="lk-config">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="lk-config_login-block">
                                <div class="form-row">
                                    <label>Логин</label>
                                    <input type="text" value="{$user->getLogin()}" disabled>
                                </div>
                                <div class="form-row">
                                    <label>E-mail</label>
                                    <input type="text" value="{$user->getEmail()}" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <form class="lk-config_avatar">
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="lk-config_avatar-title">Аватар</div>
                                        <div class="lk-config_avatar-item" style="background-color: #{$user->getColor()};">
                                            <img src="/files/{$user->getAvatar()}" alt="">
                                            <input type="hidden" name="image_src" data-to="avatar" value="{$user->getAvatar()}">
                                        </div>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="colors">
                                            <div class="color-item active" data-color="#ffffff" style="background: #ffffff;"></div>
                                            <div class="color-item" data-color="#d0d0d0" style="background: #d0d0d0;"></div>
                                            <div class="color-item" data-color="#888888" style="background: #888888;"></div>
                                            <div class="color-item" data-color="#2d2d2d" style="background: #2d2d2d;"></div>
                                            <div class="color-item" data-color="#000000" style="background: #000000;"></div>
                                            <div class="color-item" data-color="#c94d3f" style="background: #c94d3f;"></div>
                                            <div class="color-item" data-color="#cd7d2d" style="background: #cd7d2d;"></div>
                                            <div class="color-item" data-color="#e4c232" style="background: #e4c232;"></div>
                                            <div class="color-item" data-color="#79cb76" style="background: #79cb76;"></div>
                                            <div class="color-item" data-color="#6cbb9c" style="background: #6cbb9c;"></div>
                                            <div class="color-item" data-color="#8ecdf6" style="background: #8ecdf6;"></div>
                                            <div class="color-item" data-color="#5f96d7" style="background: #5f96d7;"></div>
                                            <div class="color-item" data-color="#2d3a67" style="background: #2d3a67;"></div>
                                            <div class="color-item" data-color="#8b59b2" style="background: #8b59b2;"></div>
                                            <div class="color-item" data-color="#db7380" style="background: #db7380;"></div>
                                        </div>
                                        <div class="color-result">
                                            <div class="row">
                                                <div class="col-xs-5">
                        <input type="text" name="color_result" value="#{$user->getColor()}" data-to="color">
                        
                                                </div>
                                                <div class="col-xs-7">
                                                    <input type="text" class="basic" style="display: none;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="lk-config">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="lk-config_login-block lk-config_email-block">
                                <div class="form-row">
                                    <label>Изменить E-Mail
                                    <span data-toggleAll="tooltip" data-trigger="click" title="<br> <p>• По-умолчанию не публикуется</p>
						<br> <p>• Будет использоваться при авторизации и для получения уведомлений</p>">
								<i class="form-info"></i>
							</span>    
                                    </label>
                                    <input type="text" name="login" data-to="email" value="{$user->getEmail()}">
                                </div>
                                <div class="form-row">
                                    <label>Изменить пароль
                                        <span data-toggleAll="tooltip" data-trigger="click" title="Для защиты Вашего аккаунта пароль
должен содержать: <p>• Не менее 7 знаков</p><p>• Цифры и буквы латинского алфавита</p><p>• Знаки пунктуации !»№%:,.;()</p><p>• Строчные буквы</p><p>• Прописные буквы</p>">
								<i class="form-info"></i>
							</span>
                                    </label>
                                    <input type="password" name="password1" data-to="password" value="">
                                </div>
                                <div class="form-row">
                                    <label>Повторить пароль</label>
                                    <input type="password" name="password2" data-to="password2" value="">
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="lk-config_avatar-checked">
                                <div class="owl-carousel lk-config_owl">
                                    {for $i=1 to 12}
                                        <div class="lk-config_owl-item">
                                            <div class="form-row">
                                                <img src="/files/avatars/{$i}.png">
                                            </div>
                                            <div class="form-row">
                                                <img src="/files/avatars/{24 - $i + 1}.png">
                                            </div>
                                        </div>
                                    {/for}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <form id="update-confirm" action="/ajax/users/update.php" method="post">
                    <input type="hidden" name="email">
                    <input type="hidden" name="password">
                    <input type="hidden" name="password2">
                    <input type="hidden" name="avatar">
                    <input type="hidden" name="color">
                    <div class="lk-config_pass disabled">
                        <div class="row">
                            <div class="col-xs-8">
                                <label>Введите текущий пароль для сохранения изменений</label>
                                <input type="password" name="change_pass" required>
                            </div>
                            <div class="col-xs-4 text-right">
                                <button>Сохранить</button>
                            </div>
                        </div>
                    </div>
                </form>
                <script>
                    $(function() {
                        let defaultAvatar = $('.lk-config_avatar-item img').attr('src');
                        let defaultAvatarColor = $('input[name="color_result"]').val();
                        
                        setInterval(function () {
                            if (defaultAvatar !== $('.lk-config_avatar-item img').attr('src')) console.log('1');
                        }, 1000);

                        $('.lk-config_avatar-checked img').on('click', function () {
                            let img = $(this).attr('src').replace('/files/', '');
                            $('input[name="avatar"]').val(img);
                        });
                        $('input:not([type="hidden"])').on('change', function () {
                            let to = $(this).data('to');
                            $('input[name="'+to+'"]').val($(this).val());
                            updateForm();
                        });
                        $('input[name="change_pass"]').on('keyup', function () {
                            updateForm();
                        })
                    });

                    function updateForm() {
                        let form = $('#update-confirm');
                        let changes = false;
                        let password = false;
                        form.find('input').each(function () {
                            if ($(this).val() !== '') changes = true;
                        });

                        if (form.find('input[name="change_pass"]').val().length > 6) password = true;

                        if (changes) {
                            let i = form.find('.lk-config_pass');
                            i.removeClass('disabled');
                            if (password) {
                                i.removeClass('error');
                            } else{
                                i.addClass('error');
                            }
                        } else{
                            i.addClass('disabled');
                        }
                    }
                </script>
            </div>
        </div>
    </div>
</div>

{include file='elements/main/footer.tpl'}