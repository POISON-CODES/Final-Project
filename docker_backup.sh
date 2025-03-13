#!/bin/bash

# Backup Appwrite Data
docker exec appwrite tar -czvf /storage/appwrite_backup.tar.gz /storage
docker cp appwrite:/storage/appwrite_backup.tar.gz .

echo "Backup completed: appwrite_backup.tar.gz saved."
