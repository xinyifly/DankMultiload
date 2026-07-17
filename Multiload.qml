pragma ComponentBehavior: Bound

import QtQuick
import qs.Common
import qs.Modules.Plugins

PluginComponent {
    horizontalBarPill: Row {
        spacing: Theme.spacingXS
        StepArea {
            fractions: dgop.cpus
        }
        StepArea {
            fractions: dgop.mems
        }
        StepArea {
            fractions: dgop.nets
        }
    }
    verticalBarPill: Column {
        spacing: Theme.spacingXS
        StepArea {
            fractions: dgop.cpus
        }
        StepArea {
            fractions: dgop.mems
        }
        StepArea {
            fractions: dgop.nets
        }
    }
    Dgop {
        id: dgop
    }
}
