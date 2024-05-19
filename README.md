# 👾 Scripts Seminario 🐧
En este proyecto reposan los scripts desarrollados para automatizar algunas tareas que se deben realizar en los servidores implementados en el seminario realizado.

Los script se pueden ejecutados en los siguientes sistemas operativos linux.
* Linux Ubuntu
* Linux centOS

A continuacion se detalla a nivel general lo que realizan los scripts.

## 📌 backup_DB.sh
Al realizar la ejecución de este script se realizara backup de una base de datos la cual se debe especificar al igual que la contraseña que tiene el usuario de BD para poder realizar dicha acción.
### 📋 NOTA:
Por seguridad no publicar este script con las contraseñas de base de datos que tenga en producción o que sean sensibles a ser publicadas.
Recuerde que para restaurar una BD desde un archivo backup puede ejecutar el siguiente comando.
```
mysql -u usuario -p exampledb < respaldo.sql
```

## 📌 installAgentOCSInventory.sh
Al realizar la ejecución de este script se realizara la instalación automática del agente de OCS Inventory, este script cuenta con un menú básico donde se preguntara en que distribución linux se desea instalar, es de aclarar que por el momento solo tiene habilitada la instalación en distribuciones Ubuntu y centOS.