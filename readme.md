#build image
docker build --platform=linux/arm64 -t <image-name>:<version>-arm64 .

#running image
docker run -d -p 8080:8080 --name java-app java-app:v1-arm64
