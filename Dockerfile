FROM bitnami/git:latest as repo
WORKDIR /application
RUN git clone https://github.com/mahendra-007/Train-Ticket-Reservation-System.git

FROM maven:3.9-amazoncorretto-8-al2023 as build
WORKDIR /app
COPY --from=repo /application/Train-Ticket-Reservation-System /app
RUN mvn clean package

FROM tomcat:8.5.96-jre8-temurin-jammy
HEALTHCHECK --interval=2s --timeout=3s CMD curl -f http://51.20.66.55:8080/Train/ || exit 1
COPY --from=build /app/target/TrainBook-1.0.0-SNAPSHOT*.war /usr/local/tomcat/webapps/Train.war
