# Stage 1: Build JAR
FROM maven:3.9.0-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom + source code
COPY pom.xml .
COPY src ./src

# Build project
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jdk-slim
WORKDIR /app

# Copy JAR từ stage 1
COPY --from=build /app/target/chat-app-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java","-jar","app.jar"]
