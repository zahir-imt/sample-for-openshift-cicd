FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -----------------------------
# Stage 2: Run JAR
# -----------------------------
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/sample-for-openshift-cicd.jar


EXPOSE 8080
ENTRYPOINT  ["java", "-jar", "sample-for-openshift-cicd.jar"]