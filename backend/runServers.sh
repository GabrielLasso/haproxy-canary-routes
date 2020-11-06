docker build . -t server

docker run -p 1111:1111 -d -e port=1111 server
docker run -p 2222:2222 -d -e port=2222 server
docker run -p 3333:3333 -d -e port=3333 server
docker run -p 4444:4444 -d -e port=4444 server
