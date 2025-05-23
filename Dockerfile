# ---------- build stage ----------
FROM gradle:8.6-jdk17 AS builder
WORKDIR /home/app
COPY . .
RUN gradle bootJar --no-daemon

# ---------- runtime stage ----------
FROM eclipse-temurin:17
WORKDIR /app
COPY --from=builder /home/app/build/libs/*SNAPSHOT.jar app.jar
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]