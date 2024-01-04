#without multistage like it has size larger than multistage image 
FROM maven:3.8-jdk-11 AS builder
WORKDIR /usr/src/mymaven
COPY . .
RUN mvn install -DskipTests

FROM tomcat:9-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps
COPY --from=builder /usr/src/mymaven/target/java-tomcat-maven-example.war ROOT.war

#----------------------------------------------
# code is reduces image size 
# Stage 1: Use Maven image to build the project
#FROM maven:3.8-jdk-11 AS builder

# Set the working directory inside the image
#WORKDIR /usr/src/mymaven

# Copy only the pom.xml to leverage Docker cache
#COPY pom.xml .

# Download dependencies and plugins
#RUN mvn dependency:go-offline

# Copy the entire source code
#COPY . .

# Build the Maven project, skipping tests
#RUN mvn install -DskipTests

# Stage 2: Use Tomcat image for deployment
#FROM tomcat:9-jdk11-openjdk-slim

# Set the working directory inside the Tomcat image
#WORKDIR /usr/local/tomcat/webapps

# Copy the built artifact from the Maven image to the Tomcat image
#COPY --from=builder /usr/src/mymaven/target/java-tomcat-maven-example.war ROOT.war

