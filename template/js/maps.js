$(function () {
    let maps_i = 0;

    function initAllMaps(){
        $('.map_init').each(function () {

            let lat = parseFloat($(this).data('lat'));
            let lng = parseFloat($(this).data('lng'));
            let zoom = ($(this).data('zoom') !== undefined) ? parseInt($(this).data('zoom')) : 13;
            let marker = ($(this).data('marker') !== undefined && $(this).data('marker') === true);
            let geolocation = ($(this).data('geolocation') !== undefined && $(this).data('geolocation') === true);
            let easy_search = ($(this).data('easy_search') !== undefined && $(this).data('easy_search') === true);

            let custom_search = ($(this).data('custom_search') !== undefined && $(this).data('custom_search') === true);
            let coords_target = ($(this).data('coords_target') !== undefined) ? $($(this).data('coords_target')) : false;

            if (lat !== undefined && lng !== undefined) {

                let map = null;
                let search_object = null;
                let geolocation_object = null;

                let id = 'map_block_'+maps_i;
                $(this).attr('id', id);

                map = new ymaps.Map(id, {
                    center: [lat, lng],
                    zoom: zoom,
                    controls: []
                });

                if (custom_search) {
                    search_object = new ymaps.control.SearchControl({
                        options: {
                            noPlacemark: true,
                        }
                    });
                    map.controls.add(search_object);

                    search_object.events.add('resultselect', function (e) {
                        let index = e.get('index');
                        search_object.getResult(index)
                            .then(function (res) {

                                let mark = new ymaps.Placemark(res.geometry._coordinates, {
                                    balloonContent: res.properties._data.balloonContent
                                }, {
                                    preset: 'islands#circleDotIcon',
                                    iconColor: '#16344C'
                                });

                                coords_target.each(function () {

                                    if ($(this).is('input')) {
                                        if (easy_search) {
                                            $(this).attr('value', res.properties._data.text);
                                        } else {
                                            $(this).attr('value', JSON.stringify(res.properties._data.metaDataProperty.GeocoderMetaData.Address.Components));
                                        }
                                    } else{
                                        if (!$(this).is('input')){
                                            $(this).text(res.properties._data.text);
                                        }
                                    }
                                });

                                map.geoObjects.add(mark);
                            })
                    }).add('submit', function () {
                        map.geoObjects.removeAll();
                    });

                }

                if (geolocation) {
                    geolocation_object = ymaps.geolocation;

                    geolocation_object.get({
                        provider: 'yandex',
                        mapStateAutoApply: true
                    }).then(function (result) {
                        let coords = result.geoObjects.get(0).geometry._coordinates;
                        map.setCenter(coords);
                    });
                }

                maps_i++;
            }
        });
    }

});

function initGoogleMaps() {
    $('.map_init').each(function () {
        let map;

        let lat = parseFloat($(this).data('lat'));
        let lng = parseFloat($(this).data('lng'));
        let zoom = ($(this).data('zoom') !== undefined) ? parseInt($(this).data('zoom')) : 10;

        let marker = ($(this).data('marker') !== undefined) ? $(this).data('marker').split(',') : undefined;
        let geolocation = ($(this).data('geolocation') !== undefined && $(this).data('geolocation') === true);
        let easySearch = ($(this).data('easy_search') !== undefined && $(this).data('easy_search') === true);

        let customSearch = ($(this).data('custom_search') !== undefined && $(this).data('custom_search') === true);
        let coordsTarget = ($(this).data('coords_target') !== undefined) ? $($(this).data('coords_target')) : false;

        map = new google.maps.Map(document.getElementById('google_map'), {
            center: {lat: lat, lng: lng},
            zoom: zoom
        });

        if (geolocation) {
            console.log(navigator.geolocation);
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    let pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    map.setCenter(pos);
                }, function() {
                    console.log('error on get geolocation of user');
                });
            }
        }

        if (marker !== undefined) {
            let coords = {lat: parseFloat(marker[0]), lng: parseFloat(marker[1])};
            new google.maps.Marker({
                position: coords,
                map: map,
            });
            map.setCenter(coords);
        }

        if (customSearch) {
            let input = document.getElementById('google-maps-search');
            let searchBox = new google.maps.places.SearchBox(input);
            map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

            map.addListener('bounds_changed', function() {
                searchBox.setBounds(map.getBounds());
            });

            let markers = [];
            searchBox.addListener('places_changed', function() {
                let places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                // Clear out the old markers.
                markers.forEach(function(marker) {
                    marker.setMap(null);
                });
                markers = [];

                // For each place, get the icon, name and location.
                let bounds = new google.maps.LatLngBounds();
                places.forEach(function(place) {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }
                    var icon = {
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(25, 25)
                    };

                    // Create a marker for each place.
                    markers.push(new google.maps.Marker({
                        map: map,
                        icon: icon,
                        title: place.name,
                        position: place.geometry.location
                    }));

                    if (place.geometry.viewport) {
                        // Only geocodes have viewport.
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }
                });
                map.fitBounds(bounds);
            });
        }

    });
}