<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="MapBoxDemoPages.Search" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />
    <script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v2.3.0/mapbox-gl-geocoder.min.js'></script>
    <link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v2.3.0/mapbox-gl-geocoder.css' />
    <script src="/Scripts/MapSource.js"></script>
    <%--https://www.mapbox.com/mapbox-gl-js/example/point-from-geocoder-result/--%>
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
        mapboxgl.accessToken = 'pk.eyJ1IjoidHJpc3RlbiIsImEiOiJiUzBYOEJzIn0.VyXs9qNWgTfABLzSI3YcrQ';
        //mapboxgl.accessToken = 'pk.eyJ1IjoidmxhZG8xMiIsImEiOiJjaXJic3Bkd3owMDZhaWVubnRoYWx0MnBoIn0.CzQtrmXJS7bUgzb3BC7amQ';
      
        var map = new mapboxgl.Map({
            container: 'map',
            center: [51.1839, 25.3548],
            zoom: 8,
            style: custommapstyle
        });

        map.addControl(new mapboxgl.NavigationControl());
        map.addControl(new mapboxgl.FullscreenControl());

        /* given a query in the form "lng, lat" or "lat, lng" returns the matching
  * geographic coordinate(s) as search results in carmen geojson format,
  * https://github.com/mapbox/carmen/blob/master/carmen-geojson.md
  */
        var coordinatesGeocoder = function (query) {
            // match anything which looks like a decimal degrees coordinate pair
            var matches = query.match(/^[ ]*(?:Lat: )?(-?\d+\.?\d*)[, ]+(?:Lng: )?(-?\d+\.?\d*)[ ]*$/i);
            if (!matches) {
                return null;
            }

            function coordinateFeature(lng, lat) {
                return {
                    center: [lng, lat],
                    geometry: {
                        type: "Point",
                        coordinates: [lng, lat]
                    },
                    place_name: 'Lat: ' + lat + ', Lng: ' + lng, // eslint-disable-line camelcase
                    place_type: ['coordinate'], // eslint-disable-line camelcase
                    properties: {},
                    type: 'Feature'
                };
            }

            var coord1 = Number(matches[1]);
            var coord2 = Number(matches[2]);
            var geocodes = [];

            if (coord1 < -90 || coord1 > 90) {
                // must be lng, lat
                geocodes.push(coordinateFeature(coord1, coord2));
            }

            if (coord2 < -90 || coord2 > 90) {
                // must be lat, lng
                geocodes.push(coordinateFeature(coord2, coord1));
            }

            if (geocodes.length === 0) {
                // else could be either lng, lat or lat, lng
                geocodes.push(coordinateFeature(coord1, coord2));
                geocodes.push(coordinateFeature(coord2, coord1));
            }

            return geocodes;
        };

        map.addControl(new MapboxGeocoder({
            accessToken: mapboxgl.accessToken,
            localGeocoder: coordinatesGeocoder,
            zoom: 4,
            placeholder: "Try: -40, 170"
        }));
</script>

</body>
</html>
