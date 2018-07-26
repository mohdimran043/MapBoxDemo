<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapOffline.aspx.cs" Inherits="MapBoxDemoPages.MapOffline" %>

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
    </style>
</head>
<body>

    <div id='map'></div>
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

        function addMarker(e) {

            if (typeof circleMarker !== "undefined") {
                map.removeLayer(circleMarker);
            }
            //add marker
            circleMarker = new L.circle(e.latlng, 200, {
                color: 'red',
                fillColor: '#f03',
                fillOpacity: 0.5
            }).addTo(map);
        }
</script>

</body>
</html>
