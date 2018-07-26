<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapBoxDrawPolygon.aspx.cs" Inherits="MapBoxDemoPages.MapBoxDrawPolygon" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />

    <script src='https://api.tiles.mapbox.com/mapbox.js/plugins/turf/v3.0.11/turf.min.js'></script>
    <script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.js'></script>
    <link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.css' type='text/css' />
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

        .calculation-box {
            height: 75px;
            width: 150px;
            position: absolute;
            bottom: 40px;
            left: 10px;
            background-color: rgba(255, 255, 255, .9);
            padding: 15px;
            text-align: center;
        }

        p {
            font-family: 'Open Sans';
            margin: 0;
            font-size: 13px;
        }
    </style>
</head>
<body>

    <div id='map'></div>
    <div class='calculation-box'>
        <p>Draw a polygon using the draw tools.</p>
        <div id='calculated-area'></div>
    </div>

    <script>
        // mapboxgl.accessToken = 'pk.your-own-code-here-for-online-maps';
        mapboxgl.accessToken = 'NOT-REQUIRED-WITH-YOUR-VECTOR-TILES-DATA';

        var map = new mapboxgl.Map({
            container: 'map',
            center: [51.1839, 25.3548],
            zoom: 8,
            style: custommapstyle
        });

        map.addControl(new mapboxgl.NavigationControl());
        map.addControl(new mapboxgl.FullscreenControl());


        var draw = new MapboxDraw({
            displayControlsDefault: false,
            controls: {
                polygon: true,
                trash: true
            }
        });
        map.addControl(draw);

        map.on('draw.create', updateArea);
        map.on('draw.delete', updateArea);
        map.on('draw.update', updateArea);

        function updateArea(e) {
            var data = draw.getAll();
            var answer = document.getElementById('calculated-area');
            if (data.features.length > 0) {
                var area = turf.area(data);
                // restrict to area to 2 decimal points
                var rounded_area = Math.round(area * 100) / 100;
                answer.innerHTML = '<p><strong>' + rounded_area + '</strong></p><p>square meters</p>';
            } else {
                answer.innerHTML = '';
                if (e.type !== 'draw.delete') alert("Use the draw tools to draw a polygon!");
            }
        }

    </script>

</body>
</html>
