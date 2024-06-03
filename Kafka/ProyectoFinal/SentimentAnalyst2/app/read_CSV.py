import csv

# Nombre del archivo CSV y archivo de salida
csv_file = 'dataset.csv'
output_file = 'data.txt'

# Abrir el archivo de salida en modo adición
with open(output_file, 'a') as file:
    try:
        # Abrir el archivo CSV
        with open(csv_file, 'r', encoding='utf-8') as dataset_file:
            # Crear un lector CSV
            reader = csv.DictReader(dataset_file)
            # Leer cada fila del archivo CSV
            for row in reader:
                # Obtener el texto de la columna 'text' y limpiarlo
                text = row['text'].strip('"b').replace("\\", "")
                # Escribir el texto en el archivo de salida
                file.write(text + '\n')
    except FileNotFoundError:
        print(f"Error: Archivo '{csv_file}' no encontrado.")
    except Exception as e:
        print(f"Error: {e}")
