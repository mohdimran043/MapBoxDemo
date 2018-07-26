<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContextMenu.aspx.cs" Inherits="MapBoxDemoPages.ContextMenu" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src="Scripts/jquery-3.3.1.js"></script>
    <link href="Plugin/ContextMenu/jquery.contextMenu.css" rel="stylesheet" />
    <script src="Plugin/ContextMenu/jquery.ui.position.js"></script>
    <script src="Plugin/ContextMenu/jquery.contextMenu.js"></script>
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />
    <script src="/Scripts/MapSource.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        #map {
            position: absolute;
            top: 0;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>

    <div id='map' class="map-menu"></div>
    <script>

        $(function () {

            $.contextMenu({
                selector: '.marker-context-menu',
                callback: function (key, options) {
                    var m = "clicked: " + key;
                    window.console && console.log(m) || alert(m);
                },
                items: {
                    "edit": { name: "Edit car", icon: "edit" },
                    "cut": { name: "Cut car", icon: "cut" },
                    copy: { name: "Copy car", icon: "copy" },
                    "paste": { name: "Paste car", icon: "paste" },
                    "delete": { name: "Delete car", icon: "delete" },
                    "sep1": "---------",
                    "quit": {
                        name: "Quit", icon: function () {
                            return 'context-menu-icon context-menu-icon-quit';
                        }
                    }
                }
            });
            $.contextMenu({
                selector: '.map-menu',
                callback: function (key, options) {
                    var m = "clicked: " + key;
                    window.console && console.log(m) || alert(m);
                },
                items: {
                    "edit": { name: "Edit map", icon: "edit" },
                    "cut": { name: "Cut map", icon: "cut" },
                    copy: { name: "Copy map", icon: "copy" },
                    "paste": { name: "Paste map", icon: "paste" },
                    "delete": { name: "Delete map", icon: "delete" },
                    "sep1": "---------",
                    "quit": {
                        name: "Quit", icon: function () {
                            return 'context-menu-icon context-menu-icon-quit';
                        }
                    }
                }
            });
        });
        // mapboxgl.accessToken = 'pk.your-own-code-here-for-online-maps';
        mapboxgl.accessToken = 'NOT-REQUIRED-WITH-YOUR-VECTOR-TILES-DATA';
        var geojson = {
            "type": "FeatureCollection",
            "features": [
                {
                    "type": "Feature",
                    "properties": {
                        "message": "Patrol car1",
                        "iconSize": [40, 40]
                    },
                    "geometry": {
                        "type": "Point",
                        "coordinates": [
                            51.09701854553526,
                            25.40174766695526
                        ]
                    }
                }
            ]
        };
        var map = new mapboxgl.Map({
            container: 'map',
            center: [51.1839, 25.3548],
            zoom: 8,
            style: custommapstyle
        });

        map.addControl(new mapboxgl.NavigationControl());
        map.addControl(new mapboxgl.FullscreenControl());
        // add markers to map
        geojson.features.forEach(function (marker) {
            // create a DOM element for the marker
            var el = document.createElement('div');
            el.className = 'marker marker-context-menu';
            el.style.backgroundImage = 'url(http://localhost:2022/Images/car.jpg)';
            el.style.width = marker.properties.iconSize[0] + 'px';
            el.style.height = marker.properties.iconSize[1] + 'px';

            el.addEventListener('click', function () {
                window.alert(marker.properties.message);
            });

            // add marker to map
            new mapboxgl.Marker(el)
                .setLngLat(marker.geometry.coordinates)
                .addTo(map);
        });
        map.on('load', function () {
            map.on("contextmenu", function (e) {
                console.log("right click at:", e.lngLat.lng, e.lngLat.lat)
            })
        })
</script>

</body>
</html>
