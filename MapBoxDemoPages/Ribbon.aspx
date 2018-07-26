﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ribbon.aspx.cs" Inherits="MapBoxDemoPages.Ribbon" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Plugin/EasyUI/themes/default/easyui.css" rel="stylesheet" />
    <link href="Plugin/EasyUI/themes/icon.css" rel="stylesheet" />
    <link href="Plugin/Ribbon/ribbon-icon.css" rel="stylesheet" />
    <link href="Plugin/Ribbon/ribbon.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Plugin/EasyUI/jquery.easyui.min.js"></script>
    <script src="Plugin/Ribbon/jquery.ribbon.js"></script>
    <script type="text/javascript">
        var data = {
            selected: 0,
            tabs: [{
                title: 'Home',
                groups: [{
                    title: 'Clipboard',
                    tools: [{
                        type: 'splitbutton',
                        name: 'paste',
                        text: 'Paste',
                        iconCls: 'icon-paste-large',
                        iconAlign: 'top',
                        size: 'large',
                        menuItems: [{
                            name: 'paste',
                            text: 'Paste',
                            iconCls: 'icon-paste'
                        }, {
                            name: 'paste-special',
                            text: 'Paste Special...',
                            iconCls: 'icon-paste'
                        }]
                    }, {
                        type: 'toolbar',
                        dir: 'v',
                        tools: [{
                            name: 'cut',
                            text: 'Cut',
                            iconCls: 'icon-cut'
                        }, {
                            name: 'copy',
                            text: 'Copy',
                            iconCls: 'icon-copy'
                        }, {
                            name: 'format',
                            text: 'Format',
                            iconCls: 'icon-format'
                        }]
                    }]
                }, {
                    title: 'Font',
                    tools: [{
                        type: 'toolbar',
                        tools: [{
                            type: 'combobox',
                            valueField: 'text',
                            textField: 'text',
                            data: [{ text: 'Arial', selected: true }, { text: 'Century' }, { text: 'Tahoma' }],
                            width: 100,
                            panelHeight: 'auto',
                            editable: false
                        }, {
                            type: 'combobox',
                            valueField: 'text',
                            textField: 'text',
                            data: [{ text: '8' }, { text: '12', selected: true }, { text: '14' }],
                            width: 60,
                            panelHeight: 'auto',
                            editable: false
                        }]
                    }, {
                        type: 'toolbar',
                        style: { marginLeft: '5px' },
                        tools: [{
                            name: 'increase-font',
                            iconCls: 'icon-increase-font'
                        }, {
                            name: 'decrease-font',
                            iconCls: 'icon-decrease-font'
                        }]
                    }, {
                        type: 'toolbar',
                        style: { clear: 'both', marginTop: '2px' },
                        tools: [{
                            name: 'bold',
                            iconCls: 'icon-bold',
                            toggle: true
                        }, {
                            name: 'italic',
                            iconCls: 'icon-italic',
                            toggle: true
                        }, {
                            name: 'underline',
                            iconCls: 'icon-underline',
                            toggle: true
                        }, {
                            name: 'strikethrough',
                            iconCls: 'icon-strikethrough',
                            toggle: true
                        }, {
                            name: 'superscript',
                            iconCls: 'icon-superscript',
                            toggle: true
                        }, {
                            name: 'subscript',
                            iconCls: 'icon-subscript',
                            toggle: true
                        }]
                    }, {
                        type: 'toolbar',
                        style: { clear: 'both' },
                        tools: [{
                            name: 'case-font',
                            iconCls: 'icon-case-font'
                        }, {
                            name: 'grow-font',
                            iconCls: 'icon-grow-font'
                        }, {
                            name: 'shrink-font',
                            iconCls: 'icon-shrink-font'
                        }]
                    }]
                }, {
                    title: 'Paragraph',
                    dir: 'v',
                    tools: [{
                        type: 'toolbar',
                        tools: [{
                            name: 'slign-left',
                            iconCls: 'icon-align-left',
                            toggle: true,
                            group: 'p1'
                        }, {
                            name: 'align-center',
                            iconCls: 'icon-align-center',
                            toggle: true,
                            group: 'p1'
                        }, {
                            name: 'align-right',
                            iconCls: 'icon-align-right',
                            toggle: true,
                            group: 'p1'
                        }, {
                            name: 'align-justify',
                            iconCls: 'icon-align-justify',
                            toggle: true,
                            group: 'p1'
                        }]
                    }, {
                        type: 'toolbar',
                        style: { marginTop: '2px' },
                        tools: [{
                            name: 'bullets',
                            iconCls: 'icon-bullets'
                        }, {
                            name: 'numbers',
                            iconCls: 'icon-numbers'
                        }]
                    }]
                }, {
                    title: 'Editing',
                    dir: 'v',
                    tools: [{
                        type: 'splitbutton',
                        name: 'find',
                        text: 'Find',
                        iconCls: 'icon-find',
                        menuItems: [{
                            name: 'find',
                            text: 'Find',
                            iconCls: 'icon-find'
                        }, {
                            name: 'go',
                            text: 'Go to...',
                            iconCls: 'icon-go'
                        }]
                    }, {
                        name: 'replace',
                        text: 'Replace',
                        iconCls: 'icon-replace'
                    }, {
                        type: 'menubutton',
                        name: 'select',
                        text: 'Select',
                        iconCls: 'icon-select',
                        menuItems: [{
                            name: 'selectall',
                            text: 'Select All',
                            iconCls: 'icon-selectall'
                        }, {
                            name: 'select-object',
                            text: 'Select Objects',
                            iconCls: 'icon-select'
                        }]
                    }]
                }]
            }, {
                title: 'Insert',
                groups: [{
                    title: 'Table',
                    tools: [{
                        type: 'menubutton',
                        name: 'table',
                        text: 'Table',
                        iconCls: 'icon-table-large',
                        iconAlign: 'top',
                        size: 'large'
                    }]
                }, {
                    title: 'Illustrations',
                    tools: [{
                        name: 'picture',
                        text: 'Picture',
                        iconCls: 'icon-picture-large',
                        iconAlign: 'top',
                        size: 'large'
                    }, {
                        name: 'clipart',
                        text: 'Clip Art',
                        iconCls: 'icon-clipart-large',
                        iconAlign: 'top',
                        size: 'large'
                    }, {
                        type: 'menubutton',
                        name: 'shapes',
                        text: 'Shapes',
                        iconCls: 'icon-shapes-large',
                        iconAlign: 'top',
                        size: 'large'
                    }, {
                        name: 'smartart',
                        text: 'SmartArt',
                        iconCls: 'icon-smartart-large',
                        iconAlign: 'top',
                        size: 'large'
                    }, {
                        name: 'chart',
                        text: 'Chart',
                        iconCls: 'icon-chart-large',
                        iconAlign: 'top',
                        size: 'large'
                    }]
                }]
            }]
        };

        $(function () {
            $('#rr').ribbon({
                data: data
            });
        });
    </script>
