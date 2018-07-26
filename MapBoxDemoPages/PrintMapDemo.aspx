<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintMapDemo.aspx.cs" Inherits="MapBoxDemoPages.PrintMapDemo" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>MapBox GL JS Offline Example</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.js'></script>
    <link href='https://api.mapbox.com/mapbox-gl-js/v0.46.0/mapbox-gl.css' rel='stylesheet' />
    <script type="text/javascript" src="https://api.tiles.mapbox.com/mapbox-gl-js/v0.42.2/mapbox-gl.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/canvas-toblob/0.1/canvas-toBlob.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/eligrey/FileSaver.js/1.3.3/FileSaver.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jspdf/1.3.4/jspdf.min.js"></script>


    <link href="/Style/Print/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        body {
            padding-bottom: 10px;
        }

        #error-message {
            display: none;
        }

        .map-container {
            overflow-x: auto;
        }

        #map {
            width: 768px;
            height: 576px;
            position: relative;
            margin-left: auto;
            margin-right: auto;
        }



        /*
 * Hide high-res map rendering
 */
        .hidden-map {
            overflow: hidden;
            height: 0;
            width: 0;
            position: fixed;
        }



        /*
 * Loading spinner
 * Based on http://codepen.io/lixquid/pen/ybjmr
 */
        #spinner {
            width: 24px;
            height: 24px;
            border-top: 2px solid #fff;
            border-bottom: 2px solid #fff;
            border-right: 2px solid #333;
            border-left: 2px solid #333;
            -webkit-animation: spinner 0.75s ease infinite;
            animation: spinner 0.75s ease infinite;
            border-radius: 100%;
            position: relative;
            top: 8px;
            margin-left: 10px;
            display: none;
        }

        @-webkit-keyframes spinner {
            to {
                -webkit-transform: rotate(180deg);
                transform: rotate(180deg);
            }
        }

        @keyframes spinner {
            to {
                -webkit-transform: rotate(180deg);
                transform: rotate(180deg);
            }
        }
    </style>
</head>
<body>
    <form onsubmit="generateMap(); return false;" id="config">
        <fieldset id="config-fields">
            <div class="row">
                <div class="col-sm-12">
                    <button type="submit" class="btn btn-primary btn-lg" id="generate-btn">Generate Map</button>
                    <div id="spinner"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <div class="form-group">
                        <label>Unit</label><br>
                        <label class="radio-inline">
                            <input type="radio" name="unitOptions" value="in" id="inUnit" checked>
                            Inch
       
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="unitOptions" value="mm" id="mmUnit">
                            Millimeter
       
                        </label>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label>Output format</label><br>
                        <label class="radio-inline">
                            <input type="radio" name="outputOptions" value="png" checked>
                            PNG
       
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="outputOptions" value="pdf">
                            PDF
       
                        </label>
                    </div>
                </div>
                <div class="col-sm-5">
                    <div class="form-group">
                        <label for="styleSelect">Map style</label>
                        <select id="styleSelect" class="form-control">
                            <option value="mapbox://styles/mapbox/bright-v9">Mapbox Bright</option>
                            <option value="mapbox://styles/mapbox/outdoors-v10">Mapbox Outdoors</option>
                            <option value="mapbox://styles/mapbox/emerald-v8">Mapbox Emerald</option>
                            <option value="mapbox://styles/mapbox/light-v9">Mapbox Light</option>
                            <option value="mapbox://styles/mapbox/streets-v10">Mapbox Streets</option>
                            <option value="https://openmaptiles.github.io/positron-gl-style/style-cdn.json">Klokantech Positron</option>
                            <option value="https://openmaptiles.github.io/dark-matter-gl-style/style-cdn.json">Klokantech Dark Matter</option>
                            <option value="https://openmaptiles.github.io/osm-bright-gl-style/style-cdn.json">Klokantech OSM Bright</option>
                            <option value="https://openmaptiles.github.io/klokantech-basic-gl-style/style-cdn.json">Klokantech Basic</option>
                            <option value="https://openmaptiles.github.io/klokantech-terrain-gl-style/style-cdn.json">Klokantech Terrain</option>
                            <option value="https://openmaptiles.github.io/fiord-color-gl-style/style-cdn.json">Klokantech Fiord Color</option>
                            <option value="https://openmaptiles.github.io/toner-gl-style/style-cdn.json">Klokantech Toner</option>
                            <option value="http://osm-liberty.lukasmartinelli.ch/style.json">OSM Liberty</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-2">
                    <div class="form-group" id="widthGroup">
                        <label for="widthInput">Width</label>
                        <input type="text" class="form-control" id="widthInput" autocomplete="off" value="8">
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="form-group" id="heightGroup">
                        <label for="heightInput">Height</label>
                        <input type="text" class="form-control" id="heightInput" autocomplete="off" value="6">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group" id="dpiGroup">
                        <label for="dpiInput">DPI</label>
                        <input type="text" class="form-control" id="dpiInput" autocomplete="off" value="300">
                    </div>
                </div>
                <div class="col-sm-5">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group" id="latGroup">
                                <label for="latInput">Latitude</label>
                                <input type="text" class="form-control" id="latInput" autocomplete="off" value="">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group" id="lonGroup">
                                <label for="lonInput">Longitude</label>
                                <input type="text" class="form-control" id="lonInput" autocomplete="off" value="">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group" id="zoomGroup">
                                <label for="zoomInput">Zoom</label>
                                <input type="text" class="form-control" id="zoomInput" autocomplete="off" value="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Map</h3>
                        </div>
                        <div class="panel-body map-container">
                            <div id="map"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-backdrop in" id="modalBackdrop" style="display: none;"></div>
        </fieldset>
    </form>

    <script src="/Scripts/Print/script.js"></script>
</body>
</html>
