<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapLanguage.aspx.cs" Inherits="MapBoxDemoPages.MapLanguage" %>

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

        #buttons {
            width: 90%;
            margin: 0 auto;
        }

        .button {
            display: inline-block;
            position: relative;
            cursor: pointer;
            width: 20%;
            padding: 8px;
            border-radius: 3px;
            margin-top: 10px;
            font-size: 12px;
            text-align: center;
            color: #fff;
            background: #ee8a65;
            font-family: sans-serif;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div id='map'></div>
    <ul id="buttons">
        <li id='button-fr' class='button'>French</li>
        <li id='button-ru' class='button'>Russian</li>
        <li id='button-de' class='button'>German</li>
        <li id='button-es' class='button'>Spanish</li>
    </ul>
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

        document.getElementById('buttons').addEventListener('click', function (event) {
            var language = event.target.id.substr('button-'.length);
            // Use setLayoutProperty to set the value of a layout property in a style layer.
            // The three arguments are the id of the layer, the name of the layout property,
            // and the new property value.
            map.setLayoutProperty('country-label-lg', 'text-field', ['get', 'name_' + language]);
        });
    </script>

</body>
</html>
