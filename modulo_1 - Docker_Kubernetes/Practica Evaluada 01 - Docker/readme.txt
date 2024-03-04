PRÁCTICA MÓDULO 1: DOCKER

PASOS REALIZADOS:

1. INICIAR DOCKER DESKTOP.

2. COMPROBACIÓN DOCUMENTACIÓN PROYECTO:
    2.1. Descargo 'Proyecto PracticaEval01' en .NET
    2.1. Cambio en archivo 'dockerfile' donde indica 'pr6' por 'PracticaEval01' para que se lean los archivos.
    2.2. Construyo la imagen 'web_practicadatahack' desde el dockerfile y descargo la de 'mongoDB' para comprobar su funcionamiento:
        $ docker build -t web_practicadatahack:1 .
        $ docker pull mongo:4.0.7 > Descarga con la versión pedida.

    2.3. Compruebo las vulnerabilidades de las imágenes en Docker Desktop y encuentra:
        · En la imagen 'web':
            - MongoDB.Driver 2.15.1.0 - CVE-2022-48282 > CVSS Score: 7.2. Riesgo alto!
        · En la imagen 'mongoDB':
            - ubuntu/openssl 1.0.2g-1ubuntu4.15 - CVE-2020-1971 > CVSS Score: 5.9. Riesgo Alto!
        > No tengo claro como solucionarlo!
    

3. MODIFICACIÓN DOCKERFILE:

    3.1. EXPOSICIÓN PUERTO:
        · Expongo el puerto 7007 indicando 'EXPOSE 7007'
        > Es algo informativo pero creo útil cambiarlo.

    3.2. CONTROL DE VERSIONES Y ENTORNO:
        · Añado argumento, etiqueta y variable de entorno para la 'Version'.
        > Al construir la imagen se podrá pasar como argumento la versión específica de la imagen de la app.

        · Añado argumento y variable de entorno para el 'Entorno'.
        > Al construir la imagen se podrá pasar como argumento el entorno específico en el que estamos trabajando.
        > No indico un 'Label' porque pasaremos la versión para que aparezca en la imagen como 'Tag'.

        > Esto permite ejecutar etiquetas dinámicas sin modificar el código.
        > La versión y el entorno se verán reflejados al comprobar la app en su url:
            {"version":"versión_deseada","entorno":"entorno_deseado" ...}

    3.4. INTENTO (FALLIDO) ACCESO HTTPS: 
        · Compruebo los logs de cada contenedor:
            $ docker logs ID-CONTAINER
            > Aparece el warning:
                Microsoft.AspNetCore.HttpsPolicy.HttpsRedirectionMiddleware[3]
                Failed to determine the https port for redirect.
        
        · Sigo las instrucciones de https://learn.microsoft.com/es-es/aspnet/core/security/docker-compose-https?view=aspnetcore-8.0 
            . Creo certificado:
                $ dotnet dev-certs https -ep ${HOME}/.aspnet/https/aspnetapp.pfx -p $CREDENTIAL_PLACEHOLDER$
                $ dotnet dev-certs https --trust
            · Creo variables y volumen en docker-compose servicio 'web':
                environment:
                    ASPNETCORE_ENVIRONMENT: Development
                    ASPNETCORE_URLS: https://+:7007;http://+:7006
                    ASPNETCORE_Kestrel__Certificates__Default__Password: password
                    ASPNETCORE_Kestrel__Certificates__Default__Path: /https/aspnetapp.pfx
                volumes:
                  - ~/.aspnet/https:/https:ro
        Anteriormente intenté:
        · En https://docs.docker.com/engine/swarm/secrets/ sección 'Configure the Nginx container' donde usan secretos con https.
            · Intento añadir un secreto tal como aparece en la pg.120 del pdf de Datahack.
        · Validar un certificado HTTPS al leer el artículo:
            https://medium.com/@hernan.garavaglia/alojar-una-aplicación-asp-net-sobre-docker-con-https-eebe001b9f62

        > NO LOGRO QUE SE EJECUTE EN https://localhost:7007/practica

