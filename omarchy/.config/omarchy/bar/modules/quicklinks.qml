import QtQuick

// quicklinks — scratchpad launcher icons with macOS-muted brand colors.
// Ported from the old Waybar style.css brand palette (muted, 0.75 alpha)
// + hover opacity behavior. Click toggles the matching special workspace
// (same binds as SUPER+SHIFT+*).
// NOTE: font.family MUST mirror the bar (bar.fontFamily) — bare QML Text
// uses the app default font, in which Nerd PUA glyphs render zero-width
// (verified 2026-09-09). Tracked in dotfiles; shell.json {"id":"quicklinks","type":"qml"}.
Item {
  property var bar
  property string moduleName
  property var settings

  id: root
  implicitWidth: row.implicitWidth
  implicitHeight: root.bar ? root.bar.barSize : 26

  function toggle(ws) {
    if (root.bar) root.bar.run("hyprctl dispatch togglespecialworkspace " + ws)
  }

  function iconFont() {
    return "CaskaydiaMono Nerd Font" // hardcoded: verified present via fc-list;
    // bar.fontFamily + monospace both render PUA glyphs zero-width here
  }

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 10

    Text { text: "\uf001"; color: "#BF1DB954"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("music") } }
    Text { text: "\uf232"; color: "#BF25D366"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("whatsapp") } }
    Text { text: "\uf16d"; color: "#BFE1306C"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("instagram") } }
    Text { text: "\uf03d"; color: "#BF4285F4"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("video") } }
    Text { text: "\uf07b"; color: "#FFCDD6F4"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("file") } }
    Text { text: "\uf120"; color: "#FFCDD6F4"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("kitty") } }
    Text { text: "\uf0ac"; color: "#FFCDD6F4"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("browser") } }
    Text { text: "\uf02d"; color: "#FFCDD6F4"; opacity: 0.8; font.pixelSize: 15; font.family: root.iconFont()
      MouseArea { anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
        onEntered: parent.opacity = 1.0; onExited: parent.opacity = 0.8
        onClicked: root.toggle("obsidian") } }
  }
}
