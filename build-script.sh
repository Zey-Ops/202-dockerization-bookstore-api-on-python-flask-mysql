#! /bin/bash
#updateing docker in the instance
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker 
sudo usermod -a -G docker ec2-user
#downloading docker-compose in the instance
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

TOKEN="xxxxxxxxx"
FOLDER="https://$TOKEN@raw.githubusercontent.com/Zey-Ops/202-dockerization-bookstore-api-on-python-flask-mysql/main/docker-compose.yml"
curl -s --create-dirs -o "/home/ec2-user/bookstore-api/bookstore-api.py" -L "$FOLDER"bookstore-api.py
curl -s --create-dirs -o "/home/ec2-user/bookstore-api/requirements.txt" -L "$FOLDER"requirements.txt
curl -s --create-dirs -o "/home/ec2-user/bookstore-api/Dockerfile" -L "$FOLDER"Dockerfile
curl -s --create-dirs -o "/home/ec2-user/bookstore-api/docker-compose.yml" -L "$FOLDER"docker-compose.yml
cd /home/ec2-user/bookstore-api
docker build -t zey/bookstore-api:latest .
docker-compose up -d
