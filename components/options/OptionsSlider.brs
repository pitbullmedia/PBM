sub init()
    m.top.visible = false

    panel = m.top.findNode("panel")
    panel.panelSize = "small"
    panel.leftPosition = 96
    panel.focusable = true
    panel.hasNextPanel = false
    panel.leftOnly = true

    list = m.top.findNode("panelList")

    panel.list = list
end sub

sub setFields()
    options = m.top.options
    buttons = m.top.buttons
    row = m.top.findNode("fieldList")

    row.clear()
    row.appendChildren(options)
    row.appendChildren(buttons)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "options" or key = "back"
        m.top.visible = false
        m.top.closeSidePanel = true
        return true
    else if key = "OK"
        list = m.top.findNode("panelList")
        data = list.content.getChild(list.itemFocused)
        data.optionSelected = true
        return true
    end if

    return false
end function
