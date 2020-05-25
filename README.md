## Proyecto Final Sistemas Distribuidos 2020-1
---
## Integrantes del proyecto

* Ricardo Núñez - A00030132
* Felipe Jurado - A00328420
* Jorge Moreno - A00328088
---
## Objetivos del proyecto
- Diseñar la arquitectura de un sistema distribuido que implemente un conjunto de microservicios, considerando las implicaciones técnicas asociadas con su escalabilidad, tolerancia a fallos y concurrencia, y las mejoras en el desempeño a través de la asignación o reasignación de los recursos y tareas.

- Desplegar un sistema distribuido, teniendo en cuenta las estrategias de administración de sus recursos consideradas en el diseño.

- Gestionar el servicio distribuido, haciendo uso de herramientas de monitoreo y aprovisionamiento.
---
## Proceso en general
Como decisión de equipo, hemos decidido hacer uso de Trello, esto con el fin de llevar un mayor orden de cada una de las tareas que se deben hacer para la implementación del proyecto. Adicionalmente, en la aplicación de Trello, se agruparon segun si corresponde a front-end, back-end o al despliegue de la infraestructura. Y a medida que se iban realizando y se iban terminando cada una de las tareas se iban moviendo cada una de las tareas a la columna de finalizada.

A continuación se definieron las siguientes tareas:

1. Desarrollo de base de datos MySQL en una RDS 
2. Desarrollo de microservicios en Back-End usando NodeJs
3. Desarrollo de pruebas para Back-End usando SuperAgent y Chai
4. Desarrollo de Front-End usando Express
5. Construcción de imágenes de Docker para Front-End y Back-End 
6. Despliegue de la aplicación usando Kubernetes
7. Aprovisionamiento de servidor de CI con Jenkins en una EC2 usando Terraform
8. Gestión de la configuración del servidor de CI usando Ansible
9. Desarrollo de archivos de Jenkins para CI en Front-End y Back-End
10. Validación de funcionamiento de Pipeline de CI en Back-End
---
## Infraestructura de la solución

A continuación se presenta la infraestructura de la solución implementada, en donde de manera general se puede observar que se encuentran los contenedores tanto para el frontend como para el backend, y adicionalmente la base de datos que elegimos que corresponde a AWS RDS y finalmente el uso de kubernetes para la orquestación de los contenedores:

Diagrama de la infraestructura

 ![imagen 0](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/Infrastructure.png "Imagen 0. Diagrama de la infraestructura implementada")


---
### Desarrollo de base de datos MySQL en una RDS

Se realiza la configuración de una RDS en AWS para gestionar una base de datos MySQL. La base de datos contiene una tabla de usuarios quienes poseen un ID y un nombre. En la siguiente imagen, podemos observar que efectivamente se encuentra creada la tabla users con los campos id y nombre.

Estructura de la base de datos

![imagen 1](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/DBStructure.PNG "Imagen 1. Estructura de la base de datos")

### Desarrollo de microservicios en Back-End usando NodeJs

Primero se realiza la delcaración de las dependencias para el funcionamiento del Back-End. Dentro de ellas está la conexión con la base de datos que utiliza variables de entorno para el usuario, password, base de datos y host. Luego se define para el Back-End un endpoint que va a recibir peticiones por el puerto 8080.

Conexión con la base de datos

![imagen 2](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ConnectionDB.PNG "Imagen 2. Conexión con base de datos")

Por último, se realiza la codificación de dos microservicios para escritura y lectura de la base de datos. En el microservicio correspondiente a la lectura, se encarga de obtener los datos de la tabla users creada previamente, y me retorna todos los usuarios de la tabla. Y por el otro lado, en el correspondiente a la escritura, se encarga de ingresar los datos, tanto del id como del nombre y realiza la sentencia SQL necesaria para ingresarlos a la tabla users.

Microservicios de lectura y escritura

![imagen 3](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/MicroservicesBackEnd.PNG "Imagen 3. Microservicios de lectura y escritura")


### Desarrollo de pruebas para Back-End usando SuperAgent y Chai

Se realiza como primera prueba la comprobación de la conexión con la base de datos en AWS.

Test de conexión con la base de datos

![imagen 4](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/TestConnectionDB.PNG "Imagen 4. Test de conexión con base de datos")

Luego de haber comprobado la conexión, se procede a realizar las pruebas a los métodos que posee el Back-End para lectura y escritura de la base de datos.

Test de microservicios de lectura y escritura

![imagen 5](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/TestReadAndWriteBackEnd.PNG "Imagen 5. Test de microservicios de lectura y escritura")

### Desarrollo de Front-End usando Express

Para el consumo de los servicios del Back-End se define un servidor web que ofrece sus servicios por el puerto 80. Este servidor va a operar usando el módulo express de NodeJs.

Definición de puerto para Front-end

![imagen 6](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/InitalizationPortFrontEnd.PNG "Imagen 6. Definición de puerto para Front-End")

El servidor ofrece dos tipos de servicios. El primero muestra gráficamente en una página web los datos que contiene la tabla usuarios de la RDS. El segundo ofrece ingresar un nuevo usuario, dado un ID y un nombre, en la tabla usuarios.

