</div>
<div id="footer">
	<div class="container">
		<div class="row">
			<div class="col-xs-3">
				<ul>
					<li><a href="/pages.php?page=about_us">О нас</a></li>
					<li><a href="#">Безопасная сделка</a></li>
					<li><a href="/pages.php?page=help">Помощь</a></li>
					<li><a href="#">Взаимодействие пользователей</a></li>
				</ul>
				<div class="foot-store">
					<a href="#" class="disabled">
						<img src="{$template}/img/appstore-icon.png" alt="">
					</a>
					<a href="#" class="disabled">
						<img src="{$template}/img/g-play-icon.png" alt="">
					</a>
				</div>
			</div>
			<div class="col-xs-5 text-center" style="padding-left: 0;padding-right: 0;">
				<img src="{$template}/img/logo-01.svg" alt="" class="foot-logo">
				<div class="foot-social">
					<a href="#"><img src="{$template}/img/telegram.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/VK.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/reddit.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/FB.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/YOUTUBE.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/TWITTER.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/INSTAGRAM.png" alt="" width="40"></a>
					<a href="#"><img src="{$template}/img/btc.png" alt="" width="40"></a>
				</div>
		    	<div class="foot-copyright">&copy; 2019 Za Crypto Ltd. All Rights Reserved.</div>
			</div>
			<div class="col-xs-3 text-right">
				<ul>
					<li><a href="#">Связаться с нами</a></li>
					<li><a href="/pages.php?page=cookie_policy">Правила сервиса</a></li>
					<li><a href="/pages.php?page=terms_of_use">Условия пользования</a></li>
					<li><a href="#">Реклама и ТОП объявлений</a></li>
				</ul>
				<div class="foot-copy text-right">Разработано в <a href="#">Brain Design</a></div>
			</div>
		</div>
	</div>
</div>

{if empty($_COOKIE['cookie'])}
	<div class="cookie text-center">
		ZaCrypto uses cookies to give you best browsing experience. By using ZaCrypto, you agree to our<br> <a href="#">Terms of Use</a>,
		<a href="/pages.php?page=cookie_policy">Cookie</a> and <a href="/pages.php?page=terms_of_use">Privacy Policy</a><br>
		<a href="#" class="close-cookie" onclick="acceptCookie()">ОК</a>
	</div>
	<script>
		function acceptCookie() {
			let date = new Date(new Date().getTime() + 30 * 24 * 60 * 60 * 1000);
			document.cookie = "cookie=accepted; path=/; expires=" + date.toUTCString();
		}
	</script>
{/if}

<div id="login" class="mfp-hide login-popup">
	<div class="login-popup_block">
		<div class="login-popup_block-logo">
			<img src="{$template}/img/head-logo.png" alt="">
		</div>
	</div>
	<div class="login-popup_block">
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#panel1" class="panel1">Регистрация</a></li>
			<li><a data-toggle="tab" href="#panel2" class="panel2">Вход</a></li>
		</ul>
		<div class="tab-content">
			<div id="panel1" class="tab-pane fade in active">
				<form action="/ajax/users/register.php" method="post" class="register js_register after-screen">
					<div class="form-row">
						<label>Адрес E-Mail
							<span data-toggleAll="tooltip" data-trigger="click" title="<br> <p>По-умолчанию не публикуется.</p>
						<br> <p>Будет использоваться при авторизации и для получения уведомлений.</p>">
								<i class="form-info"></i>
							</span>
						</label>
						<input type="text" name="email" placeholder="Введите адрес E-Mail" required>
					</div>
					<div class="form-row">
						<label>Логин
							<span data-toggleAll="tooltip" data-trigger="click" title="Правило создания логина:<br> <p>• Только латинские буквы и цифры</p>
<br><p>• Без пробелов</po>
<br><p>• Не должен быть меньше 3 и не
больше 10 знаков</p>">
								<i class="form-info"></i>
							</span>
						</label>
						<input type="text" name="login" placeholder="Придумайте логин" required>
					</div>
					<div class="form-row">
						<label>Пароль
							<span data-toggleAll="tooltip" data-trigger="click" title="Для защиты Вашего аккаунта пароль
должен содержать: <p>• Не менее 7 знаков</p><p>• Цифры и буквы латинского алфавита</p><p>• Знаки пунктуации !»№%:,.;()</p><p>• Строчные буквы</p><p>• Прописные буквы</p>">
								<i class="form-info"></i>
							</span>
						</label>
						<input type="password" name="password" placeholder="Введите пароль" required>
					</div>
					<div class="form-row form-row_last">
						<label class="extra-margin">Повторить пароль</label>
						<input type="password" name="password_2" placeholder="Повторите пароль" required>
					</div>
					<div class="login-capcha">
						<div class="recaptcha-container" data-callback="readyCaptchaRegister" id="recaptcha-login"></div>
					</div>
					<button class="btn-submit" type="submit" disabled>Зарегистрироваться</button>
					<div class="form-sogl">
						<input type="checkbox" name="form_sogl" checked value="1">
						<label>Я прочитал и согласен с <a href="#">Условиями</a> и <a href="#">Правилами пользования</a> и подтвержаю, что понимаю <a href="#">Политику конфиденциальности</a>.</label>
					</div>
				</form>
				<div class="register_submit">
					На указанный E-Mail было<br> отправлено письмо для<br> активации Вашего аккаунта
				</div>
			</div>
			<div id="panel2" class="tab-pane fade">
				<form action="/ajax/users/login.php" method="post" class="login js_login">
					<div class="form-row">
						<label>Адрес E-Mail</label>
						<input type="text" name="login" placeholder="Введите адрес E-Mail" required>
					</div>
					<div class="form-row form-row_last">
						<label>Пароль</label>
						<input type="password" name="password" placeholder="Введите пароль" required>
					</div>
					<div class="text-right login-fog_pass">
						<a href="#foggoten" class="open-forms">Забыли пароль?</a>
					</div>
					<div class="login-capcha">
						<div class="recaptcha-container" data-callback="readyCaptchaLogin"></div>
					</div>
					<button class="btn-submit" type="submit" disabled>Войти</button>
				</form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
