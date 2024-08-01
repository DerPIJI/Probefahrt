local nativeUI = {}

nativeUI.createMenu = function(title, subtitle)
  -- Hier kommt die Native UI-Menü-Erstellung hin
  -- Zum Beispiel:
  local menu = nativeUI.createMenu("Probefahrt", "Wähle ein Auto aus")
  return menu
end

nativeUI.createItem = function(name, model)
  -- Hier kommt die Native UI-Menü-Item-Erstellung hin
  -- Zum Beispiel:
  local item = nativeUI.createItem("Mein Auto", "mein_auto")
  return item
end

nativeUI.listenForEvent = function(event, callback)
  -- Hier kommt die Native UI-Event-Listener-Erstellung hin
  -- Zum Beispiel:
  menu:listenForEvent("select", function(item)
    -- Hier kommt die Funktion hin, wenn ein Item ausgewählt wird
  end)
end

return nativeUI