4. CREACIÓN ARCHIVO DOCKER-COMPOSE.YAML
    4.1. Version:
        · Indico la '3.8' por ser última versión de docker-compose según se indica en:
          https://docs.docker.com/compose/compose-file/compose-file-v3/
    
    4.2. Servicios 'web' y 'mongodb' (base de datos):

        - Construcción (build):
            · En 'web' indico la ruta y el nombre desde donde se construirá la imagen:
                context: . > ruta actual.
                dockerfile: Dockerfile > Nombre del archivo.
                Entorno=${Entorno} > Argumento para el entorno cuando se ejecute. En el dockerfile un error.

        - Nombre de la imagen y nombre del contenedor:
            · En mongodb indico la versión que se pidió descargar y el nombre que quiero del contenedor:
                mongo:4.0.7
            · En web indico el nombre de la imagen y contendor. Para la versión indico la variable para que se modifique al ejecutar:
                web_practicadatahack:${Version}

        -  Redes:
            · Añado la red 'mynetwork' en los servicios y fuera de ellos para evitar que que se cree una red 'default'.
            > Esto conecta los contenedores de los servicio en una única red.
            > Podrían crearse 2 redes, una para el back y otra para el front en donde front y back están en la misma.
        
        - Volúmenes:
            · Añado en mongo el volumen y la ruta donde irán los datos:
                mongodb-volume:/data/db
            > El volumen está enlazo al directorio '/data/db' para que los datos se almacenen fuera del contenedor y persistan.
            > Si se borran los contenedores, los datos seguirán estando en el volumen.

        - Puertos:
            · Mongodb: 27017:27017
                > En hub.docker.com/mongo indica:
                'The MongoDB server in the image listens on the standard MongoDB port 27017'
            · Web: 7007:7007 para alinearlo a la configuración del dockerfile.

        - Deploy
            · Despliego los contenedores y compruebo las 'estadísticas':
                $ docker run -d ID-CONTAINER
                $ docker stats
                > Indica:
                CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O         PIDS
                d21831beed62   web       0.01%     72.35MiB / 7.659GiB   0.92%     253kB / 174kB   0B / 0B           22
                ef1ef218b320   mongodb   0.65%     96.09MiB / 7.659GiB   1.23%     171kB / 246kB   23.8MB / 6.13MB   29
        
            · Añado los 'deploy' en servicio web y en servicio 'mongodb' con valores típicos.

        - Variables de entorno (environment):
            En el servicio 'web':
                Version: ${Version} > Para que se muestre la versión que usará del servicio (igual que el dockerfile).
                Entorno: ${Entorno} > Para que se muestre el entorno que usará del servicio (igual que el dockerfile).
                MONGODB_CONNECTION: mongodb://mongodb:27017 > Para conectar el servicio web a mongodb
            En el servicio 'mongodb':
                MONGO_DATABASE: mongodb > Define el nombre de la base de datos que se creará
                MONGO_USER: jorgedb > Nombre con el usurio que tendrá acceso a la base de datos.
                MONGO_PASSWORD_FILE: /secrets/mongodb_password > Secreto con clave de usuario 'normal'.
                MONGO_ROOT_PASSWORD_FILE: /secrets/mongodb_root_password  > Secreto con clave de usuario 'root'.
                
        - Añado la depenencia de 'web' a la base de datos (mondogb):
            depends_on:
                - mongodb
   
        - Secretos:
            · Creo archivos para los secretos dentro de la carpeta 'secrets':
                . mondodb_password.txt
                · mondodb_root_password.txt
            · Añado los secretos 'mondodb' al servicio mongo y el server-certificate al servicio 'web'.
            · Compruebo los secretos una vez 'desplegado' el ejercicio con:
                $ docker exec -it mongodb-container cat /run/secrets/db_password
                $ docker exec -it mongodb-container cat /run/secrets/db_root_password
                $ docker exec -it web-container cat /run/secrets/server-certificate

5. CREACIÓN ARCHIVO .DOCKERIGNORE:
    · Creo el archivo y añado los archivos/carpetas que no quiero que se ejecuten:
        /bin > Carpeta 'bin' del proyecto.
        /obj > Carpeta 'obj' del proyecto.
        .DS_Store > archivo oculto de apple (por si se ha creado).

