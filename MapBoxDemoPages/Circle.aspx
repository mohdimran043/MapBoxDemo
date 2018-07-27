<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Circle.aspx.cs" Inherits="MapBoxDemoPages.Circle" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />
    <script src="/Scripts/Circle/Circle.js"></script>
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

        svg {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        nav {
            position: absolute;
            top: 40px;
            left: 20px;
            z-index: 1;
        }

        #circle {
            background-color: rgba(20, 20, 20, 0.1);
            font-family: Helvetica, sans-serif;
            color: #3b83bd;
            padding: 5px 8px;
            border-radius: 3px;
            cursor: pointer;
            border: 1px solid #111;
        }

            #circle.active {
                background-color: rgba(250, 250, 250, 0.9);
            }
    </style>
</head>
<body>
    <nav>
        <a id="circle" class="active">draw circle</a>
    </nav>
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
        map.addControl(new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        }));
        map.dragPan.disable();
        map.scrollZoom.disable();

        // Setup our svg layer that we can manipulate with d3
        var container = map.getCanvasContainer()
        var svg = d3.select(container).append("svg")

        var active = true;
        var circleControl = new circleSelector(svg)
            .projection(project)
            .inverseProjection(function (a) {
                return map.unproject({ x: a[0], y: a[1] });
            })
            .activate(active);

        d3.select("#circle").on("click", function () {
            active = !active;
            circleControl.activate(active)
            if (active) {
                map.dragPan.disable();
            } else {
                map.dragPan.enable();
            }
            d3.select(this).classed("active", active)
        })
        

        function project(d) {
            return map.project(getLL(d));
        }
        function getLL(d) {
            return new mapboxgl.LngLat(+d.lng, +d.lat)
        }

        d3.csv("/App_Data/dots.csv", function (err, data) {
            var dots = svg.selectAll("circle.dot")
                .data(data)

            dots.enter().append("circle").classed("dot", true)
                .attr("r", 1)
                .style({
                    fill: "#0082a3",
                    "fill-opacity": 0.6,
                    stroke: "#004d60",
                    "stroke-width": 1
                })
                .transition().duration(1000)
                .attr("r", 6)

            circleControl.on("update", function () {
                svg.selectAll("circle.dot").style({
                    fill: function (d) {
                        var thisDist = circleControl.distance(d);
                        var circleDist = circleControl.distance()
                        if (thisDist < circleDist) {
                            return "#ff8eec";
                        } else {
                            return "#0082a3"
                        }
                    }
                })
            })
            circleControl.on("clear", function () {
                svg.selectAll("circle.dot").style("fill", "#0082a3")
            })

            function render() {
                dots.attr({
                    cx: function (d) {
                        var x = project(d).x;
                        return x
                    },
                    cy: function (d) {
                        var y = project(d).y;
                        return y
                    },
                })

                circleControl.update(svg)
            }

            // re-render our visualization whenever the view changes
            map.on("viewreset", function () {
                render()
            })
            map.on("move", function () {
                render()
            })

            // render our initial visualization
            render()
        })
</script>

</body>
</html>
