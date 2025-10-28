#!/bin/bash

# Kubernetes Demo Kurulum Scripti
# MacOS uyumlu

echo "=========================================="
echo "  Kubernetes Demo Kurulumu Başlıyor..."
echo "=========================================="
echo ""

# Renk kodları
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 1. Kubernetes bağlantısını kontrol et
echo "1️⃣  Kubernetes bağlantısı kontrol ediliyor..."
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}❌ Kubernetes bağlantısı kurulamadı!${NC}"
    echo "   Docker Desktop'ta Kubernetes'in aktif olduğundan emin olun."
    exit 1
fi
echo -e "${GREEN}✅ Kubernetes hazır!${NC}"
echo ""

# 2. Eski demo'ları temizle
echo "2️⃣  Eski demo deployment'ları temizleniyor..."
kubectl delete deployment demo-app --ignore-not-found=true &> /dev/null
kubectl delete service demo-app --ignore-not-found=true &> /dev/null
sleep 2
echo -e "${GREEN}✅ Temizleme tamamlandı!${NC}"
echo ""

# 3. Yeni deployment oluştur
echo "3️⃣  Demo uygulaması deploy ediliyor (3 pod)..."
kubectl create deployment demo-app --image=mendhak/http-https-echo:31 --replicas=3
echo ""

# 4. Pod'ların hazır olmasını bekle
echo "4️⃣  Pod'ların başlaması bekleniyor..."
echo "   (Bu 20-30 saniye sürebilir)"
kubectl wait --for=condition=ready pod -l app=demo-app --timeout=60s

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tüm pod'lar hazır!${NC}"
else
    echo -e "${YELLOW}⚠️  Bazı pod'lar henüz hazır değil, devam ediliyor...${NC}"
fi
echo ""

# 5. Service oluştur
echo "5️⃣  Service oluşturuluyor..."
kubectl expose deployment demo-app --type=NodePort --port=8080 --target-port=8080
sleep 2
echo -e "${GREEN}✅ Service oluşturuldu!${NC}"
echo ""

# 6. Port numarasını al
echo "6️⃣  Bağlantı bilgileri alınıyor..."
PORT=$(kubectl get service demo-app -o jsonpath='{.spec.ports[0].nodePort}')
echo ""

# 7. Özet bilgi
echo "=========================================="
echo -e "${GREEN}  ✅ DEMO HAZIR!${NC}"
echo "=========================================="
echo ""
echo "📊 Pod'lar:"
kubectl get pods -o wide
echo ""
echo "🌐 Service Bilgileri:"
kubectl get service demo-app
echo ""
echo "=========================================="
echo -e "${YELLOW}🎯 DEMO URL:${NC}"
echo ""
echo -e "   ${GREEN}http://localhost:$PORT${NC}"
echo ""
echo "=========================================="
echo ""
echo "📝 Kullanım Talimatları:"
echo "   1. Tarayıcıda GIZLI SEKME aç"
echo "   2. Yukarıdaki URL'yi gir"
echo "   3. JSON'da 'os.hostname' değerine bak"
echo "   4. Sekmeyi kapat, YENİ gizli sekme aç"
echo "   5. Farklı hostname göreceksin!"
echo ""
echo "🧪 Test komutu:"
echo "   curl http://localhost:$PORT | grep hostname"
echo ""
echo "🔄 Pod'ları ölçeklendirmek için:"
echo "   kubectl scale deployment demo-app --replicas=5"
echo ""
echo "🗑️  Demo'yu temizlemek için:"
echo "   bash kubernetes-demo-cleanup.sh"
echo ""
echo "=========================================="
echo "✨ Başarılar!"
echo "=========================================="
