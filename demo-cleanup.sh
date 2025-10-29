#!/bin/bash

# Renkler
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${RED}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}║        Docker & Kubernetes Demo Cleanup (macOS)        ║${NC}"
echo -e "${RED}╚════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}Kubernetes kaynakları temizleniyor...${NC}"

# Deployment ve Service'i sil (deployment.yaml her ikisini de içeriyor)
echo -e "\n${YELLOW}[1/3] Deployment ve Service siliniyor...${NC}"
kubectl delete -f deployment.yaml 2>/dev/null
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Deployment ve Service silindi${NC}"
else
    echo -e "${YELLOW}⚠️  Kaynaklar bulunamadı veya zaten silinmiş${NC}"
fi

# Pod'ların tamamen silinmesini bekle
echo -e "\n${YELLOW}[2/3] Pod'ların temizlenmesi bekleniyor...${NC}"
sleep 3

# Durumu kontrol et
REMAINING_PODS=$(kubectl get pods -l app=demo-app 2>/dev/null | grep -v NAME | wc -l)
if [ $REMAINING_PODS -eq 0 ]; then
    echo -e "${GREEN}✅ Tüm pod'lar temizlendi${NC}"
else
    echo -e "${YELLOW}⚠️  Hala $REMAINING_PODS pod var (temizlenme devam ediyor...)${NC}"
    echo -e "${BLUE}   30 saniye bekleniyor...${NC}"
    sleep 30
    REMAINING_PODS=$(kubectl get pods -l app=demo-app 2>/dev/null | grep -v NAME | wc -l)
    if [ $REMAINING_PODS -eq 0 ]; then
        echo -e "${GREEN}✅ Tüm pod'lar temizlendi${NC}"
    else
        echo -e "${YELLOW}⚠️  Hala $REMAINING_PODS pod var (arka planda temizlenmeye devam edecek)${NC}"
    fi
fi

# Docker image'ı sil (opsiyonel)
echo -e "\n${YELLOW}[3/3] Docker image temizleniyor...${NC}"
if docker images | grep -q "demo-app"; then
    echo -e "${BLUE}   Docker image siliniyor: demo-app:latest${NC}"
    docker rmi demo-app:latest 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Docker image silindi${NC}"
    else
        echo -e "${YELLOW}⚠️  Docker image silinemedi (kullanımda olabilir)${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Docker image bulunamadı${NC}"
fi

echo -e "\n${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              ✨ TEMİZLEME TAMAMLANDI! ✨               ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo -e "\n${YELLOW}💡 Kaynakları kontrol etmek için:${NC}"
echo -e "   • ${BLUE}kubectl get all${NC}"
echo -e "   • ${BLUE}kubectl get pods${NC}"
echo -e "   • ${BLUE}kubectl get services${NC}"
echo -e "   • ${BLUE}docker images | grep demo-app${NC}\n"