Endpoint GET para visualización de usuarios

![imagen 7](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/GetEndPointFrontEnd.PNG "Imagen 7. Endpoint GET para visualización de usuarios")

Endpoint POST para ingreso de nuevos usuarios

![imagen 8](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/PostEndPointFrontEnd.PNG "Imagen 8. Endpoint POST para ingreso de nuevos usuarios")

### Construcción de imágenes de Docker para Front-End y Back-End

Primeramente se realiza la respectiva instalación y creación de la cuenta en DockerHub como se adjunta en la referencia de la bibliografia. El procedimiento a llevar a cabo, sera que por medio de dos archivos DockerFile, uno para el back-end y otro para el front-end, realizaremos la creción de la imagen de cada una de los dos y posteriormente se subiran dichas imagenes a la cuenta de DockerHub, esto con el objetivo de posteriormente realizar el aprovisionamiento en kubernetes haciendo el llamado de dichas imagenes, en donde se realizara el despliegue en contenedores del codigo.

En este caso tanto el Front-End como el Back-End tienen la misma estructura en su archivo de Docker.

Archivo de Docker para Front-end y Back-end

![imagen 9](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/DockerFileBackFront.PNG "Imagen 9. Archivo Docker para Front-End y Back-End")

Este archivo comienza con una imagen base de Node, que corresponde al FROM. Luego con el WORKDIR se define el directorio donde se está ubicando dentro del contenedor. El COPY nos permite copiar archivos del sistema a una ruta específica dentro del contenedor,  el cual va a contener el código fuente correspondiente de Back-End ó Front-End. Finalmente, RUN ejecuta un binario instalado en el contenedor, en este caso se usa npm install, pero puede ser cualquier otro binario. Se instala NPM para el manejo de dependencias del código fuente y por ultimo, el CMD, por lo general es el último comando y es el que se va a ejecutar siempre que se inicie el contenedor. Se ejecuta el artefacto index por medio del módulo de NodeJs en el contenedor.

### Despliegue de la aplicación usando Kubernetes
En esta sección se realiza la respectiva instalación y ciertas configuraciones de kuberentes para lograr posteriormente realizar el despliegue y aprovisionamiento, en donde explicaremos los archivos creados para realizar dicho labor.

Como primera parte se realiza la instalación y configuración de kubernetes con los siguientes comandos:

```bash
sudo curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

#Instalar consola de aws
sudo pip install --upgrade awscli && hash -r

#Librerias adicionales
sudo yum -y install jq gettext bash-completion

#Configuración kubernetes
kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion

#Creamos la llave de accesso
ssh-keygen
aws ec2 import-key-pair --key-name "eksworkshop" --public-key-material file://~/.ssh/id_rsa.pub


#Ahora si lanzamos kubernetes
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin

#Chequeamos la version para verificar si trabaja correctamente
eksctl version

#Habilitamos el eksctl
eksctl completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion

```

Ya con esto comenzamos a escribir el script que se encargara de desplegar la infraestructura necesaria para nuestra arquitectura basada en microservicios.Comenzamos con el deployment.yml del back end en el cual definimos que cluster vamos a desplegar, el label del mismo, las replicas que necesitamos y el container que utilizaremos como la imagen de docker y el puerto que este utilizara. A contianuación se muestra el script anteriormente mencionado:

Archivo Deployment.yml

![imagen 9.1](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/Deployment.yml.PNG "Imagen 9.1. Archivo Deployment.yml")

Ahora en el archivo service.yml definimos el balanceador de carga que estara gestionado con kubernetes. En la siguiente imagen podemos observar el procedimiento para el Back-end, y es importante mencionar que es el mismo codigo para el Front-end.

Archivo Service.yml

![imagen 9.2](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/Service.yml.PNG "Imagen 9.2. Archivo Service.yml")

Ahora ya podemos darle correr a nuestro aprovisionamiento con kubernetes.

Podemos ubicarnos en la carpeta de back-end-kubernetes/kubernetes y ejecutar el siguiente comando:

```bash
eksctl create cluster -f deployment.yaml

kubectl apply -f kubernetes/deployment.yaml

kubectl apply -f kubernetes/service.yaml
```
Luego ejecutaremos lo mismo en la carpeta front-end-kubernetes/kubernetes:

```bash
eksctl create cluster -f deployment.yaml

kubectl apply -f kubernetes/deployment.yaml

kubectl apply -f kubernetes/service.yaml

```

Y en estos momento ya se encuentra desplegado nuestro cluster. A continuación podremos observar el despliegue de dichos archivos y posteriormente el dashboard desde kubernetes que me permite observar las instancias de los contenedores y otros valores de la infraestructura.

Dashboard 

![imagen 9.3](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ "Imagen 9.3. Dashboard")

### Aprovisionamiento de servidor de CI con Jenkins en una EC2 usando Terraform

Al usar Terraform se define el proveedor para el aprovisionamiento de la infraestructura, el cual es AWS para este caso.

Provedor AWS para Terraform

![imagen 10](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ProvisioningProvider.PNG "Imagen 10. Proveedor AWS para Terraform")

