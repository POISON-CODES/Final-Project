


#!/bin/bash

# Backup Appwrite Data
docker cp appwrite_backup.tar.gz appwrite:/storage/
docker exec appwrite tar -xzvf /storage/appwrite_backup.tar.gz -C /

echo "Backup completed: appwrite_backup.tar.gz saved."
