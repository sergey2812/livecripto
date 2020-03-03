<script src="{$template}/js/maps.js"></script>
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>

<div class="modal fade" id="map_modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content popup_map">
            <div class="map_init" data-lat="0" data-lng="0" data-marker="true" data-geolocation="true" data-coords_target=".map_target" data-custom_search="true" data-easy_search="false" style="height:420px"></div>
            <div class="text-center">
                <h3 class="map_target"></h3>
            </div>
            <div class="map_blocks">
                <div class="row">
                    <div class="col-sm-6">
                        <form method="POST">
                            <input type="hidden" name="function" value="new">
                            <input type="hidden" name="type" value="{$type}">
                            <input type="hidden" class="map_target" name="data" value="">

                            <input type="hidden" name="country" value="{$country}">
                            <input type="hidden" name="region" value="{$region}">

                            <button type="submit" class="map-block_create">Применить</button>
                        </form>
                    </div>
                    <div class="col-sm-6">
                        <a href="#" class="map-block_none" data-dismiss="modal">Отмена</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>