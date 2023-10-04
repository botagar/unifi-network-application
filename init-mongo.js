 
db.getSiblingDB("unifi").createUser({user: "unifi", pwd: "<mongdb_pass>", roles: [{role: "readWrite", db: "unifi"}]});
db.getSiblingDB("unifi_stat").createUser({user: "unifi", pwd: "<mongdb_pass>", roles: [{role: "readWrite", db: "unifi_stat"}]});