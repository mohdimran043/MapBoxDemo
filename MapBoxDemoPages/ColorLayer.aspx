﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ColorLayer.aspx.cs" Inherits="MapBoxDemoPages.ColorLayer" %>


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

        .map-overlay {
            font: 12px/20px 'Helvetica Neue', Arial, Helvetica, sans-serif;
            position: absolute;
            width: 200px;
            top: 0;
            left: 0;
            padding: 10px;
        }

            .map-overlay .map-overlay-inner {
                background-color: #fff;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.10);
                border-radius: 3px;
                padding: 10px;
                margin-bottom: 10px;
            }

        .map-overlay-inner fieldset {
            border: none;
            padding: 0;
            margin: 0 0 10px;
        }

            .map-overlay-inner fieldset:last-child {
                margin: 0;
            }

        .map-overlay-inner select {
            width: 100%;
        }

        .map-overlay-inner label {
            display: block;
            font-weight: bold;
            margin: 0 0 5px;
        }

        .map-overlay-inner button {
            display: inline-block;
            width: 36px;
            height: 20px;
            border: none;
            cursor: pointer;
        }

            .map-overlay-inner button:focus {
                outline: none;
            }

            .map-overlay-inner button:hover {
                box-shadow: inset 0 0 0 3px rgba(0, 0, 0, 0.10);
            }
    </style>
</head>
<body>

    <div id='map'></div>
    <div class='map-overlay top'>
        <div class='map-overlay-inner'>
            <fieldset>
                <label>Select layer</label>
                <select id='layer' name='layer'>
                    <option value='water'>Water</option>
                    <option value='building'>Buildings</option>
                </select>
            </fieldset>
            <fieldset>
                <label>Choose a color</label>
                <div id='swatches'></div>
            </fieldset>
        </div>
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


        var swatches = document.getElementById('swatches');
        var layer = document.getElementById('layer');
        var colors = [
            '#ffffcc',
            '#a1dab4',
            '#41b6c4',
            '#2c7fb8',
            '#253494',
            '#fed976',
            '#feb24c',
            '#fd8d3c',
            '#f03b20',
            '#bd0026'
        ];

        colors.forEach(function (color) {
            var swatch = document.createElement('button');
            swatch.style.backgroundColor = color;
            swatch.addEventListener('click', function () {
                map.setPaintProperty(layer.value, 'fill-color', color);
            });
            swatches.appendChild(swatch);
        });
</script>

</body>
</html>
