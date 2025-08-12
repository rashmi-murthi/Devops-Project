FROM openjdk:17-slim
WORKDIR /app
COPY target/devops-integration.jar devops-integration.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/devops-integration.jar"]


