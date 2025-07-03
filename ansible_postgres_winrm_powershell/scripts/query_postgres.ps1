

$pgUser = "postgres"
$pgPassword = "3Wolf6Raven8"
$pgHost = "localhost"
$pgPort = "5432"
$pgDatabase = "pokemon_db"
$query = "SELECT * FROM pokemons;"

# Opcional: Establecer la variable de entorno PGPASSWORD para psql
# Esto es útil si no quieres pasar la contraseña directamente en el comando psql,
# pero asegúrate de que el usuario que ejecuta el script tenga los permisos adecuados
# para leer esta variable de entorno o que se establezca justo antes de psql.
# $env:PGPASSWORD = $pgPassword

# Ruta completa al ejecutable psql.exe
# Ajusta esta ruta según tu instalación de PostgreSQL
$psqlPath = "C:\Program Files\PostgreSQL\17\bin\psql.exe" # Ejemplo para PostgreSQL 16

# Verifica si psql.exe existe
if (-not (Test-Path $psqlPath)) {
    Write-Error "El ejecutable de psql no se encontró en la ruta: $psqlPath. Por favor, verifica la ruta."
    exit 1
}

# Construye el comando psql
# Usamos -c para la consulta y -tAq para solo obtener los datos de la primera columna sin cabeceras ni formato.
# Puedes ajustar esto según el formato de salida que necesites.
# -A: No-align (unaligned output)
# -t: Tuples-only (print only rows, no header, footer, etc.)
# -q: Quiet (no messages like "SET")
$command = "& `"$psqlPath`" -h $pgHost -p $pgPort -U $pgUser -d $pgDatabase -c `"$query`" -tAq"

# Ejecuta el comando y captura la salida
try {
   $result = Invoke-Expression $command

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Error al ejecutar la consulta SQL. Código de salida: $LASTEXITCODE"
        Write-Error "Salida de error: $result"
        exit 1
    }

    Write-Host "Consulta exitosa. Resultado:"
    Write-Host $result

} catch {
    Write-Error "Ocurrió un error al ejecutar el comando psql: $($_.Exception.Message)"
    exit 1
}