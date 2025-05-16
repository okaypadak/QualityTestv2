###############################
# 1. Maven Build Aşaması
###############################
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

RUN echo "🚀 Maven build başlıyor..." && \
    mvn clean package -DskipTests && \
    echo "✅ Maven build tamamlandı!"

RUN echo "📂 target dizini içeriği:" && ls -la target

###############################
# 2. Uygulama Runtime Aşaması
###############################
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=builder /app/target/quality-test-1.0.jar app.jar

ENV TZ=Europe/Istanbul
EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]
