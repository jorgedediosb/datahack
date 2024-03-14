# NoSQL Datahack Lab

Repo to build virtual machine for NoSQL Module Lab of Datahack BigData Master Class

## Sofware
### Service versions
* mongoDB: 4.2
* neo4j: 3.5.8

## How to run
Access to root project folder and run:
```
$ docker-compose up -d
o
$ docker compose -f docker-compose.yaml up jupyter mongo -d
$ docker compose -f docker-compose.yaml up jupyter neo4j -d
> si sólo queremos esos servicios
```
Abrir jupyter:
en chrome:
http://localhost:8889/
en Safari:
http://127.0.0.1:8889

Abrir Browser Neo4j:
http://browser.graphapp.io
http://127.0.0.1:7474/browser/
http:127.0.0.1:7687
user: neo4j
pass: 1234
(en los notebook introducimos el user y pass)
```
To stop environment:
$ docker compose stop
$ docker compose down
```

