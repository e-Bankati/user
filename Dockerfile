# Etape de construction (build)
FROM ubuntu:latest AS build

# Mise à jour des paquets et installation de JDK 17
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y

# Copier tout le code source dans l'image
COPY . .

# Installation de Maven
RUN apt-get install maven -y

# Exécuter la commande Maven pour construire le projet en ignorant les tests
RUN mvn clean install -DskipTests

# Etape de production
FROM openjdk:17-jdk-slim

# Exposer le port 8010 pour l'application
EXPOSE 8010

# Copier le fichier JAR construit depuis l'étape de build
COPY --from=build /target/User-0.0.1-SNAPSHOT.jar app.jar

# Exécuter le fichier JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
