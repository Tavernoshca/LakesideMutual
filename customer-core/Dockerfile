# syntax=docker/dockerfile:experimental

# FROM maven:3.6.1-jdk-8-alpine AS build
FROM maven:3.6.3-jdk-8-slim AS build

RUN chmod +x /usr/bin/mvn

ARG BASE=/usr/src/app
COPY pom.xml ${BASE}/
COPY src ${BASE}/src
# RUN --mount=type=cache,target=/root/.m2 mvn -f ${BASE}/pom.xml install -DskipTests
RUN mvn -f ${BASE}/pom.xml install -DskipTests

FROM openjdk:8-jdk-alpine
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/lib/* /app/lib/
COPY --from=build /usr/src/app/target/dependency/META-INF /app/META-INF
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/classes /app

EXPOSE 8110
ENTRYPOINT ["java","-cp","app:app/lib/*","com.lakesidemutual.customercore.CustomerCoreApplication"]