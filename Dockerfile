FROM gradle:jdk17 AS build

ARG BUILD_DIR=/build

COPY . ${BUILD_DIR}
WORKDIR ${BUILD_DIR}

RUN gradle build --no-daemon

FROM openjdk:17.0

RUN mkdir /app

EXPOSE 8080

COPY --from=build "/build/build/libs/*.jar" /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
