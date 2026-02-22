import QtQuick
import qs.Common
import qs.Modules.Plugins

PluginComponent {
    horizontalBarPill: Row {
        spacing: Theme.spacingXS
        Rectangle {
            implicitWidth: 20
            height: 20
            color: Theme.primary
        }
    }
    verticalBarPill: Column {
        spacing: Theme.spacingXS
        Rectangle {
            implicitWidth: 20
            height: 20
            color: Theme.primary
        }
    }
}
