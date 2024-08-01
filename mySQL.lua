local mysql = {}

mysql.connect = function(host, user, password, database)
  -- Hier kommt die MySQL-Verbindung hin
  -- Zum Beispiel:
  local db = mysql.connect("localhost", "dein_user", "dein_passwort", "deine_datenbank")
  return db
end

mysql.query = function(query, params)
  -- Hier kommt die MySQL-Abfrage hin
  -- Zum Beispiel:
  local result = mysql.query("SELECT * FROM cars", {})
  return result
end

return mysql
