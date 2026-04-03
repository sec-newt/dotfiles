// ============================================================================
// arch-spectrum — SDDM Theme
// Dark Side of the Moon aesthetic: deep space background, spectrum gradient
// accents, Catppuccin-like dark surfaces, clean readable typography.
// ============================================================================

import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: root
    color: "#0a0a14"    // fallback if wallpaper fails to load

    // ── Color Palette ────────────────────────────────────────────────────────
    readonly property color colDark:    "#0d0d1a"   // card background
    readonly property color colSurf:    "#1a1a2e"   // input background
    readonly property color colBorder:  "#2e2e50"   // inactive borders
    readonly property color colText:    "#e8e8f8"   // primary text
    readonly property color colDim:     "#7070a0"   // labels / secondary text
    readonly property color colSuccess: "#22e600"   // spectrum green
    readonly property color colError:   "#ff2200"   // spectrum red
    readonly property color colWarn:    "#ffe600"   // spectrum yellow

    // ── Clock state ──────────────────────────────────────────────────────────
    property string clockTime: Qt.formatTime(new Date(), "hh:mm")
    property string clockDate: Qt.formatDate(new Date(), "dddd, MMMM d, yyyy")

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            root.clockTime = Qt.formatTime(new Date(), "hh:mm")
            root.clockDate = Qt.formatDate(new Date(), "dddd, MMMM d, yyyy")
        }
    }

    TextConstants { id: tc }

    // ── Background (drawn per-screen for multi-monitor) ───────────────────
    Repeater {
        model: screenModel
        Item {
            x: geometry.x; y: geometry.y
            width: geometry.width; height: geometry.height

            Image {
                anchors.fill: parent
                source: config.background
                fillMode: Image.PreserveAspectCrop
                asynchronous: false
                cache: false
            }

            // Very subtle darkening — keeps the wallpaper dominant
            Rectangle {
                anchors.fill: parent
                color: "#0d0d1a"
                opacity: 0.18
            }
        }
    }

    // ── Clock ─────────────────────────────────────────────────────────────
    Column {
        anchors {
            top: parent.top
            topMargin: Math.round(parent.height * 0.09)
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 6

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.clockTime
            color: "#ffffff"
            font.family: "Noto Sans"
            font.pixelSize: 90
            font.weight: Font.Light
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.clockDate
            color: root.colDim
            font.family: "Noto Sans"
            font.pixelSize: 17
        }
    }

    // ── Login card ─────────────────────────────────────────────────────────
    // Outer spectrum-gradient border rectangle
    Rectangle {
        id: cardBorder
        anchors.centerIn: loginCard
        width:  loginCard.width  + 4
        height: loginCard.height + 4
        radius: loginCard.radius + 2

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.000; color: "#ff2200" }
            GradientStop { position: 0.167; color: "#ff6600" }
            GradientStop { position: 0.333; color: "#ffe600" }
            GradientStop { position: 0.500; color: "#22e600" }
            GradientStop { position: 0.667; color: "#00ccff" }
            GradientStop { position: 0.833; color: "#0044ff" }
            GradientStop { position: 1.000; color: "#cc00ff" }
        }
    }

    Rectangle {
        id: loginCard
        anchors.centerIn: parent
        width:  420
        height: cardCol.implicitHeight + 72
        radius: 14
        color:  Qt.rgba(0.051, 0.051, 0.102, 0.90)  // #0d0d1a @ 90%

        Column {
            id: cardCol
            anchors {
                top:   parent.top
                left:  parent.left
                right: parent.right
                topMargin:   36
                leftMargin:  32
                rightMargin: 32
            }
            spacing: 12

            // Hostname
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: sddm.hostName
                color: "#ffffff"
                font.family:    "Noto Sans"
                font.pixelSize: 22
                font.weight:    Font.Medium
            }

            // Spectrum divider
            Rectangle {
                width: parent.width
                height: 2
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.000; color: "#ff2200" }
                    GradientStop { position: 0.167; color: "#ff6600" }
                    GradientStop { position: 0.333; color: "#ffe600" }
                    GradientStop { position: 0.500; color: "#22e600" }
                    GradientStop { position: 0.667; color: "#00ccff" }
                    GradientStop { position: 0.833; color: "#0044ff" }
                    GradientStop { position: 1.000; color: "#cc00ff" }
                }
            }

            Item { height: 4 }

            // Username label
            Text {
                text: tc.userName
                color: root.colDim
                font.family: "Noto Sans"; font.pixelSize: 13
            }

            // Username input
            TextBox {
                id: userField
                width:  parent.width
                height: 44
                text:   userModel.lastUser

                color:       root.colSurf
                borderColor: root.colBorder
                focusColor:  "#ffffff"
                hoverColor:  "#28284a"
                textColor:   root.colText

                font.family:    "Noto Sans"
                font.pixelSize: 16

                KeyNavigation.tab:     passField
                KeyNavigation.backtab: loginBtn
            }

            // Password label
            Text {
                text: tc.password
                color: root.colDim
                font.family: "Noto Sans"; font.pixelSize: 13
            }

            // Password input
            PasswordBox {
                id: passField
                width:  parent.width
                height: 44

                color:       root.colSurf
                borderColor: root.colBorder
                focusColor:  "#ffffff"
                hoverColor:  "#28284a"
                textColor:   root.colText

                tooltipEnabled: true
                tooltipText:    tc.capslockWarning
                tooltipFG:      root.colText
                tooltipBG:      root.colSurf

                font.family:    "Noto Sans"
                font.pixelSize: 16

                KeyNavigation.tab:     loginBtn
                KeyNavigation.backtab: userField

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin()
                        event.accepted = true
                    }
                }
            }

            // Status / error message
            Text {
                id: statusMsg
                width: parent.width
                text: ""
                color: root.colError
                font.family: "Noto Sans"; font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                visible: text !== ""
            }

            Item { height: 2 }

            // Login button
            Button {
                id: loginBtn
                width:  parent.width
                height: 44
                text:   tc.login

                color:        root.colSurf
                textColor:    root.colText
                borderColor:  root.colBorder
                pressedColor: "#28284a"
                activeColor:  "#28284a"

                font.family:    "Noto Sans"
                font.pixelSize: 16
                font.weight:    Font.Medium

                KeyNavigation.tab:     userField
                KeyNavigation.backtab: passField

                onClicked: root.tryLogin()

                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.tryLogin()
                        event.accepted = true
                    }
                }
            }

            Item { height: 4 }

            // Session selector
            Row {
                width: parent.width
                spacing: 8

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: tc.session + ":"
                    color: root.colDim
                    font.family: "Noto Sans"; font.pixelSize: 12
                }

                ComboBox {
                    id: sessionBox
                    width:  parent.width - 64
                    height: 30
                    model:  sessionModel
                    index:  sessionModel.lastIndex

                    color:       root.colSurf
                    borderColor: root.colBorder
                    focusColor:  "#ffffff"
                    hoverColor:  "#28284a"
                    textColor:   root.colText

                    font.family: "Noto Sans"; font.pixelSize: 12
                }
            }

            Item { height: 8 }
        }
    }

    // ── Power buttons (bottom-right) ──────────────────────────────────────
    Row {
        anchors {
            bottom:       parent.bottom
            right:        parent.right
            bottomMargin: 20
            rightMargin:  24
        }
        spacing: 10

        Rectangle {
            width: 90; height: 32; radius: 6
            color:        rebootHover.containsMouse ? root.colSurf : "transparent"
            border.color: root.colBorder; border.width: 1
            Text {
                anchors.centerIn: parent
                text: tc.reboot
                color: root.colDim; font.family: "Noto Sans"; font.pixelSize: 12
            }
            MouseArea { id: rebootHover; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.reboot() }
        }

        Rectangle {
            width: 90; height: 32; radius: 6
            color:        shutdownHover.containsMouse ? "#200a0a" : "transparent"
            border.color: shutdownHover.containsMouse ? root.colError : root.colBorder; border.width: 1
            Text {
                anchors.centerIn: parent
                text: tc.shutdown
                color: shutdownHover.containsMouse ? root.colError : root.colDim
                font.family: "Noto Sans"; font.pixelSize: 12
            }
            MouseArea { id: shutdownHover; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.powerOff() }
        }
    }

    // ── Auth signal handlers ───────────────────────────────────────────────
    signal tryLogin()

    onTryLogin: {
        statusMsg.text = ""
        sddm.login(userField.text, passField.text, sessionBox.index)
    }

    Connections {
        target: sddm

        onLoginSucceeded: {
            statusMsg.color = root.colSuccess
            statusMsg.text  = tc.loginSucceeded
        }

        onLoginFailed: {
            statusMsg.color = root.colError
            statusMsg.text  = tc.loginFailed
            passField.text  = ""
            passField.forceActiveFocus()
        }

        onInformationMessage: {
            statusMsg.color = root.colWarn
            statusMsg.text  = message
            passField.text  = ""
            passField.forceActiveFocus()
        }
    }

    Component.onCompleted: {
        if (userField.text === "")
            userField.forceActiveFocus()
        else
            passField.forceActiveFocus()
    }
}
