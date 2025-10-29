#!/bin/bash

# Renkler
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║        Docker & Kubernetes Demo Setup (macOS)          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"

# Docker'ın çalıştığını kontrol et
echo -e "\n${YELLOW}[1/5] Docker kontrolü yapılıyor...${NC}"
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}⚠️  Docker çalışmıyor! Lütfen Docker Desktop'ı başlatın.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Docker çalışıyor${NC}"

# Kubernetes'in çalıştığını kontrol et
echo -e "\n${YELLOW}[2/5] Kubernetes kontrolü yapılıyor...${NC}"
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo -e "${RED}⚠️  Kubernetes çalışmıyor! Lütfen Docker Desktop'ta Kubernetes'i etkinleştirin.${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Kubernetes çalışıyor${NC}"

# Docker image'ı build et (demo-app klasöründen)
echo -e "\n${YELLOW}[3/5] Docker image build ediliyor...${NC}"
echo -e "${BLUE}   Build context: ./demo-app${NC}"
docker build -t demo-app:latest ./demo-app
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Docker image başarıyla oluşturuldu${NC}"
else
    echo -e "${RED}⚠️  Docker image oluşturulamadı!${NC}"
    exit 1
fi

# Image içeriğini kontrol et (opsiyonel - debug için)
echo -e "${BLUE}   Image içeriği kontrol ediliyor...${NC}"
FILE_COUNT=$(docker run --rm demo-app:latest ls -1 /app | wc -l)
echo -e "${GREEN}   ✅ Image içinde $FILE_COUNT dosya bulundu${NC}"

# Kubernetes deployment'ı uygula
echo -e "\n${YELLOW}[4/5] Kubernetes deployment oluşturuluyor...${NC}"
kubectl apply -f deployment.yaml
if [ $? -ne 0 ]; then
    echo -e "${RED}⚠️  Deployment oluşturulamadı!${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Deployment ve Service oluşturuldu${NC}"

# Pod'ların hazır olmasını bekle
echo -e "\n${YELLOW}[5/5] Pod'ların başlaması bekleniyor...${NC}"
kubectl wait --for=condition=ready pod -l app=demo-app --timeout=60s
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Pod'lar hazır${NC}"
else
    echo -e "${YELLOW}⚠️  Pod'lar henüz hazır değil, birkaç saniye daha bekleyin...${NC}"
fi

# Service port'unu al
NODE_PORT=$(kubectl get service demo-app -o jsonpath='{.spec.ports[0].nodePort}')

echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              🎉 KURULUM TAMAMLANDI! 🎉                 ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo -e "\n${BLUE}Demo uygulamanız şu adreste çalışıyor:${NC}"
echo -e "${GREEN}👉 http://localhost:$NODE_PORT${NC}"
echo -e "\n${YELLOW}💡 İpuçları:${NC}"
echo -e "   • Tarayıcıda birden fazla sekme açın (farklı hostname'ler göreceksiniz)"
echo -e "   • Load balancing'i test edin:"
echo -e "     ${BLUE}curl http://localhost:$NODE_PORT | grep -o 'demo-app-[^<]*'${NC}"
echo -e "   • Pod sayısını artırın:"
echo -e "     ${BLUE}kubectl scale deployment demo-app --replicas=5${NC}"
echo -e "   • Pod'ları izleyin:"
echo -e "     ${BLUE}kubectl get pods -w${NC}"
echo -e "   • Log'ları görün:"
echo -e "     ${BLUE}kubectl logs -l app=demo-app --tail=50${NC}"
echo -e "\n${RED}Temizlemek için: bash demo-cleanup.sh${NC}\n"
