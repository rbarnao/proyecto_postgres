# Parámetros de conexión
$psqlPath = "C:\Program Files\PostgreSQL\17\bin\psql.exe"  # Ajusta según tu versión y ruta
$pgHost = "localhost"
$port = "5432"
$user = "postgres"
$password = "3Wolf6Raven8"
$dbname = "pokemon_db"

# Consulta SQL que deseas ejecutar
$sql = "SELECT * FROM pokemons LIMIT 5;"

# Exportar la contraseña para que psql no la solicite interactivo
$env:PGPASSWORD = $password

# Ejecutar consulta
& "$psqlPath" -h $pgHost -p $port -U $user -d $dbname -c $sql