# Stage 1: Build JAR
FROM maven:3.9.0-eclipse-temurin-21-jdk AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jdk-slim
WORKDIR /app

COPY --from=build /app/target/chat-app-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
