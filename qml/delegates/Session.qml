/*
 * Copyright (C) 2012-2015 Jolla Ltd.
 *
 * The code in this file is distributed under multiple licenses, and as such,
 * may be used under any one of the following licenses:
 *
 *   - GNU General Public License as published by the Free Software Foundation;
 *     either version 2 of the License (see LICENSE.GPLv2 in the root directory
 *     for full terms), or (at your option) any later version.
 *   - GNU Lesser General Public License as published by the Free Software
 *     Foundation; either version 2.1 of the License (see LICENSE.LGPLv21 in the
 *     root directory for full terms), or (at your option) any later version.
 *   - Alternatively, if you have a commercial license agreement with Jolla Ltd,
 *     you may use the code under the terms of that license instead.
 *
 * You can visit <https://sailfishos.org/legal/> for more information
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.contacts 1.0
import org.nemomobile.commhistory 1.0
import Sailfish.Contacts 1.0

ListItem {
    id: delegate
    contentHeight: textColumn.height + Theme.paddingMedium + textColumn.y
    menu: contextMenuComponent

    Column {
        id: textColumn
        anchors {
            top: parent.top
            topMargin: Theme.paddingSmall
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
        }

        Row {
            width: parent.width

            Image {
                id: groupIcon
                source: model.isGroup ? ("image://theme/icon-s-group-chat?" + (delegate.highlighted ? Theme.highlightColor : Theme.primaryColor)) : ""
                anchors.verticalCenter: name.verticalCenter
            }

            Label {
                id: name
                width: parent.width - x

                truncationMode: TruncationMode.Fade
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                text: model.isGroup ? model.groupName : model.name
            }
        }

        Label {
            id: lastMessage
            anchors.left: parent.left
            anchors.right: parent.right

            text: {
                if (model.message != '') {
                    return model.message
                } else if (model.hasAttachment) {
                    return qsTr("Attachment")
                }
                return ''
            }

            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeExtraSmall
            color: delegate.highlighted || model.unread > 0 ? Theme.highlightColor : Theme.primaryColor
            wrapMode: Text.Wrap
            maximumLineCount: 3

            GlassItem {
                visible: model.unread > 0
                color: Theme.highlightColor
                falloffRadius: 0.16
                radius: 0.15
                anchors {
                    left: parent.left
                    leftMargin: width / -2 - Theme.horizontalPageMargin
                    top: parent.top
                    topMargin: height / -2 + date.height / 2
                }
            }
        }

        Label {
            id: date

            color: delegate.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraSmall
            text: {
               var re = model.date
               if (model.received) {
                   re += qsTr("  ✓✓")
               } else if (model.sent) {
                   re += qsTr("  ✓")
               }
               return re
            }
        }
    }

    function remove() {
	console.log("Remove all messages")
    }

    Component {
        id: contextMenuComponent

        ContextMenu {
            id: menu
            MenuItem {
                text: qsTr("Delete Conversation")
                onClicked: remove()
            }
        }
    }
}
