FROM eclipse-temurin:17-jdk 


WORKDIR /app

COPY target/ci-cd-devops-1.0-SNAPSHOT.jar app.jar

CMD ["java","-jar","app.jar"]


