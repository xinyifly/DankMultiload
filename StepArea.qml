import QtQuick
import qs.Common

Rectangle {
    required property var fractions
    implicitWidth: 20
    implicitHeight: 20
    Repeater {
        model: parent.fractions
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
}
