docker exec appwrite tar -czvf /storage/appwrite_backup.tar.gz /storage
docker cp appwrite:/storage/appwrite_backup.tar.gz .
