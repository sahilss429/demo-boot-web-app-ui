#Builder Stage
FROM maven:3.3-jdk-8-alpine as builder
WORKDIR /apps
COPY . .
RUN mvn clean spring-boot:run

FROM openjdk:8-jre-alpine as deployer
WORKDIR /apps
COPY --from=builder /apps/target/*.jar /apps/app.jar
COPY start.sh /apps/start.sh
EXPOSE 8080
RUN chmod +x /apps/start.sh
ENTRYPOINT exec /apps/start.sh