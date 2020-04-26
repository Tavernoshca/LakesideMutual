# syntax=docker/dockerfile:experimental
#FROM maven:3.6.1-jdk-8-alpine AS build
# ARG BASE=/usr/src/app
# COPY pom.xml ${BASE}/
# COPY src ${BASE}/src
# RUN --mount=type=cache,target=/root/.m2 mvn -f ${BASE}/pom.xml install -DskipTests

FROM openjdk:8-jdk-alpine
RUN useradd --create-home -s /bin/bash user
WORKDIR /home/user
USER user
RUN wget -c https://downloads.apache.org/maven/maven-3/3.6.3/source/apache-maven-3.6.3-src.tar.gz
RUN tar xzvf apache-maven-3.6.3-src.tar.gz
RUN export PATH="$HOME/apache-maven-3.6.3/bin:$PATH"
RUN mvn -f ${BASE}/pom.xml install -DskipTests

FROM openjdk:8-jdk-alpine
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/lib/* /app/lib/
COPY --from=build /usr/src/app/target/dependency/META-INF /app/META-INF
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/classes /app

EXPOSE 8110
ENTRYPOINT ["java","-cp","app:app/lib/*","com.lakesidemutual.customercore.CustomerCoreApplication"]
