# SD2020A-final-project

## Integrantes del proyecto

* Ricardo Núñez - A00030132
* Felipe Jurado - A00328420
* Jorge Moreno - A00328088

## Proceso en general

Para la realización de la aplicación se definieron las siguientes tareas:
1. Desarrollo de base de datos MySQL en una RDS 
2. Desarrollo de microservicios en Back-End usando NodeJs
3. Desarrollo de pruebas para Back-End usando MochaJs
4. Desarrollo de Front-End usando Express
5. Construcción de imágenes de Docker para Front-End y Back-End 
6. Despliegue de la aplicación usando Kubernetes
7. Aprovisionamiento de servidor de CI con Jenkins en una EC2 usando Terraform
8. Gestión de la configuración del servidor de CI usando Ansible
---
### Desarrollo de microservicios en Back-End usando NodeJs

Primero se realiza la codificación de las dependencias para el funcionamiento del Back-End. Dentro de ellas está la conexión con la base de datos. Luego se define para el Back-End un endpoint que va a recibir peticiones por el puerto 8080.

![imagen 1](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ConnectionDB.PNG "Imagen 1. Conexión con base de datos")

Se realiza la codificación de dos microservicios para escritura y lectura de la base de datos.

![imagen 2](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/MicroservicesBackEnd.PNG "Imagen 2. Microservicios de lectura y escritura")


