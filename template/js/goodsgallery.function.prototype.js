;(function() {
	'use strict';

	var Gallery = function(id) {
		// объект галерея
		var gallery	= document.getElementById(id);
		// коллекция маленьких картинок (тумб)
		this.thumbs = gallery.querySelectorAll('.thumbs img');
		// объект, в который будем выводить большую картинку
		this.image = gallery.querySelector('.photo-box img');
		// объект (родительский элемент), содержащий кнопки навигации
		this.control = gallery.querySelector('.control-box');
		// кол-во фотографий в галереи
		this.count = this.thumbs.length;
		// индекс отображаемой фотографии, при инициализации скрипта
		// он по умолчанию равен 0
		this.current = 0;
		// регистрируем обработчики событий на странице с фотогалерей 
		this.registerEvents();
	};

	// записшем конструктор в свойство 'window.Gallery', чтобы обеспечить
	// доступ к нему снаружи анонимной функции
	window.Gallery = Gallery;

	// для сокращения записи, создадим переменную, которая будет ссылаться
	// на прототип 'Gallery'
	var fn = Gallery.prototype;

	// регистрация обработчиков событий
	fn.registerEvents = function() {
		// клик по контейнеру '.control-box', в котором находятся кнопки 
		// управления
		this.control.addEventListener('click', this.buttonControl.bind(this));
		// клик по большой картинке
		this.image.addEventListener('click', this.imageControl.bind(this));
		// управление стрелками 'влево' и 'вправо'
		document.addEventListener('keydown', this.keyControl.bind(this));

		// чтобы не потерять контекст, при переборе коллекции тумб,
		// сохраняем его в переменной
		var self = this;
		// перебираем коллекцию тумб (маленьких картинок)
		// n - это индекс элемента 'thumb' в коллекции 'thumbs'
		[].forEach.call(this.thumbs, function(thumb, n) {
			// вешаем на элемент обработчик события
			thumb.addEventListener('click', self.showPhoto.bind(self, n));
		});
	};

	fn.buttonControl = function(e) {
		// если click был сделан вне кнопок, прекращаем работу функции
		if (e.target.tagName != 'BUTTON') return;
		// чтобы не потерять контекст, при переборе коллекции тумб,
		// сохраняем его в переменной
		var self = this,
			ctrl = e.target.getAttribute('data-target'),
			// создаём литеральный объект callShowPhoto
			// каждому свойству литерального объекта соотвествует анонимная функция
			// в которой вызывается функция showPhoto, с аргументом, зависящим от
			// свойства литерального объекта
			callShowPhoto = {
				'first': function() {
					self.showPhoto(0);
				},
				'last': function() {
					self.showPhoto(self.count - 1);
				},
				'prev': function() {
					self.showPhoto((self.count + self.current - 1) % self.count);
				},
				'next': function() {
					self.showPhoto((self.current + 1) % self.count);
				}
			};
		// вызов анонимной функции литерального объекта в зависимости
		// от названия функционала кнопки
		callShowPhoto[ctrl]();
	};

	fn.imageControl = function(e) {
		this.showPhoto((this.current + 1) % this.count);
	};

	fn.wheelControl = function(e) {
		// отключаем поведение по умолчанию - скролл страницы
		e.preventDefault();
		if (e.deltaY > 0) {
			// показываем следующее фото
			this.showPhoto((this.current + 1) % this.count);
		} else {
			// показываем предыдущее фото
			this.showPhoto((this.count + this.current - 1) % this.count);
		}
	};

	fn.keyControl = function(e) {
		// отключаем действия по умолчанию
		e.preventDefault();
		switch(e.which) {
			// клавишиа 'стрелочка влево'
			case 37:
				this.showPhoto((this.count + this.current - 1) % this.count);
				break;
			// клавиша 'стрелочка вправо'
			case 39:
				this.showPhoto((this.current + 1) % this.count);
				break;
		}

	};

	fn.showPhoto = function(index) {
		// используя полученный в качестве аргумента индекс
		// получаем 'src' тумбы в коллекции
		var src = this.thumbs[index].getAttribute('src');
		// полученный 'src' прописываем у большой картинки, предварительно
		// изменив путь (название папки)
		this.image.setAttribute('src', src.replace('thumbnails', 'photos'));
		// устанавливаем текущий индекс равным индексу тумбы в коллекции
		this.current = index;
	};

})();