</div>

<script>
$(function()
{
	let $permissions = $("input[name='permissions']").val();

	if ($permissions == 1)
		{
			$('#admin-or-home').modal({
			     keyboard: true,
			     backdrop: 'static',
			   });

            $.ajax({
                url: '/ajax/users/session_zero.php',
                type: 'POST',
                dataType: 'JSON'
            })
                .done(function(data) 
                {
                    console.log("success");
                })
                .fail(function() 
                {
                    console.log("error");
                })
                .always(function() 
                {
                    console.log("complete");
                }); 			
		}
});	
</script>

<div id="admin-or-home" class="modal fade">
  <div class="modal-dialog modal-md">
    <div class="modal-content" style="margin-top: 20%">
      <!-- Заголовок модального окна -->
      <div class="modal-header">
        <h3 class="modal-title" style="text-align: center;">ВХОД</h3>
      </div>
      <!-- Основное содержимое модального окна -->
      <form id="advert_top" method="POST" class="form-horizontal form-label-left">
        <input type="hidden" name="function" value="">
        <input type="hidden" name="permissions" value="{if isset($_COOKIE['session']) AND isset($_COOKIE['permissions']) AND $_COOKIE['permissions'] <= 5}{$_COOKIE['session']}{/if}">
          <div class="modal-body">
          	<div style="text-align: center; padding: 20px; font-size: 20px; font-weight: 900;  background: gainsboro; margin-bottom: 30px;"><a href="/admin">back-office</a></div>
				<div class="clearfix"></div>
          	<div style="text-align: center; padding: 20px; font-size: 20px; font-weight: 900; background: gainsboro; margin-top: 30px;"><a href="/">front-page</a></div>
          </div>
          <!-- Футер модального окна -->
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
{*            <input name="action" value="Принять заявку" type="submit" class="btn btn-primary"> *}
          </div>
      </form>
    </div>
  </div>
</div>

<div id="foggoten" class="mfp-hide login-popup">
	<div class="login-popup_block">
		<div class="login-popup_block-logo">
			<img src="{$template}/img/head-logo.png" alt="">
		</div>
	</div>
	<div class="login-popup_block">
		<a href="#login" class="close open-forms">&#8592;</a>
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#panel1" class="panel1">Восстановить пароль</a></li>
		</ul>
		<div class="tab-content">
			<form method="post" class="foggoten js_foggoten after-screen" action="/ajax/users/reset_password.php">
				<div class="form-row">
					<label>Адрес E-Mail</label>
					<input type="text" name="email" placeholder="Введите адрес E-Mail" required>
				</div>
				<div class="form-row">
					<label>Логин</label>
					<input type="text" name="login" placeholder="Введите логин">
				</div>
				<div class="login-capcha">
					<div class="recaptcha-container" data-callback="readyCaptchaForgotten"></div>
				</div>
				<button class="btn-submit" type="submit" disabled>Восстановить</button>
			</form>
			<div class="foggoten_submit">
				На указанный E-Mail<br> отправлена инструкция для<br> сброса пароля
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
</div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script src="{$template}/js/moment-with-locales.min.js"></script>
<script src="{$template}/js/moment-timezone-with-data-10-year-range.min.js"></script>
<script src="{$template}/js/helpers/time-converter.js"></script>

<script src="{$template}/js/jquery.nicescroll.min.js"></script>
<script src="{$template}/js/bootstrap.min.js"></script>
<script src="{$template}/js/select2.min.js"></script>
<script src="{$template}/js/owl.carousel.min.js"></script>
<script src="{$template}/js/jquery.waterwheelCarousel.min.js"></script>
<script src="{$template}/js/jquery.waypoints.min.js"></script>
<script src="{$template}/js/jquery.magnific-popup.min.js"></script>
<script src="{$template}/js/spectrum.js"></script>
<script src="{$template}/js/twemoji-picker.js"></script>
<script src="{$template}/js/sticky.min.js"></script>
<script src="{$template}/js/salvattore.min.js"></script>

<script src="{$template}/js/validate_forms.js"></script>
<script src="{$template}/js/main.js"></script>
<script src="{$template}/js/functions/login.js"></script>
<script src="https://www.google.com/recaptcha/api.js?hl=ru&onload=recaptchaLoaded&render=explicit"></script>
<script src="{$template}/js/functions/ajax_forms.js"></script>
<script src="{$template}/js/functions/add_to_favorites.js"></script>

</body>
</html>