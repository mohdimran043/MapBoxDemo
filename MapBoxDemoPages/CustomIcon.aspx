<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomIcon.aspx.cs" Inherits="MapBoxDemoPages.CustomIcon" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
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

    <div id='map'></div>
    <script>
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
                },
                {
                    "type": "Feature",
                    "properties": {
                        "message": "Patrol car2",
                        "iconSize": [40, 40]
                    },
                    "geometry": {
                        "type": "Point",
                        "coordinates": [
                            51.41815014208129,
                            25.414841079007075
                        ]
                    }
                },
                {
                    "type": "Feature",
                    "properties": {
                        "message": "Patrol car3",
                        "iconSize": [40, 40]
                    },
                    "geometry": {
                        "type": "Point",
                        "coordinates": [
                            51.30999731019136,
                            25.568833587403745
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

        // add markers to map
        geojson.features.forEach(function (marker) {
            // create a DOM element for the marker
            var el = document.createElement('div');
            el.className = 'marker';
            el.style.backgroundImage = 'url(http://localhost:2022/Images/car.jpg)';
            el.style.width = marker.properties.iconSize[0] + 'px';
            el.style.height = marker.properties.iconSize[1] + 'px';

            el.addEventListener('click', function (e) {
                window.alert(marker.properties.message);
                e.stopImmediatePropagation();
            });

            // add marker to map
            new mapboxgl.Marker(el)
                .setLngLat(marker.geometry.coordinates)
                .addTo(map);
        });
        map.addControl(new mapboxgl.NavigationControl());
        map.addControl(new mapboxgl.FullscreenControl());


        map.on('click', function (e) {
           
            var el = document.createElement('div');
            el.className = 'marker';
            el.style.backgroundImage = 'url(http://localhost:2022/Images/pin.jpg)';
            el.style.width = 35 + 'px';
            el.style.height = 30 + 'px';

            //el.addEventListener('click', function (iconevent) {
            //    window.alert(123);
            //    iconevent.stopImmediatePropagation();
            //});

            // add marker to map
            new mapboxgl.Marker(el)
                .setLngLat(e.lngLat)
                .addTo(map);
        });
</script>

</body>
</html>
