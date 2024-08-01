-- MySQL-Konfiguration
local mysql = {
  host = "localhost",
  user = "dein_user",
  password = "dein_passwort",
  database = "deine_datenbank"
}

-- Native UI-Konfiguration
local nativeUI = {
  title = "Testfahrt",
  subtitle = "Wähle ein Auto aus"
}

-- Funktion, um Autos aus der Datenbank zu laden
local function loadCars()
  local cars = {}
  local query = "SELECT * FROM cars"
  local result = mysql.query(query)
  for _, row in ipairs(result) do
    table.insert(cars, {
      id = row.id,
      name = row.name,
      model = row.model
    })
  end
  return cars
end

-- Funktion, um ein Auto zu spawnen
local function spawnCar(car)
  local vehicle = GetHashKey(car.model)
  RequestModel(vehicle)
  while not HasModelLoaded(vehicle) do
    Wait(0)
  end
  local ped = GetPlayerPed(-1)
  local coords = GetEntityCoords(ped)
  local heading = GetEntityHeading(ped)
  local vehicle = CreateVehicle(vehicle, coords.x, coords.y, coords.z, heading, true, false)
  SetVehicleNumberPlateText(vehicle, car.name)
  SetVehicleEngineOn(vehicle, true, true)
  return vehicle
end

-- Funktion, um das Auto zu bewerten
local function rateCar(car)
  -- Hier kommt die Bewertungsfunktion hin
  -- Zum Beispiel:
  local rating = 5
  local query = "UPDATE cars SET rating = ? WHERE id = ?"
  mysql.query(query, {rating, car.id})
end

-- Funktion, um das Auto zu löschen und den Spieler zurück zum Ausgangspunkt zu teleportieren
local function deleteCar(vehicle)
  DeleteVehicle(vehicle)
  local ped = GetPlayerPed(-1)
  SetEntityCoords(ped, 0, 0, 0)
end

-- Hauptfunktion
local function testDrive()
  local cars = loadCars()
  local menu = nativeUI.createMenu(nativeUI.title, nativeUI.subtitle)
  for _, car in ipairs(cars) do
    local item = nativeUI.createItem(car.name, car.model)
    menu:addItem(item)
  end
  menu:listenForEvent("select", function(item)
    local car = item.data
    local vehicle = spawnCar(car)
    -- 50 Sekunden Timer
    Citizen.CreateThread(function()
      Wait(50000)
      deleteCar(vehicle)
    end)
    -- Bewertungsfunktion
    Citizen.CreateThread(function()
      rateCar(car)
    end)
  end)
end

-- Starte das Script
testDrive()
