# comp520
Stuff for COMP 520

## Contents
The hw1 folder contains the ```docker-compose``` file for bringing up a postgres and pgadmin container.

## Usage
### To start and stop the containers
```bash
docker-compose up -d

docker-compose stop
```

### Log into pgAdmin4
pgAdmin ID: ```pgadmin4```

pgAdmin Password: ```admin```

### Create new server

![Connect to Server](resources/create_server.png)

General -> Name: ```postgres```

Connection -> Hostname / address: ```postgres```

Connection -> Username: ```postgres```

Connection -> Password: ```postgres```



### Use ```prune``` if the compose file doesn't take changes
```bash
docker volume prune
```