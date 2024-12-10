# Gunakan base image Maven untuk build
FROM maven:3.8.5-openjdk-11 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml dan source code ke image
COPY pom.xml /app
COPY src /app/src

# Build aplikasi menggunakan Maven
RUN mvn clean package

# Gunakan base image Java untuk runtime
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy file jar hasil build
COPY --from=builder /app/target/simple-java-app-1.0-SNAPSHOT.jar app.jar

# Ekspos port 8080
EXPOSE 8080

# Jalankan aplikasi
CMD ["java", "-jar", "app.jar"]
