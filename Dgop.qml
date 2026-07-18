import QtQuick
import Quickshell.Io

Item {
    readonly property var cpus: cpus.values
    readonly property var mems: mems.values
    readonly property var nets: nets.values
    Process {
        id: dgop
        command: ["dgop", "all", "--json"]
        stdout: StdioCollector {
            onStreamFinished: {
                const now = JSON.parse(text);
                cpus.digest(now["cpu"]);
                mems.digest(now["memory"]);
                nets.digest(now["network"]);
            }
        }
    }
    Timer {
        id: timer
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
    Queue {
        id: nets
        property real prevRx: -1
        function digest(net) {
            const rx = net.reduce((s, i) => s + i.rx, 0);
            if (prevRx >= 0) {
                const rxRate = (rx - prevRx) / (timer.interval / 1000);
                slide(Math.min(1, rxRate / (20 * 1024 * 1024)));
            }
            prevRx = rx;
        }
    }
    component Queue: QtObject {
        property var values: new Array(10).fill(0)
        function slide(value) {
            values = values.slice(1).concat(value);
        }
    }
}
