import QtQuick
import Quickshell.Io

Item {
    id: root
    property var fractions: new Array(10).fill(0)
    Process {
        id: dgop
        command: ["dgop", "cpu", "--json"]
        stdout: StdioCollector {
            onStreamFinished: {
                var cores = JSON.parse(text)["coreUsage"];
                var fraction = Math.max(...cores) / 100;
                root.fractions = root.fractions.slice(1).concat(fraction);
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
