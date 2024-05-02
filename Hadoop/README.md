PRÁCTICA HADOOP

# Ejercicio 1

**IMPORTACIÓN DATASETS**
- DESCARGA DATASETS
    - Repositorio: https://github.com/dgarciaesc/sample_dataset

- IMPORTACIÓN DATASETS A VIRTUALBOX/CLOUDERA
    - Con la herramienta 'File Manager' (menú 'Machine' -> Usuario=cloudera, Password=cloudera)

![importación](images/1.png)

- COMPROBAR DESCARGA Y CAMBIAR PERMISOS:
    $ ls /home/cloudera/dh-course/dataset_practica/
    $ chmod 777 movies.dat
    > cambiar en todos los datasets


**MSQL**
- CREAR DATABASE + TABLAS + CARGAR DATOS:
    - $ mysql -uroot -pcloudera
    - $ CREATE DATABASE practica_hadoop;
    - $ CREATE TABLE movies (MovieID INT PRIMARY KEY, Title VARCHAR(255), Genres VARCHAR(255));
    - $ LOAD DATA LOCAL INFILE '/home/cloudera/dh-course/dataset_practica/movies.dat' INTO TABLE movies FIELDS TERMINATED BY '::' LINES TERMINATED BY '\n';
    - $ select * from movies limit 5; -> Comprobar importación

![msql](images/2.png)

- Crear tablas 'users' y 'ratings' + importar datos:
	
    > $ CREATE TABLE users (UserID INT PRIMARY KEY, Gender CHAR(1), Age INT, Occupation INT, ZipCode VARCHAR(10));
    > $ LOAD DATA LOCAL INFILE '/home/cloudera/dh-course/dataset_practica/users.dat' INTO TABLE users FIELDS TERMINATED BY '::' LINES TERMINATED BY ‘\n’ (UserID, Gender, Age, Occupation, ZipCode);

    > $ CREATE TABLE ratings (UserID INT PRIMARY KEY, MovieID INT, Rating INT, Timestamp INT, FOREIGN KEY (UserID) REFERENCES users(UserID), FOREIGN KEY (MovieID) REFERENCES movies(MovieID));
    > $ LOAD DATA LOCAL INFILE '/home/cloudera/dh-course/dataset_practica/ratings.dat' INTO TABLE ratings FIELDS TERMINATED BY '::' LINES TERMINATED BY '\n' (UserID, MovieID, Rating, Timestamp);

    - Se crearán archivos .java en la carpeta desde importamos los datos a MySql 