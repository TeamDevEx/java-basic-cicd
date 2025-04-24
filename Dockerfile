# Use a lightweight OpenJDK JRE image (smaller than JDK)
FROM eclipse-temurin:17-jre-alpine

ARG FRONTEND_URL=http://http://34.118.157.100:80

ENV FRONTEND_URL=$FRONTEND_URL

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from the target directory to the container
COPY target/*.jar app.jar

# Expose the application's port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
