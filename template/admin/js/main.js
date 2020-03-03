(function ($) {
	$(document).ready(function () {
		
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



		$('.chat-message_foot .twemoji-textarea').on('input', function () {
			$('.chat-message_foot .twemoji-textarea').getNiceScroll().resize();
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

		$('.form-row').on("click",".close-select", function(){
			$(this).next().val('0').trigger("change");
			$(this).fadeOut(200);
		});

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

		$('.add-to-fav').on('click', function(e){
			e.preventDefault();
				$(this).find('.svg_2').toggleClass('filled');
		});
		$(document).on('click', '.multi-accordion li > a', function (event) {
			var $this = $(this), $next = $this.next();
			
			if ($next.length) {
				$next.slideToggle().parent().siblings().children('ul').filter(':visible').slideToggle();
				//$next.slideToggle().parent().siblings().find('ul').filter(':visible').slideToggle();
				event.preventDefault();
			}
		});
		$('#clientstable').dataTable({
			searching: false,
			"sDom": '<"top"i>rt<"table-info"><"bottom"pl <"clearfix">>',
			"sPaginationType": "full_numbers",
			"language": {
				"sProcessing":    ".",
				"sLengthMenu":    "Показать строк: _MENU_",
				"sZeroRecords":   "",
				"sEmptyTable":    "Таблица не заполнена",
				"sInfo":          "",
				"sInfoEmpty":     "",
				"sInfoFiltered":  "",
				"sInfoPostFix":   "",
				"sSearch":        "",
				"sUrl":           "",
				"sInfoThousands":  ",",
				"sLoadingRecords": "",
				"oPaginate": {
						"sFirst":    "Первый",
						"sLast":    "Последний",
						"sNext":    "",
						"sPrevious": ""
				},
				"oAria": {
						"sSortAscending":  "",
						"sSortDescending": ""
				}
				}
			});

		var val_text = $('.val_text').val();

		$(".table-info").html('<i></i> ' + val_text + '');

		$('.upload').click(function(e){
			e.preventDefault();
			$(this).next().click();
		});

		

		$(".slickify").each(function(){
			var id = $(this).attr("id");
			$("#" + id).ddslick();
		});


		$('.open_div').click(function(e){
			e.preventDefault();
			$('.open_div_item').slideToggle(200);
		});

		i_test = 1;
		// ADD PURSE 
		$('.add_top_4').click(function(e){
				e.preventDefault();
				$(this).append('<div class="form-group"><label class="control-label">ТОП-1:</label><input type="text" name="purse_2" class="form-control" value="0,00005555"><div class="config-top-4__purse"><select name="top1_1_' +i_test+  '" id="top1_1_'+i_test+'" class="slickify"><option value="btc" data-imagesrc="../img/btc-icon.png"></option></select></div></div>');
				$('#top1_1_'+i_test+'').ddslick();
				i_test++;
		});   


		$('.emoji').twemojiPicker({
			placeholder:'Введите текст сообщение',
			pickerPosition: 'top',
		});
		$('.home-sidebar_owl').owlCarousel({
			items: 1,
			dots: true
		});


		$('.product_gal').owlCarousel({
				items: 1,
				dots: true,
				nav: true,
				navText: ''
		});

		dotcount = 1;

		$('.product_gal .owl-dot').each(function() {
				$(this).addClass('dotnumber' + dotcount);
				$(this).attr('data-info', dotcount);
				dotcount = dotcount + 1;
			});

			slidecount = 1;

			$('.product_gal .owl-item').not('.cloned').each(function() {
				$(this).addClass('slidenumber' + slidecount);
				slidecount = slidecount + 1;
			});

			$('.product_gal .owl-dot').each(function() {
				grab = $(this).data('info');
				slidegrab = $('.slidenumber' + grab + ' img').attr('src');
				var slide = '<img src="' + slidegrab + '">';
				$(this).append(slide)
			});

			amount = jQuery('.product_gal .owl-dot').length;
			gotowidth = 100 / amount;

			$('.product_gal .owl-dot').css("width", gotowidth + "%");
			newwidth = $('.owl-dot').width();
			$('.product_gal .owl-dot').css("height", newwidth + "px");

		// TOP4

		$('.acc-item_head').click(function(e){
			e.preventDefault();
			$('.acc-item_head').not(this).next().slideUp(200);
			$(this).next().removeClass('active');
			$(this).next().slideToggle(200);
		});

		$('.acc-item_headLvl1').click(function(e){
			e.preventDefault();
			$('.acc-item_headLvl1').not(this).next().slideUp(200);
			$(this).next().slideToggle(200);
		});

		$('.acc-item_headLvl2').click(function(e){
			e.preventDefault();
			$('.acc-item_headLvl2').not(this).next().slideUp(200);
			$(this).next().slideToggle(200);
		});

        $('.map-block_none, .map-block_create').click(function(e){
          e.preventDefault();
          $.magnificPopup.close();
        });

		$('.marketing__create select[name="position"]').on('change', function () {
			var pos = $(this).val();
			var sizeBlock = $('.marketing__create .block-see_size');
			var text = 'Размер объявления: ';
			switch (pos) {
				case '1':
					sizeBlock.text(text + 'высота 35px');
					break;
				case '2':
					sizeBlock.text(text + 'ширина 1280px, высота 280px');
					break;
				case '3':
					sizeBlock.text(text + 'ширина 1280px, высота 280px');
					break;
				case '4':
					sizeBlock.text(text + 'ширина 1280px, высота 280px');
					break;
				case '5':
					sizeBlock.text(text + 'ширина 168px');
					break;
				case '6':
					sizeBlock.text(text + 'ширина 168px');
					break;
				case '7':
					sizeBlock.text(text + 'ширина 196px');
					break;
				case '8':
					sizeBlock.text(text + 'ширина 196px');
					break;
				case '9':
					sizeBlock.text(text + 'ширина 183px');
					break;
				case '10':
					sizeBlock.text(text + 'ширина 183px');
					break;
				default:
					sizeBlock.text(text + 'не определены');
			}
		});

	});
})(jQuery);