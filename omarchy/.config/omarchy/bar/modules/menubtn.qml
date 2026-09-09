import QtQuick

// menubtn — Arch logo button replacing the stock omarchy.menu bar button.
// Stock button is hardcoded (Omarchy glyph, packaged source — must not edit).
// This custom module keeps identical behavior: left = root menu popup,
// right = terminal. White, matching the old Waybar omarchy logo.
// Tracked in dotfiles; shell.json {"id":"menubtn","type":"qml"}.
Item {
  property var bar
  property string moduleName
  property var settings

  id: root
  implicitWidth: 30
  implicitHeight: root.bar ? root.bar.barSize : 26

  function launch(args) {
    if (root.bar) root.bar.run(args)
  }

  Text {
    anchors.centerIn: parent
    text: "\uf303"
    color: "#FFFFFFFF"
    opacity: 0.9
    font.pixelSize: 17
    font.family: "CaskaydiaMono Nerd Font"

    MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      onEntered: parent.opacity = 1.0
      onExited: parent.opacity = 0.9
      onClicked: function(mouse) {
        if (mouse.button === Qt.RightButton) root.launch("xdg-terminal-exec")
        else root.launch("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
      }
    }
  }
}
