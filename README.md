# SD2020A-final-project

## Integrantes del proyecto

* Ricardo Núñez - A00030132
* Felipe Jurado - A00328420
* Jorge Moreno - A00328088

## Proceso en general

Para la realización de la aplicación se definieron las siguientes tareas:
1. Desarrollo de base de datos MySQL en una RDS 
2. Desarrollo de microservicios en Back-End usando NodeJs
3. Desarrollo de pruebas para Back-End usando SuperAgent y Chai
4. Desarrollo de Front-End usando Express
5. Construcción de imágenes de Docker para Front-End y Back-End 
6. Despliegue de la aplicación usando Kubernetes
7. Aprovisionamiento de servidor de CI con Jenkins en una EC2 usando Terraform
8. Gestión de la configuración del servidor de CI usando Ansible
---
### Desarrollo de base de datos MySQL en una RDS

Se realiza la configuración de una RDS en AWS para gestionar una base de datos MySQL. La base de datos contiene una tabla de usuarios quienes poseen un ID y un nombre.

![imagen 1](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/DBStructure.PNG "Imagen 1. Estructura de la base de datos")

### Desarrollo de microservicios en Back-End usando NodeJs

Primero se realiza la codificación de las dependencias para el funcionamiento del Back-End. Dentro de ellas está la conexión con la base de datos que utiliza variables de entorno para el usuario, password, base de datos y host. Luego se define para el Back-End un endpoint que va a recibir peticiones por el puerto 8080.

![imagen 2](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ConnectionDB.PNG "Imagen 2. Conexión con base de datos")

Por último, se realiza la codificación de dos microservicios para escritura y lectura de la base de datos.

![imagen 3](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/MicroservicesBackEnd.PNG "Imagen 2. Microservicios de lectura y escritura")


### Desarrollo de pruebas para Back-End usando SuperAgent y Chai

Se realiza como primera prueba para comprobar la conexión con la base de datos en AWS.

![imagen 4](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/TestConnectionDB.PNG "Imagen 4. Test de conexión con base de datos")

Luego de haber comprobado la conexión, se procede a realizar las pruebas a los métodos que posee el Back-End para escritura y lectura de la base de datos.

![imagen 5](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/TestReadAndWriteBackEnd.PNG "Imagen 5. Test de microservicios de lectura y escritura")

### Desarrollo de Front-End usando Express

