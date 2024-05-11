**EJERCICIO 1 - INSTALACIÓN KAFKA + PRODUCIR Y CONSUMIR MENSAJES**

**AWS**
Crear una máquina virtual en AWS:
● EC2:
    Ubuntu 22.04 LTS
    t3.medium
    VPC default
    Grupo de seguridad existente: default
    32 GB disco

**Instalar docker**
● Instalar docker (y el plugin compose) con las instrucciones oficiales (o usar Docker Desktop):
    https://docs.docker.com/engine/install/ubuntu/

● Meter al usuario “ubuntu” en el grupo “docker”:
    $ sudo usermod -aG docker $USER
    ○ Salir y volver a entrar

**Cluster kafka**
● Descargar “receta” docker-compose (archivo 'zk-simple-kafka-multiple.txt'):
    $ wget https://raw.githubusercontent.com/sergiokhayyat/kafka-exercise s/main/1.Environment/zk-simple-kafka-multiple.yml
    
    Usar si no funciona:
    $ curl -O https://raw.githubusercontent.com/sergiokhayyat/kafka-exercises/main/1.Environment/zk-simple-kafka-multiple.yml

● Arrancar cluster:
    $ docker compose -f zk-simple-kafka-multiple.yml up -d

**Ejemplo desde consola**
● Entrar en el contenedor kafka1
    $ docker exec -it kafka-broker-1 /bin/bash
● Producir mensajes
    $ kafka-console-producer --bootstrap-server kafka1:19092 --topic prueba
● Consumir mensajes
    $ kafka-console-consumer --bootstrap-server kafka1:19092 --topic prueba --from-beginning

> Hay que tener instalado docker