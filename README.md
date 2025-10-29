# Kubernetes ve Docker Demo Projesi

## 📋 Proje Hakkında

Bu proje, **Kubernetes** ve **Docker** kullanarak modern container orchestration konseptlerini göstermek için hazırlanmış bir demo uygulamasıdır.

## 🎯 Öğrenilen Kavramlar

- **Container Orchestration**: Kubernetes ile container'ları otomatik yönetim
- **Load Balancing**: Trafiği birden fazla pod'a dağıtma
- **Scaling**: Pod sayısını dinamik olarak artırma/azaltma
- **Service Discovery**: Kubernetes service'leri ile network yönetimi
- **High Availability**: Birden fazla replica ile kesintisiz hizmet

## 📦 Gereksinimler

### Tüm İşletim Sistemleri İçin:
1. **Docker Desktop** (ücretsiz indirme: https://www.docker.com/products/docker-desktop)
2. **kubectl** (Docker Desktop ile birlikte gelir)
3. **Terminal/PowerShell** erişimi

### Kubernetes'i Etkinleştirme:
1. Docker Desktop'ı açın
2. Settings (⚙️) → **Kubernetes** sekmesine gidin
3. **"Enable Kubernetes"** kutusunu işaretleyin
4. **"Apply & Restart"** butonuna tıklayın
5. Kubernetes'in başlaması 1-2 dakika sürebilir
6. Sol altta yeşil işaret görünene kadar bekleyin

### Kubernetes Durumunu Kontrol Etme:
```bash
kubectl cluster-info
kubectl get nodes
```

## 🚀 Kurulum ve Kullanım

### macOS / Linux için:

1. **Terminal'i açın**
2. Proje klasörüne gidin:
```bash
cd ~/path/to/DockerKubernetesDemo
```

3. Script'lere çalıştırma yetkisi verin (ilk kez):
```bash
chmod +x kubernetes-demo-setup.sh kubernetes-demo-cleanup.sh
```

4. Setup scriptini çalıştırın:
```bash
./kubernetes-demo-setup.sh
```

5. Script size bir URL verecek (örnek: `http://localhost:30633`)
6. Bu URL'yi tarayıcıda açın
7. Farklı tarayıcı sekmeleri açarak **load balancing**'i test edin

### Windows için:

1. **PowerShell**'i yönetici olarak açın (sağ tık > "Run as Administrator")
2. Proje klasörüne gidin:
```powershell
cd "C:\path\to\DockerKubernetesDemo"
```

3. Setup scriptini çalıştırın:
```powershell
.\kubernetes-demo-setup.ps1
```

4. Script size bir URL verecek (örnek: `http://localhost:31942`)
5. Bu URL'yi tarayıcıda açın
6. Farklı tarayıcı sekmeleri açarak **load balancing**'i test edin

## 🧪 Demo'yu Test Etme

### Load Balancing Testi:
Her tarayıcı sekmesinde farklı bir **hostname** göreceksiniz. Bu, isteklerinizin farklı pod'lara dağıtıldığını gösterir.

**Terminal'de test (macOS/Linux):**
```bash
curl http://localhost:PORT_NUMBER
```

**PowerShell'de test (Windows):**
```powershell
curl http://localhost:PORT_NUMBER | Select-String hostname
```

### Scaling Testi:
```bash
# Pod sayısını 5'e çıkar
kubectl scale deployment demo-app --replicas=5

# Pod'ları görüntüle
kubectl get pods

# Real-time izleme
kubectl get pods -w
```

### Demo'yu Temizleme:

**macOS/Linux:**
```bash
./kubernetes-demo-cleanup.sh
```

**Windows:**
```powershell
.\kubernetes-demo-cleanup.ps1
```

## 📊 Kullanışlı Komutlar

### Pod Yönetimi:
```bash
# Pod'ları listele
kubectl get pods

# Detaylı bilgi
kubectl get pods -o wide

# Pod detaylarını gör
kubectl describe pod <POD_NAME>
```

### Log İnceleme:
```bash
# Tüm pod'ların loglarını gör
kubectl logs -l app=demo-app --tail=50

# Specific pod'un loglarını izle
kubectl logs -f <POD_NAME>
```

### Service Yönetimi:
```bash
# Service bilgilerini gör
kubectl get service demo-app

# Tüm kaynakları listele
kubectl get all
```

## 🎓 Kubernetes Neden Kullanılır?

### Temel Faydaları:
- ✅ **Otomatik Yönetim**: Container'lar otomatik başlatılıp durdurulur
- ✅ **Ölçeklenebilirlik**: Kolayca pod sayısı artırılabilir
- ✅ **Yüksek Erişilebilirlik**: Bir pod çökerse diğerleri devam eder
- ✅ **Self-Healing**: Başarısız container'lar otomatik yeniden başlatılır
- ✅ **Kaynak Yönetimi**: CPU ve memory otomatik dağıtılır
- ✅ **Load Balancing**: Trafik otomatik olarak dağıtılır

### İdeal Kullanım Alanları:
- Microservice mimarileri
- Yüksek trafik alan web uygulamaları
- Cloud-native uygulamalar
- DevOps ve CI/CD pipeline'ları
- Containerize edilmiş servisler

### Kubernetes Bileşenleri:
- **Pods**: Çalışan container'ların en küçük birimi
- **Deployments**: Uygulama deployment'larını yönetir
- **Services**: Pod'lara network erişimi sağlar
- **ReplicaSets**: Pod replica'larını yönetir
- **Namespaces**: Kaynak izolasyonu için mantıksal bölümler

## 🐋 Docker + Kubernetes

**Docker** ve **Kubernetes** birlikte çalışır:
- **Docker**: Container'ları oluşturur ve çalıştırır
- **Kubernetes**: Container'ları orkestre eder, yönetir ve scale eder

## 🐛 Sorun Giderme

### "kubectl: command not found" hatası:
- Docker Desktop'ın çalıştığından emin olun
- Terminal/PowerShell'i yeniden başlatın
- `kubectl version` komutuyla kontrol edin

### "Unable to connect to server" hatası:
- Docker Desktop'ta Kubernetes'in etkin olduğunu kontrol edin
- Settings → Kubernetes → "Enable Kubernetes" işaretli olmalı
- Docker Desktop'ı restart edin

### Port çakışması:
- Kubernetes otomatik olarak farklı bir port seçecektir
- Mevcut portu görmek için: `kubectl get service demo-app`

### Pod'lar başlamıyor:
- Docker Desktop'a yeterli kaynak ayrıldığından emin olun
- Settings → Resources → RAM ve CPU'yu artırın (minimum 4GB RAM önerilir)

### Script çalıştırma izni hatası (macOS/Linux):
```bash
chmod +x kubernetes-demo-setup.sh kubernetes-demo-cleanup.sh
```

## 📝 Notlar

- Script'ler hem macOS/Linux (.sh) hem de Windows (.ps1) formatında mevcuttur
- Docker Desktop Kubernetes, tek node'lu bir cluster oluşturur (development için yeterli)
- Production ortamlarında genellikle multi-node cluster'lar kullanılır
- Demo uygulaması Node.js ile yazılmış basit bir web sunucusudur

## 📚 Ek Kaynaklar

- [Kubernetes Resmi Dokümantasyonu](https://kubernetes.io/docs/)
- [Docker Resmi Dokümantasyonu](https://docs.docker.com/)
- [Kubernetes Tutorial](https://kubernetes.io/docs/tutorials/)
- [Docker Desktop Kubernetes](https://docs.docker.com/desktop/kubernetes/)

## 👥 Takım

**Geliştiriciler**: BartoooMuch & alihaktan35

---

**Proje Tarihi**: 2025  
**Ders**: SE 4458 - Software Architecture & Design of Modern Large Scale Systems  
**Konu**: Docker Container & Kubernetes Orchestration