6. MODIFICACIÓN ARCHIVO CONTROLLERS/PRACTICACONTROLLER.CS:
    > Necesario para que las variables 'dbClient', 'Version' y 'Entorno' se ejecuten.
    - Añado para cada variable:
        var version = Environment.GetEnvironmentVariable("Version") ?? "sin definir";
        var entorno = Environment.GetEnvironmentVariable("Entorno") ?? "sin definir";
        var dbClient = new MongoClient(Environment.GetEnvironmentVariable("MONGODB_CONNECTION"));
    
7. COMPROBACIÓN:
    · Ejecutar y correr el ejercicio desde su carpeta:
        $ Version=x.x.x Entorno=xxxx docker compose build
        $ Version=x.x.x Entorno=xxxx docker compose up -d > Si se quiere directamente 'lanzar' todo.

    · Acceder a http://localhost:7007/practica
        > o indicar IP en vez de 'localhost':
            $ ipconfig getifaddr en0
        > Debe aparecer la versión, el entorno y los datos introducidos en la base de datos mongo.
        > {"version":"x.x.x","entorno":"xxxx","list":[[{"name":"_id","value":"xxxxx"},],]}

8. INTRODUCIR DATOS EN BD: 
    · Identificar la ID del contenedor y entrar en él:
        $ docker ps
        $ docker exec -it ID-CONTAINER-MONGO bash 
    · Conectar a la base de datos testdb (se crea si no está creada):
        $ mongo testdb
    · Mostrar la base de datos en donde estamos conectados:
        $ db
        > testdb
    · Insertar datos:
        $ db.cars.insert({name: "Audi", price: 52642})
        $ db.cars.insert({name: "Mercedes", price: 57127})
        $ db.cars.insert({name: "Skoda", price: 9000})
        $ db.cars.insert({name: "Volvo", price: 29000})
        $ db.cars.insert({name: "Bentley", price: 350000})
        $ db.cars.insert({name: "Citroen", price: 21000})
        $ db.cars.insert({name: "Hummer", price: 41400})
        $ db.cars.insert({name: "Volkswagen", price: 21600})

        o directamente:
        $ mongo testdb --eval 'db.cars.insertMany([
        {name: "Audi", price: 52642},
        {name: "Mercedes", price: 57127},
        {name: "Skoda", price: 9000},
        {name: "Volvo", price: 29000},
        {name: "Bentley", price: 350000},
        {name: "Citroen", price: 21000},
        {name: "Hummer", price: 41400},
        {name: "Volkswagen", price: 21600}
        ])'

    · Comprobar datos ingresados:
        $ db.cars.find()
    · Salir del contenedor:
        $ exit
    · Acceder a http://localhost:7007/practica y comprobar datos introducidos.

9. EXPORTACIÓN E IMPORTACIÓN:
    · Acceso en Docker Hub y verificación autenticación:
        > Debes tener cuenta en Docker Hub
        $ docker login
        $ docker info
    · Añadir etiqueta con mi nombre de usuario:
        $ docker images
        $ docker tag web_practicadatahack:1 jorgedb/web_practicadatahack:1
    · Subir la imagen etiquetada al repositorio en Docker Hub:
        $ docker push jorgedb/web_practicadatahack:1
        > o subir una nueva versión.
    · Verificar que se ha subido la imagen en hub.docker.com:
        Desde la terminal:
            $ Docker images > Aparece la imagen con el nombre de usuario (jorgedb/web_practicadatahack)
            $ docker search jorgedb/web_practicadatahack (o la imagen que sea)
    · Importar imágenes:
        $ docker pull jorgedb/web_practicadatahack:1
    · Exportar imágenes:
        $ docker save web_practicadatahack -o web_practicadatahack.tar

10. ELIMINAR IMÁGENES, CONTENEDORES  Y VOLÚMENES
    · Detener ejecución contenedores:
        $ docker stop ID-CONTAINER  ID-CONTAINER-MONGO
        $ docker compose stop
    · Eliminar contenedores:
        $ docker rm ID-CONTAINER-WEB ID-CONTAINER-MONGO
    · Eliminar volúmenes:
        $ docker volume rm ID-VOLUME-WEB ID-VOLUME-MONGO
    · Eliminar imágenes:
        $ Docker rmi ID_IMAGE