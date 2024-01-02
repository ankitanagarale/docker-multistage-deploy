FROM maven:3.8-jdk-11 AS builder
WORKDIR /usr/src/mymaven
COPY . .
RUN mvn install -DskipTests

FROM tomcat:9-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps
COPY --from=builder /usr/src/mymaven/target/java-tomcat-maven-example.war ROOT.war

