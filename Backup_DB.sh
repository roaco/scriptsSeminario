#!/bin/bash

# Intentamos crear el directorio de backups. Si ya existe, no hacemos nada.
mkdir -p "$BACKUP_DIR" || echo "Directorio de backups ya existe: $BACKUP_DIR"
#Contarseña usuario root
MYSQL_PASSWORD="*****"
DATE=$(date +%d-%m-%Y)
#Ruta donde se guardara nuestro backup
BACKUP_DIR="/backup/db-backup"
#Nombre de la BD a realziar backup
DB=testdb
echo $DB
mysqldump -u root -p$MYSQL_PASSWORD $DB | gzip -9 > "$BACKUP_DIR/testdb-$DATE.sql.gz"
find $BACKUP_DIR/* -mtime +5 -exec rm {} \;