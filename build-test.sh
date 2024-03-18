#!/bin/bash
# build the docker image
docker build -t my-django-app  -f demo-app/Dockerfile demo-app/
# export the environment variable
export ENVIRONMENT=$1
export DJANGO_SECRET_KEY=$2

# run the docker container in development mode
docker run --name=devsu -d -p 8000:8000 my-django-app 
# wait for the server to start
sleep 5
# test the server
# curl command to generate a random user dni and name in the database; example curl -X POST -H "Content-Type: application/json" -d '{"dni":"your_dni", "name":"your_name"}' http://localhost:8000/api/users/
# 1. Generate a random dni
dni=$(cat /dev/urandom | tr -dc '0-9' | fold -w 8 | head -n 1)
# 2. Generate a random name
name=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 8 | head -n 1)
# 3. Insert the random dni and name in the database
insert=$(curl -sX POST -H "Content-Type: application/json" -d '{"dni":"'$dni'", "name":"'$name'"}' http://localhost:8000/api/users/)
# get all users
get=$(curl -sX GET http://localhost:8000/api/users/)
# parse the users to find the user with the random dni and name
user=$(echo $get | jq '.[] | select(.dni == "'$dni'") | select(.name == "'$name'")')
# if the user is found, the test is successful
if [ -n "$user" ]; then
  echo "Test passed"
  echo "dni: $dni"
    echo "name: $name"
    echo "user: $user"
    docker rm -f devsu
else
  echo "Test failed"
  docker rm -f devsu
  exit 1
fi
# stop the container
