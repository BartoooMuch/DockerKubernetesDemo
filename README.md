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

### Windows için:
1. **Docker Desktop** (ücretsiz indirme: https://www.docker.com/products/docker-desktop)
2. **PowerShell** (Windows 10/11 ile birlikte gelir)
3. **kubectl** (Docker Desktop ile birlikte gelir)

### Kubernetes'i Aktifleştirme:
1. Docker Desktop'ı açın
2. Settings (⚙️) butonuna tıklayın
3. Sol menüden **Kubernetes** seçin
4. **"Enable Kubernetes"** kutusunu işaretleyin
5. **"Apply & Restart"** butonuna tıklayın
6. Kubernetes'in başlaması 1-2 dakika sürebilir

### Kubernetes Durumunu Kontrol Etme:
```powershell
kubectl cluster-info
kubectl get nodes
```

## 🚀 Kurulum ve Kullanım

### Demo'yu Başlatma:

1. **PowerShell**'i yönetici olarak açın (sağ tık > "Run as Administrator")
2. Proje klasörüne gidin:
```powershell
cd "C:\Users\bartu\Sunum ödevi"
```

3. Setup scriptini çalıştırın:
```powershell
.\kubernetes-demo-setup.ps1
```

4. Script size bir URL verecek (örnek: `http://localhost:31942`)
5. Bu URL'yi tarayıcıda açın (GİZLİ SEKME)
6. Farklı gizli sekmeler açarak **yük dengelemenin** çalıştığını göreceksiniz

### Demo'yu Test Etme:

Her gizli sekmede farklı bir **hostname** göreceksiniz. Bu, isteklerinizin farklı pod'lara dağıtıldığını gösterir.

**Terminal'de test:**
```powershell
curl http://localhost:PORT_NUMBER | Select-String hostname
```

### Pod Sayısını Artırma:

```powershell
kubectl scale deployment demo-app --replicas=5
```

Şimdi 5 pod'unuz olacak ve yük daha fazla dağıtılacak!

### Demo'yu Durdurma ve Temizleme:

```powershell
.\kubernetes-demo-cleanup.ps1
```

## 📊 Örnek Komutlar

### Pod'ları Görüntüleme:
```powershell
kubectl get pods
kubectl get pods -o wide  # Daha detaylı bilgi
```

### Log'ları İnceleme:
```powershell
kubectl logs -l app=demo-app --tail=50
```

### Pod Detaylarını Görme:
```powershell
kubectl describe pod POD_NAME
```

### Service'i Görüntüleme:
```powershell
kubectl get service demo-app
```

### Real-time İzleme:
```powershell
kubectl get pods -w
```

## 🎓 Ödev İçin Sunum İçeriği

### Neden Kubernetes?
- **Otomatik Yönetim**: Container'lar otomatik başlatılıp durdurulur
- **Ölçeklenebilirlik**: Kolayca pod sayısı artırılabilir
- **Yüksek Erişilebilirlik**: Bir pod çökerse diğerleri devam eder
- **Kaynak Yönetimi**: CPU ve memory otomatik dağıtılır

### Hangi Uygulamalar İçin Uygundur?
✅ Microservice mimarileri
✅ Yüksek trafik alan web uygulamaları
✅ Bulut-native uygulamalar
✅ DevOps süreçleri
✅ Containerize edilmiş servisler

### Kubernetes Servisleri:
- **Deployments**: Uygulama deployment'ları
- **Services**: Network yönetimi
- **Pods**: Çalışan container'lar
- **ReplicaSets**: Pod replica yönetimi
- **Namespaces**: Kaynak izolasyonu

### Docker + Kubernetes İlişkisi:
- **Docker**: Container'ları oluşturur ve çalıştırır
- **Kubernetes**: Container'ları orchestrate eder, yönetir ve scale eder

## 🐛 Sorun Giderme

### "kubectl: command not found" hatası:
- Docker Desktop'ın çalıştığından emin olun
- PowerShell'i yeniden başlatın

### "Unable to connect to server" hatası:
- Docker Desktop'ta Kubernetes'in aktif olduğunu kontrol edin
- Settings > Kubernetes > "Enable Kubernetes" kontrol edin

### Port zaten kullanılıyor:
- Farklı bir port kullanılacaktır (otomatik)
- Veya: `kubectl get service demo-app` ile portu kontrol edin

### Pod'lar başlamıyor:
- Docker Desktop'ın yeterli kaynak aldığından emin olun
- Settings > Resources'tan RAM ve CPU'yu artırın

## 📝 Notlar

- Script'ler hem bash (.sh) hem de PowerShell (.ps1) formatında mevcuttur
- Windows'ta PowerShell scriptleri daha iyi çalışır
- Docker Desktop Kubernetes kullandığı için tek node cluster oluşur
- Production'da genellikle multi-node cluster'lar kullanılır

## 📚 Ek Kaynaklar

- [Kubernetes Resmi Dokümantasyon](https://kubernetes.io/docs/)
- [Docker Docs](https://docs.docker.com/)
- [Kubernetes Learning Path](https://kubernetes.io/docs/tutorials/)

## 👥 Takım

BartoooMuch & alihaktan35

---
**Proje Tarihi**: 19 Kasım 2025
**Ders**: SE 4458 - Software Architecture & Design of Modern Large Scale Systems
