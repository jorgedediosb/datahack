#!/bin/bash

# Nombre del bucket S3
bucket_name="datahack-msg-bucket"

# Configurar la política de acceso público al archivo index.html
aws s3api put-object-acl \
    --bucket $bucket_name \
    --key index.html \
    --acl public-read

echo "El acceso público al archivo index.html se ha configurado correctamente."

