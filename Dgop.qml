import QtQuick
import Quickshell.Io

Item {
    readonly property var cpus: cpus.values
    readonly property var mems: mems.values
    Process {
        id: dgop
        command: ["dgop", "all", "--json"]
        stdout: StdioCollector {
            onStreamFinished: {
                const now = JSON.parse(text);
                cpus.digest(now["cpu"]);
                mems.digest(now["memory"]);
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: dgop.running = true
    }
    Queue {
        id: cpus
        function digest(cpu) {
            slide(Math.max(...cpu["coreUsage"]) / 100);
        }
    }
    Queue {
        id: mems
        function digest(mem) {
            slide(mem["usedPercent"] / 100);
        }
    }
    component Queue: QtObject {
        property var values: new Array(10).fill(0)
        function slide(value) {
            values = values.slice(1).concat(value);
        }
    }
}
