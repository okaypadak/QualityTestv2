# Java 17 JDK tabanlı image
FROM eclipse-temurin:17-jdk

# Çalışma dizini
WORKDIR /app

# .jar dosyasını ve lib klasörünü image'a kopyala
COPY target/quality-test-1.0.jar app.jar
COPY lib/ lib/

# Gerekirse timezone düzelt
ENV TZ=Europe/Istanbul

# Uygulamanın çalışacağı portu expose et
EXPOSE 8082

# Uygulama başlatma komutu
ENTRYPOINT ["java", "-jar", "app.jar"]
