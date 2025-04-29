#!/bin/bash

set -e  # İlk hata olduğunda script durur

# === Kurulum Parametreleri ===
ZIP_FILE="wlp-webProfile8-25.0.0.4.zip"
INSTALL_DIR="/opt/wasliberty"
SERVER_NAME="testServer"
PROFILE_FILE="/root/.bashrc"


echo ""
echo "╔═══════════════════════════════════════════════╗"
echo "║     🛠️  IBM WAS Liberty Installer Script       ║"
echo "║        🚀 Designed by mertugral                ║"
echo "╚═══════════════════════════════════════════════╝"
sleep 1


echo "[1/8] Java kontrolü yapılıyor..."
if ! command -v java &> /dev/null; then
  echo "[❌] Java bulunamadı. Lütfen önce Java 11+ kurun."
  exit 1
fi


echo "[2/8] ZIP dosyası kontrol ediliyor..."
if [ ! -f "$ZIP_FILE" ]; then
  echo "[❌] ZIP dosyası ($ZIP_FILE) bulunamadı! Lütfen doğru dosyayı yükleyin."
  exit 1
fi


echo "[3/8] ZIP dosyası testi yapılıyor..."
if ! unzip -t "$ZIP_FILE" > /dev/null; then
  echo "[❌] ZIP dosyası bozuk veya eksik. Lütfen tekrar yükleyin."
  exit 1
fi


echo "[4/8] $INSTALL_DIR dizini oluşturuluyor..."
mkdir -p "$INSTALL_DIR"


echo "[5/8] ZIP çıkarılıyor..."
unzip -o "$ZIP_FILE" -d "$INSTALL_DIR"


echo "[6/8] JAVA_HOME ve PATH ayarlanıyor..."
JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which java))))

{
  echo ""
  echo "# Liberty environment - set by install_liberty_root.sh"
  echo "export JAVA_HOME=$JAVA_HOME_PATH"
  echo "export PATH=\$JAVA_HOME/bin:$INSTALL_DIR/wlp/bin:\$PATH"
} >> "$PROFILE_FILE"

source "$PROFILE_FILE"


echo "[7/8] Liberty sunucusu ($SERVER_NAME) oluşturuluyor..."
if ! "$INSTALL_DIR/wlp/bin/server" create "$SERVER_NAME"; then
  echo "[❌] Sunucu oluşturulamadı."
  exit 1
fi


echo "[8/8] Liberty sunucusu başlatılıyor..."
if ! "$INSTALL_DIR/wlp/bin/server" start "$SERVER_NAME"; then
  echo "[❌] Sunucu başlatılamadı."
  exit 1
fi


echo ""
echo "✅ Kurulum tamamlandı!"
echo "🌍 http://localhost:9080 adresinden erişebilirsin."
echo "📁 Server path: $INSTALL_DIR/wlp/usr/servers/$SERVER_NAME"
echo ""
echo "🎉 Designed by mertugral – iyi kodlamalar!"
