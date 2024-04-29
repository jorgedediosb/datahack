PRÁCTICA MÓDULO 1: KUBERNETES

PASOS REALIZADOS:

1. IMÁGENES
    - Compilar imagen web y mongo desde la carpeta del proyecto:
        $ docker build -t web_practicadatahack:1 .
    - Etiquetar imagen:
        $ docker tag web_practicadatahack:1 web_practicadatahack:1
    - Descargar imagen mongo:
        $ docker pull mongo:4.0.7
    > Subir imágenes a Docker Hub:
        $ docker tag web_practicadatahack:1 jorgedb/web_practicadatahack:1
        $ docker push jorgedb/web_practicadatahack:1

2. CREACIÓN ARCHIVO YAML.
    Decido crear un solo archivo en vez de varios por:
    - Simplicidad: Gestionar un solo archivo me es mucho más sencillo.
    - APP pequeña: Esto es útil en aplicaciones pequeñas como la que queremos desplegar.
    - Facilidad de despliegue: Al tener todo en un solo archivo, el despliegue de la aplicación es más sencillo.

    · Creo el archivo deploy.yaml modificando el existente para generar el despliegue.

3. DEPLIEGUE.
- Asegurar que se usa entorno Docker en minikube:
    $ eval $(minikube docker-env)
- Iniciar Minikube y confirmar permisos de ejecución:
    $ minikube start
    $ sudo chmod +x $(which minikube)
- Confirmar instalación cliente kubernetes (kubectl):
    $ kubectl version
- Ejecutar archivo yaml de configuración en el clúster Minikube:
    $ kubectl apply -f deploy.yaml
- Confirmar estado del pod:
    $ kubectl get pods > debe estar en (running). Así:
        NAME                                    READY   STATUS    RESTARTS   AGE
        k8s-practicadatahack-7495cc9f6c-5m689   2/2     Running   0          17m

4. INTRODUCIR DATOS EN BD:
- Ver pod:
    $ kubectl get pods
- Acceder al contenedor de mongo:
    $ kubectl exec -it POD_NAME --container=mongodb -- /bin/bash
- Conectar a la base de datos testdb (se crea si no está creada):
    $ mongo testdb
- Mostrar la base de datos en donde estamos conectados:
        $ db
        > testdb
- Insertar datos:
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
        $ mongo testdb
        $ db.cars.find()
    · Salir del contenedor:
        $ exit
        $ exit

5. COMPROBACIÓN DEL EJERCICIO
Comprobar el ejercicio a través del IP minikube + puerto:
- Acceder a la app mediante la IP de Minikube:
    $ minikube service web-coches --url
    > ERROR: Saliendo por un error SVC_TUNNEL_START: error starting tunnel: creating ssh conn: lookup localhost: no such host
- Comprobar IP minikube
    $ minikube ip
    > url: https://192.168.58.2:7007/practica
    > ERROR: No se puede acceder a la web
- Mapear puertos con port forward:
    $ kubectl port-forward service/web-coches 7007:7007
    $ kubectl port-forward svc/web-coches https
    > url: https://localhost:7007/practica
    > ERROR: No se puede acceder a la web
- ver logs:
    $ kubectl get pods
    $ kubectl logs POD_NAME:
    > Parece que es un error con el archivo PracticaController.cs
        Microsoft.AspNetCore.HttpsPolicy.HttpsRedirectionMiddleware[3]
        Failed to determine the https port for redirect.
        fail: Microsoft.AspNetCore.Server.Kestrel[13]
        Connection id "0HN1E8HVQPOFJ", Request id "0HN1E8HVQPOFJ:00000003": An unhandled exception was thrown by the application.
        System.ArgumentNullException: Value cannot be null. (Parameter 'connectionString')
            at MongoDB.Driver.Core.Misc.Ensure.IsNotNull[T](T value, String paramName)
            at MongoDB.Driver.Core.Configuration.ConnectionString..ctor(String connectionString, Boolean isInternalRepresentation, IDnsResolver dnsResolver)
            at MongoDB.Driver.Core.Configuration.ConnectionString..ctor(String connectionString)
            at MongoDB.Driver.MongoUrlBuilder.Parse(String url)
            at MongoDB.Driver.MongoUrlBuilder..ctor(String url)
            at MongoDB.Driver.MongoUrl..ctor(String url)
            at MongoDB.Driver.MongoClientSettings.FromConnectionString(String connectionString)

- Borrar despliegue y servicio:
    $ kubectl delete service POD_NAME 
    $ kubectl delete deployment POD_NAME
    > confirmar borrado:
        $ kubectl get pods > no debería estar
        $ kubectl get services > no debería estar
    > Borrar archivo .yaml > $ kubectl delete -f FILE_NAME.yaml
- Cerrar minikube:
    $ minikube delete > Borra imágenes y cluster. 
    $ minikube stop

6. OBTENER INFORMACIÓN:
    - Info minikube:
        $ minikube status
    - Info Cluster:
        $ kubectl cluster-info
    - Verificar el estado del despliegue ejecutando:
        $ kubectl get pods
        $ kube ctl get all
    - Obtener nodos activos:
        $ kubectl get nodes
    - Obtener más información del estado del pod o nodo:
        $ kubectl describe pod POD-NAME
        $ kubectl describe node NODE_NAME
    - Obtener logs:
        $ kubectl logs POD_NAME
    - Información de los servicios:
        $ kubectl get services
    - Escalar replicas:
    $ kubectl scale deployment --replicas=2 POD_NAME
    > si se quiere cambiar las replicas, volver a ejecutar comando.
    - Minikube Dashboard:
        $ minikube dashboard


