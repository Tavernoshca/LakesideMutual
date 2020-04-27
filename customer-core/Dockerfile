# syntax=docker/dockerfile:experimental

# FROM maven:3.6.1-jdk-8-alpine AS build
# ARG BASE=/usr/src/app
# COPY pom.xml ${BASE}/
# COPY src ${BASE}/src
# RUN --mount=type=cache,target=/root/.m2 mvn -f ${BASE}/pom.xml install -DskipTests

# FROM openjdk:8-jdk-alpine
# COPY --from=build /usr/src/app/target/dependency/BOOT-INF/lib/* /app/lib/
# COPY --from=build /usr/src/app/target/dependency/META-INF /app/META-INF
# COPY --from=build /usr/src/app/target/dependency/BOOT-INF/classes /app

FROM openjdk:8-jdk-alpine as build
WORKDIR /usr/src/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw install -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

FROM openjdk:8-jdk-alpine
ARG DEPENDENCY=/usr/src/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib/* /app/lib/
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

EXPOSE 8110
ENTRYPOINT ["java","-cp","app:app/lib/*","com.lakesidemutual.customercore.CustomerCoreApplication"]