</head>
<body>
    <h1>Ribbon</h1>
    <div id="rr" style="width: 700px;">
    </div>
    <h1>Ribbon Markup</h1>
    <div class="easyui-ribbon" style="width: 700px;">
        <div title="Home">
            <div class="ribbon-group">
                <div class="ribbon-toolbar">
                    <a href="#" class="easyui-menubutton" data-options="name:'paste',iconCls:'icon-paste-large',iconAlign:'top',size:'large'">Paste</a>
                </div>
                <div class="ribbon-toolbar">
                    <a href="#" class="easyui-linkbutton" data-options="name:'cut',iconCls:'icon-cut',plain:true">Cut</a><br>
                    <a href="#" class="easyui-linkbutton" data-options="name:'copy',iconCls:'icon-copy',plain:true">Copy</a><br>
                    <a href="#" class="easyui-linkbutton" data-options="name:'format',iconCls:'icon-format',plain:true">Format</a>
                </div>
                <div class="ribbon-group-title">Clipboard</div>
            </div>
            <div class="ribbon-group-sep"></div>
            <div class="ribbon-group">
                <div class="ribbon-toolbar" style="width: 200px"></div>
                <div class="ribbon-group-title">other title</div>
            </div>
            <div class="ribbon-group-sep"></div>
        </div>
    </div>
</body>
</html>
