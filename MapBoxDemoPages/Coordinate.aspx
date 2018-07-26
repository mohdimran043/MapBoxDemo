<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Coordinate.aspx.cs" Inherits="MapBoxDemoPages.Coordinate" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />
    <script src="/Scripts/MapSource.js"></script>
    <%-- <script src='/MapContent/mapbox-gl.js'></script>
    <link href='/MapContent/mapbox-gl.css' rel='stylesheet' />--%>
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

        #info {
            display: block;
            position: relative;
            margin: 0px auto;
            width: 50%;
            padding: 10px;
            border: none;
            border-radius: 3px;
            font-size: 12px;
            text-align: center;
            color: #222;
            background: #fff;
        }
    </style>
</head>
<body>
    <div id='map'></div>
    <pre id='info'></pre>
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

        map.on('mousemove', function (e) {
            document.getElementById('info').innerHTML =
                // e.point is the x, y coordinates of the mousemove event relative
                // to the top-left corner of the map
                JSON.stringify(e.point) + '<br />' +
                // e.lngLat is the longitude, latitude geographical position of the event
                JSON.stringify(e.lngLat);
        });
</script>

</body>
</html>
