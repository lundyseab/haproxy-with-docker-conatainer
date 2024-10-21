# Haproxy-with-Docker-Container

## Step1 
You need to setup ipvlan and static route this ipvlan network in your router and using your machine ip as gateway for this ipvlan network.
```bash
docker network create -d ipvlan --subnet 192.168.170.0/24 -o parent=eno8303 -o ipvlan_mode=l3 student_db
```

## Step 2
After created network, now you can run docker compose to setup docker containers server using the network that we just created by command below:
```bash
docker compose up -d
```

## Step 3
Restart ssh server in that conatiners, so we just can connect it with ssh using username: <code>ubuntu</code> and password: <code>Admin123</code>.

## Step 4
If you need to setup Haproxy for those container as you only have single Public IP, you can install Haproxy using command below:
```bash
sudo apt-get install haproxy
```
And using the Haproxy Configuration in the <code>haproxy_config.cfg</code> .

## Step 5
If you want to remove all containers that you just running with docker compose, you can run command below:
```bash
docker compose down
```
## Thank You!!