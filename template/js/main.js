(function ($) {
	$(document).ready(function () {

		// SLIDER

		$('.owl-slider').owlCarousel({
			items: 2,
			nav: false,
			dots: true,
			center: true,
			autoWidth:true,
			loop: true,
			margin: 10,
			autoplay: true,
			autoplayTimeout: 6500,
			smartSpeed: 1300,
			autoplayHoverPause: true,
		});

		$('.open-forms').magnificPopup({
			type: 'inline',
			preloader: false,
			focus: '#name',
			closeOnBgClick: true,

			// When elemened is focused, some mobile browsers in some cases zoom in
			// It looks not nice, so we disable it:
			callbacks: {
				beforeOpen: function() {
					if($(window).width() < 700) {
						this.st.focus = false;
					} else {
						this.st.focus = '#name';
					}
				}
			}
		});

		$(".chat-theme").niceScroll({
			cursorwidth: "6px",
			cursorcolor: "#cbdbec",
			cursorborderradius: "20px",
			cursoropacitymin: 1,
			railpadding: { top: 0, right: -7, left: 0, bottom: 0 }
		});

		$(".chat-message_body").niceScroll({
			cursorwidth: "6px",
			cursorcolor: "#cbdbec",
			cursorborderradius: "20px",
			cursoropacitymin: 1,
		});

		// TOOPTIPS
		/*var lg = $('.product-info_title').text().length;
		if(lg > 22){
			$('[data-toggle="tooltip"]').tooltip();
		}*/

		$('[data-toggleAll="tooltip"]').tooltip({
			html: true,
			placement: 'right',
			container: 'body'
		});

        $('.val-select').on("click",".close-select", function()
        	{
            	$(this).siblings('.val-select_price').val('');
            	$(this).closest('.val-block').nextAll().each(function() 
            		{
		                $(this).addClass('blocked');
		                $(this).find('.add_obj_select_crypto').prop('disabled', true);
		                $(this).find('.val-select_price').val('');
		                $(this).find('.add_obj_select_crypto').val('0').trigger('change');
		                $(this).find('.add_obj_select_crypto option').each(function() 
			                {
			                	$(this).removeAttr('disabled');
							});
            		});
				//$('.val-select').not(this).find('select option[value="'+value+'"]').removeAttr('disabled');
	            $(this).next().val('0').trigger("change");
        	});

		$(document).mouseup(function (e) {
		    var container = $('[data-toggleAll="tooltip"]');
		    if (container.has(e.target).length === 0){
		        container.tooltip('hide');
		    }
		});

		$('.arch-popup_close').click(function(e){
			e.preventDefault();
			$.magnificPopup.close();
		});

		$('input[name="product_get"]').mousedown(function(e)
		{
			var $self = $(this);
			if( $self.is(':checked') )
			{
					var uncheck = function()
					{
						setTimeout(function(){
							$self.removeAttr('checked');
							$('.lk-p-close_get button.button-yes').attr('disabled','disabled');
							$('.lk-p-close_get button.button-no').attr('disabled','disabled');
						},0);
					};
				var unbind = function()
				{
					$self.unbind('mouseup',up);
				};
				var up = function()
				{
					uncheck();
					unbind();
				};

				$self.bind('mouseup',up);
				$self.one('mouseout', unbind);
			}
		});


		// MAIN SLIDER 
		$('.slider__owl').owlCarousel({
			items: 5,
			center: true,
			nav: true,
			navText: '',
			loop: true,
			margin: 43
		});

		// ADD TO FAV
		/*$('.product-item_fav').click(function(){
			$(this).find('i').toggleClass('filled');
		});

		$('.product-single-info_block .likes').click(function(){
			$(this).find('i').toggleClass('filled');
		});*/

		$('.product-single-gallery_item').magnificPopup({
			delegate: 'a',
			type: 'image',
			tLoading: 'Loading image #%curr%...',
			mainClass: 'mfp-img-mobile',
			callbacks: {
				buildControls: function() {
					if ($('.product-single-gallery_item').length > 1) {
						this.contentContainer.append(this.arrowLeft.add(this.arrowRight));
					}
				}
			},
			gallery: {
				enabled: true,
				navigateByImgClick: true,
				preload: [0,1] 
			},
		});

		// FILTER BUTTONS 
		$('.obj-filter_block span').click(function(){
			$(this).next().slideToggle(300);
			$(this).toggleClass('active');
		});

		$('.obj_head_select').select2({
			minimumResultsForSearch: -1
		});

		$('.lk-myobj_open-update select').select2({
			minimumResultsForSearch: -1
		});

		$('.filter_select').select2();


		$('#filter_val').change(function(){
			if (!$('#filter_val option:selected').data('first')) {
				$("#filter_val option:selected").each(function() {

					if($(this).val() == '0'){
						$('.choice-purse__minmax').remove();
						$('.cs__purse').slideUp(200);
					} else {
						var str = $(this).data('image'),
							str_name = $(this).val();
						$('.cs__purse').html('<div class="choice-purse__minmax" data-icon="'+str+'"><label><img src="'+str+'" alt="" width="45"></label><div class="home-content-filter_check"><input type="text" name="'+str_name+'_min" id="min" placeholder="От" maxlength="8"></div><div class="home-content-filter_check"><input type="text" name="'+str_name+'_max" placeholder="До" maxlength="8"></div><div class="close">X</div></div>').slideDown(200);
					}
				});
			}
		});

		$('.add_obj_select_crypto').on('change', function () 
			{
				$(this).find("option:selected").each(function() 
					{
						let this_image = $(this).data('image');

						console.log(this_image);

						if($(this).val() != '0')
							{					
								$(this).closest('.form-row').find('.select2-selection__rendered').append('<div class="select_image"><img src="'+this_image+'"></div>');
								$(this).parent().parent().find('.val-select_price').fadeIn(200);
							}
					});
			});

		$(".cs__purse").on("keypress", 'input', function (e) {
			if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
				return false;
			}
		});

		$('.cs__purse').on("click",".close", function(e){
			e.preventDefault();
			$(this).parent().remove();
			var ln = $('.choice-purse__minmax').length;
			if(ln == 0){
				$('.cs__purse').slideUp(200);
				$('.choice-purse__minmax').remove();
				$('#filter_val').val('Выберите криптовалюту').trigger('change');
				$('#filter_val').removeAttr('disabled');
			}
		});

		// CATS MENU
		$('.head-item_cats').click(function(e){
			e.preventDefault();
			$('.cat-menu').slideDown(200);
			$('.cat-menu_overlay').fadeIn(200);
			$('html').css({'padding-right': '17px', 'overflow': 'hidden'});
		});

		$('.close-menu, .cat-menu_overlay').click(function(){
			$('.cat-menu').slideUp(200);
			$('.cat-menu_overlay').fadeOut(200);
			$('html').css({'padding-right': '0', 'overflow': 'auto'});
		});

		// PROFILE HEADER
		$('.head-profile_avatar, .head-profile_name').click(function(){
			$('.head-item_profile').toggleClass('active');
			$('.head-profile_menu').slideToggle(200);
		});
		$(document).click(function(e){
			if (!$(e.target).closest(".head-item_profile").length) {
				$('.head-item_profile').removeClass('active');
				$('.head-profile_menu').slideUp(200);
			}
		});

		/*$(document).on('click', function(e) {
			if (!$(e.target).closest(".head-item_profile").length) {
				$('.head-item_profile').toggleClass('active');
				$('.head-profile_menu').slideToggle(200);
			}.product-single-gallery_item
			e.stopPropagation();
		});*/

		// PRODUCT IMAGE SINGLE
		$('.product-single_gallery').owlCarousel({
			items: 1,
			dots: true,
			nav: true,
			navText: '',
			animateOut: 'fadeOut'
		});

		dotcount = 1;

		$('.product-single_gallery .owl-dot').each(function() {
			$(this).addClass('dotnumber' + dotcount);
			$(this).attr('data-info', dotcount);
			dotcount = dotcount + 1;
		});

		slidecount = 1;

		$('.product-single_gallery .owl-item').not('.cloned').each(function() {
			$(this).addClass('slidenumber' + slidecount);
			slidecount = slidecount + 1;
		});

		$('.product-single_gallery .owl-dot').each(function() {
			grab = $(this).data('info');
			slidegrab = $('.slidenumber' + grab + ' img').attr('src');
			var slide = '<img src="' + slidegrab + '">';
			$(this).append(slide)
		});

		amount = jQuery('.product-single_gallery .owl-dot').length;
		gotowidth = 100 / amount;

		$('.product-single_gallery .owl-dot').css("width", gotowidth + "%");
		newwidth = $('.owl-dot').width();
		$('.product-single_gallery .owl-dot').css("height", newwidth + "px");

		// RECENT PRODUCTS
		$('.recently__gallery').owlCarousel({
			dots: false,
			nav: true,
			navText: '',
			margin: 66,
			loop: true,
			responsive: {
				0:{
					items: 1
				},
				767:{
					items: 5
				}
			}
		});

		// CLOSE COOKIE
		$('.close-cookie').click(function(e){
			e.preventDefault();
			$('.cookie').slideUp(200);
		});

		$(".go-top").on("click", function (event) {
			
			var id  = $(this).attr('href').split('#')[1];

			if ($('#'+id).length != 0) {
				event.preventDefault();
				var	top = $('#'+id).offset().top;

				$('body,html').animate({scrollTop: top}, 1500);
			}
		});

		// ADD OBJECT

		$('.filter_select_objects').select2();
		//$('.filter_select_objects').change(function(){});

		/*$('.filter_select_objects').change(function(){
		    if($(this).val() != '0'){
		    	$(this).next().find('.select2-selection__arrow').addClass('close');
		    	$(this).before('<div class="close-select"></div>');	
		    } else {
		    	$(this).next().find('.select2-selection__arrow').removeClass('close');
		    	$(this).prev().remove();
		    }
		});*/


		$('.form-row').on("click",".close-select", function(){
			$(this).next().val('0').trigger("change");
			$(this).fadeOut(200);
		});

		$('select[name="add_obj_method"]').change(function(){
			$('select[name="add_obj_method"] option:selected').each(function() {
				if($(this).val() != '0'){
					$(this).closest('.val-block_close').next().find('.val-select select').removeAttr('disabled');
				} else {
					$(this).closest('.val-block_close').next().find('.val-select select').attr('disabled','disabled');
				}
			});
		});

//		$('.add_obj_select_crypto').on('change', function() 
//			{
//				var lastValue = $(this).data('lastValue');

//				$('.val-select select option[value="'+lastValue+'"]').each(function() 
//					{
//						$(this).removeAttr('disabled');
//					});

//				var value = $(this).val();

//				$('.val-select select option[value="'+value+'"]').each(function() 
//					{
//						$(this).attr('disabled','disabled');
//					});
//				$(this).data('lastValue', value);
//			});


		$('.photos-block input').change(function() {
			var input = $(this)[0];
			if ( input.files && input.files[0] ) {
				if ( input.files[0].type.match('image.*') ) {
					var reader = new FileReader();
					reader.onload = function(e) { $(input).next().next().css({'background':'url('+e.target.result+')'}); }
					reader.readAsDataURL(input.files[0]);
					$(this).parent().next().find('input[type="file"]').removeAttr('disabled');
				} else console.log('');
			} else {}
		});

		$('.type_sd select').change(function(){
			if($(this).val() == '0'){
				$('.map_sd').slideDown(200);
			} else {
				$('.map_sd').slideUp(200);
			}
		});

		$(".val-select_price").on("keypress", function (e) {
			if (e.which != 8 && e.which != 0 && e.which != 46 && (e.which < 48 || e.which > 57)) {
				return false;
			}
		});

		if($('.home-converter').length > 0){
			var sticky = new Waypoint({
				element: $('.home-converter')[0],
				handler: function(direction) {
					$('.go-top').parent().toggleClass('active');
				},
				offset: 80
			});
		}

		/*if($(window).width() > 1600){$topHT = 980;} else {$topHT = 560;}

		if($('.go-top').length > 0){

			$('#footer').waypoint(function(direction) {
				$('.go-top')
					.toggleClass('stuck', direction === 'up')
					.toggleClass('at-bottom', direction === 'down')
				}, {
				offset: function() {
					return $('.go-top').outerHeight() + $topHT
				}
			});
		}*/

		/*if($('.home_advertising').length > 0){
			var stickyHA = new Waypoint.Sticky({
				element: $('.home_advertising')[0],
				offset: 80
			});		

			$('#footer').waypoint(function(direction) {
				$('.home_advertising')
					.toggleClass('stuck', direction === 'up')
					.toggleClass('at-bottom', direction === 'down')
				}, {
				offset: function() {
					return $('.home_advertising').outerHeight() + 200
				}
			});	
		}*/

		// if($('.advertising_pages').length > 0){
		// 	var stickyPA2 = new Waypoint.Sticky({
		// 		element: $('.advertising_pages')[0],
		// 		offset: 80
		// 	});
		//
		// 	$('#footer').waypoint(function(direction) {
		// 		$('.advertising_pages')
		// 			.toggleClass('stuck', direction === 'up')
		// 			.toggleClass('at-bottom', direction === 'down')
		// 		}, {
		// 		offset: function() {
		// 			return $('.advertising_pages').outerHeight() + 100
		// 		}
		// 	});
		// }

		/*

		$('.selectSomething').change(function(){

			$(this).closest('.add_obj_cats').nextAll('.add_obj_cats').find('select').val(0);

			if($(this).val() != '0'){
				$(this).closest('.add_obj_cats').next().removeClass('blocked');
				$(this).closest('.add_obj_cats').next().find('select').removeAttr('disabled');
			} else {
				$(this).closest('.add_obj_cats').nextAll().addClass('blocked');
				$(this).closest('.add_obj_cats').nextAll().find('select').attr('disabled','disabled');
				$(this).closest('.add_obj_cats').nextAll().find('.close-select').trigger('click');
			}		

		});
		 */

		/*if($('.description').length > 0){
			var textarea = document.querySelector('.description textarea');
			textarea.addEventListener('keyup', function(){
				if(this.scrollTop > 0){
					this.style.height = this.scrollHeight + "px";
				} else {
					this.style.height = "157px";
				}
			});
		}*/

		$('.nosearch').select2({
			minimumResultsForSearch: -1
		});

		// POPUPS 
		$('.head-item_buttons').click(function(){
			var this_tab = $(this).data('tab');
			$('.login-popup').find('.tab-pane').removeClass('active in');
			$('.login-popup').find('.nav li').removeClass('active');
			$('.login-popup').find('.nav a.'+this_tab+'').parent().addClass('active');
			$('.login-popup').find('div#'+this_tab+'').addClass('active in');
		});
		$('.open-register').on('click', function () {
			$('.head-item_buttons[data-tab="panel1"]').first().trigger('click');
		});
		// LOGIN



		// LK
		$('.lk-p-close_get input').change(function(){
			$(this).parent().parent().find('button').removeAttr('disabled');
		});

		var lk_purse_id = 2;

		$('.lk-config_purse-add').click(function(e){
			e.preventDefault();
				$(this).before('<div class="lk-config_purse"><select name="config_purse'+lk_purse_id+'" class="filter_select"><option value="0">Выберите криптовалюту</option><option value="BTC" data-image="img/btc.png">Bitcoin (BTC)</option><option value="DASH" data-image="img/dash.png">DASH</option><option value="DOGE" data-image="img/doge.png">Dogecoin (DOGE)</option><option value="ETC" data-image="img/ETC.png">Ethereum Classic (ETC)</option><option value="ETH" data-image="img/ETH.png">Ethereum (ETH)</option><option value="IOTA" data-image="img/IOTA.png">IOTA</option><option value="LTC" data-image="img/ltc.png">Litecoin (LTC)</option><option value="STR" data-image="img/str.png">STR</option><option value="USDT" data-image="img/usdt.png">Tether (USDT)</option><option value="XRP" data-image="img/XRP.png">XRP</option><option value="ZEC" data-image="img/zec.png">Zcash (ZEC)</option></select><input type="text" name="config_purse'+lk_purse_id+'_input"></div>');
				$('select[name="config_purse'+lk_purse_id+'"]').select2();
			lk_purse_id++;
		});

		$('.lk-config_purse select').on('change', function () {
			$( ".lk-config_purse select option:selected" ).each(function() {
				var this_image = $(this).data('image');
				var this_code = $(this).data('code');
				if($(this).val() != '0'){
					$(this).parent().parent().find('.select2-selection__rendered').html('<div class="select_image"><img src="'+this_image+'"></div>');
					$(this).parent().parent().find('input').fadeIn(200);
					$(this).parent().parent().find('.select2-selection__arrow').addClass('close');

				} else {
					$(this).parent().parent().find('input').fadeOut(200);
				}
			});
		});

		$('.lk-config_purse select').change(function(){
			if($(this).val() != '0'){
				$(this).next().find('.select2-selection__arrow').addClass('close');
				$(this).before('<div class="close-select"></div>');
			} else {
				$(this).next().find('.select2-selection__arrow').removeClass('close');
				$(this).prev().remove();
			}
		});

		$('.lk-config_purse').on("click",".close-select", function(){
			$(this).next().val('0').trigger("change");
		});

		$('.val-select select').on('change', function () {
			var selected = $(this).find('option:selected');
			var this_image = selected.data('image');
			var this_code = selected.data('code');

			if(selected.val() != '0'){
				//selected.closest('.val-select').find('.select2-selection__rendered').remove();

				setTimeout(function () {
					selected.closest('.val-select').find('.select2-selection__rendered').empty();
					selected.closest('.val-select').find('.select2-selection__rendered').append('<div class="select_image"><img src="'+this_image+'"></div>');
				}, 100);
				selected.closest('.val-select').find('input').fadeIn(200);
				selected.closest('.val-select').find('.select2-selection__arrow').addClass('close');

				$(this).next().find('.select2-selection__arrow').addClass('close');
				$(this).before('<div class="close-select"></div>');

			} else {

				selected.closest('.val-select').find('input').fadeOut(200);
				selected.closest('.val-select').find('.close-select').remove();

				setTimeout(function () {
					selected.closest('.val-select').find('.select2-selection__arrow').removeClass('close');
					$(this).closest('.val-select').find('.close-select').remove();
				}, 100);
			}
		});
	

		$('.lk-config_owl').owlCarousel({
			items: 3,
			nav: true,
			navText: '',
			dots: false,
			loop: true
		});

		$('.lk-config_avatar-checked img').click(function(){
			var img = $(this).attr('src');
			$('.lk-config_avatar-checked img').not(this).removeClass('active');
			$(this).addClass('active');

			$('.lk-config_avatar-item img').attr('src',img);
			$('.lk-config_avatar-item input').val(img);
			$('input[name="avatar"]').val(img);

			updateForm();
		});

		$('.color-item').click(function(){

			$('.color-item').not(this).removeClass('active');
			$(this).addClass('active');

			var color = $(this).data('color');
			$('input[name="color_result"]').val(color);
			$('input[name="color"]').val(color);
			$('.lk-config_avatar-item').css({'backgroundColor' : ''+color+''});

			updateForm();
		});

		$('input[name="color_result"]').each(function(){
			var color_result = $(this).val();
		});

		$(".basic").spectrum({
			preferredFormat: "hex3",
		    chooseText: "Выбрать",
		    cancelText: "Отменить",
		    color: '#fff',
			move: function(tinycolor) {
				var val = $(this).spectrum('get');
				$('input[name="color_result"]').val(val);
				$('input[name="color"]').val(val);
				$('.lk-config_avatar-item').css({'backgroundColor' : ''+val+''})
			},			
		});

		$('.emoji').twemojiPicker({
			placeholder:'Введите текст сообщения',
			pickerPosition: 'top'
		});

        $('.save').click(function(e){
        	e.preventDefault();
        	document.execCommand('copy');
        });


		var isMobile = false;
		if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
		    || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
		    isMobile = true;
		    $('#footer').addClass('mobile');
		}

		// FIXED HEADER
		$(window).scroll(function(){
			if($(window).scrollTop() > 35){
				$('#header').addClass('fixed');
				$('.cat-menu_overlay').addClass('fixed');
			} else {
				$('#header').removeClass('fixed');
				$('.cat-menu_overlay').removeClass('fixed');
			}
		});


		// VIDEO
		$('.help-content_video-play').click(function(e){
			e.preventDefault();

			var $video = $(this).parent().find('iframe'),
				src = $video.attr('src');


			$(this).find('.icon-play').fadeOut(200);
			$(this).find('.image-play').fadeOut(200);
		 
			$video.attr('src', src + '&autoplay=1');

		});

		// Category switcher
		$('.cat-menu a[data-toggle="tab"]').on('click', function(event) {
			event.preventDefault();
			var currentTab = $(this).attr('href');
			$('.cat-menu .cat-menu_row').removeClass('active');
			$('.cat-menu .cat-menu_row[data-panel="' + currentTab + '"]').addClass('active');
			$(".cat-menu .tab-content").getNiceScroll().resize();
		});

		// Category scrollbar
		$('.cat-menu .tab-content').niceScroll({
			cursorwidth: "6px",
			cursorcolor: "#5ea79c",
			cursorborderradius: "20px",
			cursoropacitymin: 1
		});

		// Spaces ban in cryptowallet input
		$('input[name="config_purse_input"]').on("keydown", function (e) {
			return e.which !== 32;
		});

		updateWallets(true);

		$('select[name="config_purse"]').on('select2:select', function(e) {
		    data = e.params.data;
		    currentWallets = $('.wallets-config').data('current');
		    if (currentWallets != undefined) {
                $('.wallets-config').data('current', currentWallets + '-');
                currentWallets = currentWallets + '-';
                $('.wallets-config').data('current', currentWallets + e.params.data.id);
                currentWallets = currentWallets + e.params.data.id;
            } else {
                $('.wallets-config').data('current', e.params.data.id);
                currentWallets = e.params.data.id;
            }
			updateWallets(false, currentWallets);
		});

		// Category and subcategory display in filter
        $(document).on('change', '.obj-filter_block [name="section"], .obj-filter_block [name="category"]', function (){
            $(this).closest('.form-row').next().children().removeClass('blocked');
        });

		// Prevent image drag
		$('img').attr('draggable', 'false');

		// Close buttons for cat and subcat select
        $('.add-object').find('select[name="category"], select[name="subcategory"]').on('change', function() {
            if ($(this).val() != 'Не выбрано') {
                $(this).next().find('.select2-selection__arrow').addClass('close-cat');
                $(this).after('<div class="close-select-cat"></div>');
            }
            if ($(this).val() == null) {
                $(this).siblings('.select2').find('.select2-selection__arrow').removeClass('close-cat');
                $(this).siblings('.close-select-cat').remove();
                $(this).closest('.form-row').next().addClass('blocked');
            }
        });

		$('select[name="secure_deal"]').on('change', function() 
		{
			$('select[name="add_obj_select_crypto"]').each(function() 
				{
					$(this).val('0').trigger('change');
					$(this).closest('.form-row').next().find('select').prop('disabled', true);
					$(this).closest('.form-row').next().addClass('blocked')
				});

			$('.val-select_price').each(function() 
				{
					$(this).val('');
				});
			//$(this).siblings('select').val(null).trigger('change');
		});

        $('.add_obj_cats').on('click', '.close-select-cat', function() {
            if ($(this).siblings('select').attr('name') == 'category') {
                $(this).closest('.form-row').next().find('select').prop('disabled', true);
                $(this).closest('.form-row').next().find('select').val(null).trigger('change');
            }
            $(this).siblings('select').val(null).trigger('change');
        });

        $('.photos-block input').on('change', function() {
        	if ($(this).val() != '') {
        		$(this).siblings('label').css('opacity', '0');
			} else {
				$(this).siblings('label').css('opacity', '1');
			}
		});

//		$('.lk-p-close_get input[name="product_get"]:checked').each(function() {
//			let val = $(this).val();
			
//			productGetBtn(val);
//		});

        $('input[name="product_get"]').on('change', function() {

        	let val = $(this).val();

        	let data = $(this).data('chat-id');


			$('.lk-p-close_get input[name="product_get"]:checked').each(function() {
				if ($(this).data('chat-id') != data)
					{
						$(this).prop('checked', false);
					}
				
			});

        	productGetBtn_2(val, data);
		});

		

		cityGetFilter($('#filter_country').val());

        $('#filter_country').on('change', function() {
			cityGetFilter($(this).val());
		});

        $('select[name="location_country"]').on('change', function() {
        	let val = $(this).val();
        	if (val != '' && val != 'Выберите страну') {
        		$('.map_sd--city').css('display', 'block');
			} else {
				$('.map_sd--city').css('display', 'none');
			}
		});

		$('select[name="location_city"]').on('change', function() {
			let val = $(this).val();
			if (val != '' && val != 'Выберите город') {
				$('input[name="location_city_new"]').prop('disabled', true);
				$('input[name="location_city_new"]').val('');
			} else {
				$('input[name="location_city_new"]').prop('disabled', false);
			}
		});

		$('input[name="location_city_new"]').on('change', function() {
			let val = $(this).val();
			if (val != '') {
				$('select[name="location_city"]').prop('disabled', true);
				$('select[name="location_city"]').val('');
			} else {
				$('select[name="location_city"]').prop('disabled', false);
			}
		});

	});

	$(window).load(function(){
		$('.create-ad__adv').css({'height': $('.create-ad__body').height()});

		const hgtHomeAdv = $('.obj-body').height();
		const filterHeight = $('.obj-filter').height();
		const advHeight = $('.obj-info').height();

		const maxHeight = Math.max(hgtHomeAdv, filterHeight, advHeight) > 2000 ? Math.max(hgtHomeAdv, filterHeight, advHeight): 2000;

		$('.obj-filter').css({"height":maxHeight});
		$('.obj-info').css({"height":maxHeight});

		const helpNavHeight = $('.help-pages .col-xs-2').height();
		const helpContHeight = $('.help-pages .col-xs-9').height();

		const helpMaxHeight = Math.max(helpNavHeight, helpContHeight);

		$('.help-pages .col-xs-2').css({"height":helpMaxHeight});
		$('.help-pages .col-xs-9').css({"height":helpMaxHeight});

		$('.chat-message_foot .twemoji-textarea').niceScroll({
			cursorwidth: "6px",
			cursorcolor: "#cbdbec",
			cursorborderradius: "20px",
			cursoropacitymin: 1,
			railpadding: { top: 0, right: 1, left: 0, bottom: 0 }
		});

		$('.chat-message_foot .twemoji-textarea').on('input', function () {
			$('.chat-message_foot .twemoji-textarea').getNiceScroll().resize();
		});
	});

})(jQuery);

