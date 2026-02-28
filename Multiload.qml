import QtQuick
import Quickshell.Io
import qs.Common
import qs.Modules.Plugins

PluginComponent {
    horizontalBarPill: Row {
        spacing: Theme.spacingXS
        Rectangle {
            id: chart
            implicitWidth: 20
            implicitHeight: 20
            property var fractions: new Array(10).fill(0)
            Repeater {
                model: chart.fractions
                Rectangle {
                    required property real modelData
                    required property int index
                    x: width * index
                    width: 2
                    height: parent.height * modelData
                    anchors.bottom: parent.bottom
                    color: Theme.primary
                }
            }
            Process {
                id: dgop
                command: ["dgop", "cpu", "--json"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        var cores = JSON.parse(text)["coreUsage"];
                        var fraction = Math.max(...cores) / 100;
                        chart.fractions = chart.fractions.slice(1).concat(fraction);
                    }
                }
            }
            Timer {
                interval: 2000
                running: true
                repeat: true
                onTriggered: dgop.running = true
            }
        }
    }
    verticalBarPill: Column {
        spacing: Theme.spacingXS
        Rectangle {
            implicitWidth: 20
            implicitHeight: 20
        }
    }
}
