<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeoLineWithArrow.aspx.cs" Inherits="MapBoxDemoPages.GeoLineWithArrow" %>


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

        var geoData = {
            "type": "FeatureCollection",
            "features": [{
                "type": "Feature",
                "properties": {
                    "LTYPE": "MFG"
                },
                "geometry": {
                    "type": "Point",
                    "coordinates": [-80.691132,
                        34.202929
                    ]
                }
            }, {
                "type": "Feature",
                "properties": {
                    "LTYPE": "MFG"
                },
                "geometry": {
                    "type": "Point",
                    "coordinates": [-80.046402,
                        32.939921
                    ]
                }
            }, {
                "type": "Feature",
                "properties": {
                    "LTYPE": "CUST"
                },
                "geometry": {
                    "type": "Point",
                    "coordinates": [-80.046402,
                        32.939921
                    ]
                }
            }, {
                "type": "Feature",
                "properties": {
                    "LTYPE": "CUST"
                },
                "geometry": {
                    "type": "Point",
                    "coordinates": [-80.046402,
                        32.939921
                    ]
                }
            }, {
                "type": "Feature",
                "properties": {},
                "geometry": {
                    "type": "LineString",
                    "coordinates": [
                        [-80.691132,
                            34.202929
                        ],
                        [-80.046402,
                            32.939921
                        ]
                    ]
                }
            }, {
                "type": "Feature",
                "properties": {},
                "geometry": {
                    "type": "LineString",
                    "coordinates": [
                        [-80.046402,
                            32.939921
                        ],
                        [-80.046402,
                            32.939921
                        ]
                    ]
                }
            }]
        };
        var map = new mapboxgl.Map({
            container: 'map',
            center: [-80.691132,
                34.202929
            ],
            zoom: 15,
            style: custommapstyle1
        });

        map.addControl(new mapboxgl.NavigationControl());
        map.addControl(new mapboxgl.FullscreenControl());
        map.addControl(new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        }));


        map.on('load', function () {
            map.addSource('mapDataSourceId', {
                type: "geojson",
                data: geoData
            });
            addLayer(map);
        });

        function addLayer(map) {

            map.addLayer({
                'id': 'route',
                'type': 'line',
                'source': 'mapDataSourceId',
                'filter': ['==', '$type', 'LineString'],
                'layout': {
                    'line-join': 'round',
                    'line-cap': 'round'
                },
                'paint': {
                    'line-color': '#3cb2d0',
                    'line-width': {
                        'base': 1.5,
                        'stops': [
                            [1, 0.5],
                            [8, 3],
                            [15, 6],
                            [22, 8]
                        ]
                    }
                }
            });

            map.addLayer({
                'id': 'location',
                'type': 'circle',
                'source': 'mapDataSourceId',
                'filter': ['==', '$type', 'Point'],
                'paint': {
                    'circle-color': 'green',
                    'circle-radius': {
                        'base': 1.5,
                        'stops': [
                            [1, 1],
                            [6, 3],
                            [10, 8],
                            [22, 12]
                        ]
                    }
                }
            });

            var url = 'https://i.imgur.com/LcIng3L.png';
            map.loadImage(url, function (err, image) {
                if (err) {
                    console.error('err image', err);
                    return;
                }
                map.addImage('arrow', image);
                map.addLayer({
                    'id': 'arrow-layer',
                    'type': 'symbol',
                    'source': 'mapDataSourceId',
                    'layout': {
                        'symbol-placement': 'line',
                        'symbol-spacing': 1,
                        'icon-allow-overlap': true,
                        // 'icon-ignore-placement': true,
                        'icon-image': 'arrow',
                        'icon-size': 0.045,
                        'visibility': 'visible'
                    }
                });
            });

        }
</script>

</body>
</html>
