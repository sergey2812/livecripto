<script src="{$template}/js/maps.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBbL738BqCLYNlB1e8z9tT7RJA5SbmLv24&callback=initGoogleMaps&libraries=places" async defer></script>

<link rel="stylesheet" href="{$template}/css/map.css">

<div id="map" class="mfp-hide map-popup popup_map">
    <input id="google-maps-search" class="controls" type="text" placeholder="Искать">
    <div class="map_init" id="google_map" data-lat="{if !empty($lat)}{$lat}{else}0{/if}" data-lng="{if !empty($lat)}{$lng}{else}0{/if}" data-geolocation="true" data-coords_target=".map_target" data-custom_search="true" data-easy_search="{if !empty($easy_search)}{$easy_search}{else}false{/if}" {if !empty($marker)}data-marker="{$marker}"{/if} style="height:420px"></div>
    <div class="map_blocks">
        <div class="row map_blocks_rad">
            <div class="col-sm-12">
                <p>{t}Выберите местоположение, где хотите найти товар{/t}</p>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <a href="#" class="map-block_create">{t}Применить{/t}</a>
            </div>
            <div class="col-sm-6">
                <a href="#" class="map-block_none">{t}Отмена{/t}</a>
            </div>
        </div>
    </div>
</div>