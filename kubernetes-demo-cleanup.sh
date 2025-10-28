#!/bin/bash

# Kubernetes Demo Temizleme Scripti
# MacOS uyumlu

echo "=========================================="
echo "  Kubernetes Demo Temizleniyor..."
echo "=========================================="
echo ""

# Renk kodları
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 1. Deployment'ı sil
echo "1️⃣  Deployment siliniyor..."
kubectl delete deployment demo-app --ignore-not-found=true
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Deployment silindi!${NC}"
else
    echo -e "${YELLOW}⚠️  Deployment bulunamadı veya zaten silinmiş.${NC}"
fi
echo ""

# 2. Service'i sil
echo "2️⃣  Service siliniyor..."
kubectl delete service demo-app --ignore-not-found=true
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Service silindi!${NC}"
else
    echo -e "${YELLOW}⚠️  Service bulunamadı veya zaten silinmiş.${NC}"
fi
echo ""

# 3. Pod'ların silinmesini bekle
echo "3️⃣  Pod'ların tamamen silinmesi bekleniyor..."
sleep 3

# 4. Kontrol et
REMAINING_PODS=$(kubectl get pods -l app=demo-app 2>/dev/null | grep -v NAME | wc -l)

if [ "$REMAINING_PODS" -eq 0 ]; then
    echo -e "${GREEN}✅ Tüm kaynaklar temizlendi!${NC}"
else
    echo -e "${YELLOW}⚠️  Bazı pod'lar hala sonlanıyor... (${REMAINING_PODS} pod)${NC}"
    echo "   Birkaç saniye sonra otomatik olarak silinecekler."
fi
echo ""

# 5. Özet
echo "=========================================="
echo -e "${GREEN}  ✅ TEMİZLEME TAMAMLANDI!${NC}"
echo "=========================================="
echo ""
echo "📊 Kalan pod'lar (boş olmalı):"
kubectl get pods -l app=demo-app 2>/dev/null || echo "   Hiç pod yok. ✅"
echo ""
echo "🌐 Kalan service'ler (boş olmalı):"
kubectl get service demo-app 2>/dev/null || echo "   Hiç service yok. ✅"
echo ""
echo "=========================================="
echo "✨ Sistem temiz!"
echo "=========================================="
