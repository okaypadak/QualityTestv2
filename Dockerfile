##########################
# 1. Build aşaması (Maven)
##########################
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Tüm proje dosyalarını kopyala
COPY . .

# AŞAMA LOGU
RUN echo "📦 Maven build başlatılıyor..."

# Derleme
RUN mvn clean package -DskipTests && echo "✅ Maven build tamamlandı!" || (echo "❌ Maven build başarısız!" && exit 1)

# Sonuçları kontrol et
RUN echo "📂 target dizin içeriği:" && ls -la target

##########################
# 2. Uygulama çalışma aşaması
##########################
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Build edilmiş JAR dosyasını al
COPY --from=builder /app/target/quality-test-1.0.jar app.jar

# lib klasörünü al (external JAR'lar için)
COPY lib/ lib/

# Ek log
# Build edilen JAR’ı ve lib klasörünü kopyala
COPY --from=builder /app/target/quality-test-1.0.jar app.jar
COPY lib/ lib/

# 🔍 DEBUG LOG: lib klasörü gerçekten kopyalanmış mı?
RUN echo "📦 /app dizini:" && ls -la /app && \
    echo "📦 /app/lib dizini:" && ls -la /app/lib && \
    echo "✅ lib/ içeriği başarıyla kopyalandı!" || echo "❌ lib/ klasörü eksik veya boş!"

# Uygulamanın çalışacağı port
EXPOSE 8082

# Uygulamayı başlat
ENTRYPOINT ["java", "-jar", "app.jar"]
