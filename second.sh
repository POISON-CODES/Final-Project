docker cp appwrite_backup.tar.gz appwrite:/storage/
docker exec appwrite tar -xzvf /storage/appwrite_backup.tar.gz -C /
