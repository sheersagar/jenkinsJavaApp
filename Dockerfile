FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . /app
RUN mvn dependency:resolve
RUN mvn clean install

FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar demoapp.jar
EXPOSE 8080
CMD ["java", "-jar","demoapp.jar"]