Una vez definido el proveedor, se establecen variables para que sean reutilizadas en varios recursos de las plantillas de Terraform. Dentro de ellas se encuentra el ID de la AMI y la VPC donde va a ser desplegada la EC2.

Variables globales en Terraform

![imagen 11](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ProvisioningVariables.PNG "Imagen 11. Variables globales en Terraform")

Luego se establece un Security Group, encargado de habilitar el tráfico entrante SSH hacia la EC2 para gestionar la configuración del servidor. Adicionalmente, se agrega una regla para que el servidor pueda responder a cualquier host que requiera de sus servicios.

Reglas de seguridad para servidor CI

![imagen 12](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ProvisioningSG.PNG "Imagen 12. Reglas de seguridad para servidor CI")

Finalmente se establece que se aprovisione una EC2 en donde se define principalmente su AMI, el tipo, la VPC donde va a estar, las llaves para establecer conexión via SSH, un script para gestionar su configuración y las reglas del Security Group.

Aprovisionamiento de una EC2

![imagen 13](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ProvisioningEC2.PNG "Imagen 13. Aprovisionamiento de una EC2")

### Gestión de la configuración del servidor de CI usando Ansible

Una vez que la EC2 se encuentra aprovisionada, se gestiona la configuración necesaria para instalar y ejecutar el servidor Jenkins por medio de Ansible. En el servidor se desarrolla un pipeline para la integración continua de los repositorios de Back-End y Front-End.

Gestion de la configuración para el servidor de Jenkins

![imagen 14](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/ConfMagamentAnsibleEC2.PNG "Imagen 13. Gestión de la configuración para el servidor de Jenkins")

### Desarrollo de archivos de Jenkins para CI en Front-End y Back-End

Para lograr que el pipeline de Integración continua se ejecute en los repositorios de Front-End y Back-End, es necesario definir un archivo Jenkins en cada repositorio. Este archivo va a ser el mismo para cada uno de los repositorios.

Archivo Jenkins para proceso de Integración Continua en repositorios de Front-end y Back-end

![imagen 15](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/JenkinsFileBackFront.PNG "Imagen 15. Archivo Jenkins para proceso de Integración continua en repositorios de Front-End y Back-End")

Dentro de la composición del archivo, se comprenden los siguientes pasos:

1. Chequeo de una de las ramas del repositorio en GitHub que se esté consultando.
2. Instalación de NodeJs en la EC2.
3. Ejecución del archivo de pruebas, hecho en NodeJs. 

### Validación de funcionamiento de Pipeline de CI en Back-End

Finalmente se comprueba la ejecución exitosa del pipeline de integración continua para el repositorio de Back-End, como se muestra a continuación. En este se ejecutan cada uno de los pasos definidos en el archivo Jenkins.

Prueba de Pipeline de CI para Back-end

![imagen 16](https://github.com/RicNuva18/SD2020A-final-project/blob/master/images/TestCIBackEnd.PNG "Imagen 16. Prueba de pipeline de CI para Back-End")
---
## Errores que ocurrieron en el desarrollo del aplicativo

Entre los errores que ocurrieron al desarrollar esta aplicación, se encuentran:

* Ejecución del archivo de pruebas en el pipeline de integración continua, el cual se debia a una variable de entorno que no estaba definida para conectarse con la base de datos. Para su solución, se establece una conexión via SSH hacia la EC2 y se hace uso del comando export para definir la variable faltante.

## Conclusiones

- El despliegue utilizando kubernetes nos permitio tener una infraestructura de alta disponibilidad y de mejor alcance que incluso con maquinas virtuales las cuales tomarian mucho mas tiempo para ser configuradas,teniendo en cuenta, adicionalmente que los contenedores, a comparación de las maquinas virtuales son mucho mas versatiles,eficientes, entre otras caracteristicas.

- La utilización de docker para empaquetar en una imagen la configuración de un contenedor mejora exponecialmente, que configurarla mediante ansible o saltstack, ya que eso involucra un tiempo adicional en la descarga de paquetes e instalación.

- Kubernetes nos permitio desplegar un dashboard que no necesita software adicional para ser gestionado nuestra infraestructura con balanceadores de carga. Además, el dashboard nos permite poder monitoriar las diferentes caracteristicas de nuestra infraestructura

- El lenguaje utilizado tanto para el front-end como para el back-end, el cual corresponde a Nodejs nos trae beneficios como es lograr expandir nuestro codigo añadiendo diferentes modulos de una manera facil y adicionalmente, el recurrente uso de Nodejs en el campo laboral, nos permite reconocer la importancia de tener conocimiento de dicho lenguaje.

- La integración continua es un claro ejemplo que facilita a los desarrolladores la forma de integrar el codigo con sus repositorio remoto utilizando Jenkins


## Referencias bibliograficas
- https://eksworkshop.com/020_prerequisites/k8stools/
- https://www.hostinger.co/tutoriales/como-instalar-y-usar-docker-en-ubuntu/
- https://ricardogeek.com/todo-sobre-los-jenkins-pipelines/
- https://kubernetes.io/docs/tutorials/