// Recaptcha callback for report form
$(document).on('readyCaptchaReport', function () {
	$('#report .btn-submit').removeAttr('disabled');
});

// Similar crypto ban in cryptowaller input
function updateWallets(savedWallets, data) {
	if (savedWallets) {
        currentWallets = [];
		$('.wallets-config .wallet').each(function() {
			type = $(this).find('.delete').data('type').toUpperCase();
			currentWallets.push(type);
		});
		$('select[name="config_purse"] option').each(function(index, el) {
			type = $(this).val();
			if (currentWallets.indexOf(type) != -1) {
				$(this).remove();
			}
		});
	} else {
        currentWallets = data.split('-');
		$('.lk-config_purse').each(function() {
		    if ($(this).css('display') == 'none') {
                $(this).find('select[name="config_purse"] option').each(function() {
                   value = $(this).val();
                   if (currentWallets.indexOf(value) != -1) {
                       $(this).remove();
                   }
                });
            }
		});
	}
}

function checkReview() {
	let stars = false;
	$('[name="stars"]').each(function() {
		if ($(this).prop('checked')) {
			stars = true;
		}
	});
	let text = $('[name="message"]').val() != '';
	if (stars) 
		{

	            $('[name="message"]').on('click', function () 
	            {
	                $('.add-review_body .btn-submit').prop('disabled', false);
	                $('[name="message"]').trigger('change');
	            });		
		} 
		else 
		{
	            $('[name="stars"]').on('click', function () 
	            {
	               	$('[name="stars"]').each(function() 
	               	{
						if ($(this).prop('checked')) 
							{
								stars = true;
							}
					});

					if (stars) 
						{

			                $('.add-review_body .btn-submit').prop('disabled', false);
			                $('[name="stars"]').trigger('change');
			            }
	            });
		}
}

function productGetBtn_2(value, data) {

		$('.lk-p-close_get button').each(function() {
			if ($(this).data('chat-id') !== data)
				{
					$(this).removeClass('button-no');
					$(this).removeClass('button-yes');
				}
			else
				{
					if (value == 'Нет') 
						{
							$(this).removeClass('button-yes');
							$(this).addClass('button-no');
						} 

					else
						{
							$(this).removeClass('button-no');
							$(this).addClass('button-yes');
						} 
				}
		});	
}

function cityGetFilter(value) {
	if (value != '' && value != 'Выберите страну') {
		$('.form-row--city').removeClass('blocked');
	} else {
		$('.form-row--city').addClass('blocked');
	}
}