# Étape 1 : Build
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app

# Copier tout le code source dans le conteneur
COPY . .

# Construire le projet et ignorer les tests
RUN mvn clean package -DskipTests

# Étape 2 : Runtime
FROM openjdk:17-jdk-slim
WORKDIR /app

# Exposer le port utilisé par votre application Spring Boot
EXPOSE 8010

# Copier le fichier JAR généré depuis l'étape de build
COPY --from=build /app/target/User-0.0.1-SNAPSHOT.jar app.jar

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
