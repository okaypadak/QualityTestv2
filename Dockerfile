###############################
# 1. Maven ile Build Aşaması
###############################
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Proje dosyalarını kopyala
COPY . .

# Log: Başlangıç
RUN echo "🚀 Maven derleme başlıyor..."

# Maven ile derle
RUN mvn clean package -DskipTests && \
    echo "✅ Maven build tamamlandı!" || (echo "❌ Maven build başarısız oldu!" && exit 1)

# Log: target klasörünü göster
RUN echo "📂 target klasörü içeriği:" && ls -la target

###############################
# 2. Uygulama Runtime Aşaması
###############################
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Derlenmiş JAR'ı al
COPY --from=builder /app/target/quality-test-1.0.jar app.jar

# lib klasörünü al
COPY lib/ lib/

# Log: app ve lib dizinlerinin içeriği
RUN echo "📦 /app dizini içeriği:" && ls -la /app && \
    echo "📦 /app/lib dizini içeriği:" && ls -la /app/lib && \
    echo "✅ lib klasörü başarıyla kopyalandı!" || echo "❌ lib klasörü eksik veya boş!"

# Zaman dilimi ayarı (opsiyonel)
ENV TZ=Europe/Istanbul

# Uygulama portu
EXPOSE 8080

# Uygulama çalıştırma komutu
ENTRYPOINT ["java", "-jar", "app.jar"]
