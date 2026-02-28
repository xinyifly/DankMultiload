pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Modules.Plugins

PluginComponent {
    horizontalBarPill: Row {
        spacing: Theme.spacingXS
        StepArea {
            fractions: cpu.fractions
        }
    }
    verticalBarPill: Column {
        spacing: Theme.spacingXS
        StepArea {
            fractions: cpu.fractions
        }
    }
    Cpu {
        id: cpu
    }
}
