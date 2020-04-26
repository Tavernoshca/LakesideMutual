# syntax=docker/dockerfile:experimental
#FROM maven:3.6.1-jdk-8-alpine AS build
# ARG BASE=/usr/src/app
# COPY pom.xml ${BASE}/
# COPY src ${BASE}/src
# RUN --mount=type=cache,target=/root/.m2 mvn -f ${BASE}/pom.xml install -DskipTests

FROM openjdk:8-jdk-alpine
RUN apk add --no-cache curl tar bash procps
ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/home/maven"
RUN adduser maven -D
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
COPY settings.xml $MAVEN_CONFIG/settings.xml
RUN mkdir $MAVEN_CONFIG/repository
RUN chown maven:maven $USER_HOME_DIR -R
USER maven
ARG BASE=/usr/src/app
COPY pom.xml ${BASE}/
COPY src ${BASE}/src
RUN mvn -f ${BASE}/pom.xml install -DskipTests

FROM openjdk:8-jdk-alpine
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/lib/* /app/lib/
COPY --from=build /usr/src/app/target/dependency/META-INF /app/META-INF
COPY --from=build /usr/src/app/target/dependency/BOOT-INF/classes /app

EXPOSE 8110
ENTRYPOINT ["java","-cp","app:app/lib/*","com.lakesidemutual.customercore.CustomerCoreApplication"]
