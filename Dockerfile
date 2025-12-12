# ---- Build Stage ----
FROM maven:3.9.6-eclipse-temurin-11 AS build

# Set the current working directory inside the image
WORKDIR /app

# Copy the pom file and source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# ---- Deploy Stage ----
FROM eclipse-temurin:11-jre-jammy

# Copy the built JAR from the build stage
COPY --from=build /app/target/thymeleaf-0.0.1-SNAPSHOT.jar /app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]