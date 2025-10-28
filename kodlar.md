# Kodlar ve Test Adımları

## 🎯 Proje: Kubernetes ve Docker Demo

Bu proje, Kubernetes container orchestration ve Docker containerization teknolojilerini gösteren interaktif bir demo uygulamasıdır.

## 📁 Proje Yapısı

```
.
├── demo-app/              # Özel Node.js uygulaması
│   ├── app.js            # Express.js backend
│   ├── index.html        # Modern HTML5 frontend
│   ├── package.json      # Node.js bağımlılıkları
│   └── Dockerfile        # Docker image tanımı
├── deployment.yaml        # Kubernetes deployment yapılandırması
├── kubernetes-demo-setup.ps1    # Windows kurulum scripti
├── kubernetes-demo-cleanup.ps1  # Windows temizleme scripti
├── kubernetes-demo-setup.sh     # Linux/Mac kurulum scripti
├── kubernetes-demo-cleanup.sh   # Linux/Mac temizleme scripti
├── README.md             # Proje dokümantasyonu
└── kodlar.md             # Bu dosya

```

## 🚀 Kurulum ve Test Adımları

### 1. Gereksinimleri Hazırla

```bash
# Docker Desktop kurulumu gerekli
# https://www.docker.com/products/docker-desktop
```

### 2. Kubernetes'i Aktifleştir

1. Docker Desktop'ı aç
2. Settings ⚙️ > Kubernetes
3. "Enable Kubernetes" kutusunu işaretle
4. "Apply & Restart" butonuna tıkla
5. 1-2 dakika bekle (Kubernetes başlıyor)

### 3. Docker Image'ı Oluştur

```powershell
# Proje klasöründe
cd demo-app
docker build -t demo-app:latest .
```

**Örnek Output:**
```
[+] Building 15.8s (10/10) FINISHED
=> [5/5] COPY . .
=> exporting to image
=> => naming to docker.io/library/demo-app:latest
```

### 4. Kubernetes'e Deploy Et

```powershell
# Ana klasöre dön
cd ..
kubectl apply -f deployment.yaml
```

**Örnek Output:**
```
deployment.apps/demo-app created
service/demo-app created
```

### 5. Pod'ların Başlamasını Kontrol Et

```powershell
kubectl get pods -l app=demo-app
```

**Beklenen Output:**
```
NAME                        READY   STATUS    RESTARTS   AGE
demo-app-78d45d4dff-db6bj   1/1     Running   0          12s
demo-app-78d45d4dff-tftlc   1/1     Running   0          12s
demo-app-78d45d4dff-tq9xm   1/1     Running   0          12s
```

### 6. Service Port'unu Bul

```powershell
kubectl get service demo-app
```

**Örnek Output:**
```
NAME       TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
demo-app   NodePort   10.106.159.113   <none>        8080:32254/TCP   27s
```

Port numarası: **32254** (değişken)

### 7. Demo'yu Tarayıcıda Test Et

1. Tarayıcıda yeni sekme aç: `http://localhost:32254`
2. Modern arayüzü gör:
   - Aktif pod adı
   - Uptime bilgisi
   - İstek sayısı
   - Request history
3. **"Refresh Info"** butonuna tıkla
4. Her refresh'te farklı pod görebilirsin (load balancing)

### 8. Load Balancing Test Et

**Yöntem 1: Tarayıcıda Gizli Sekmeler**
1. Gizli sekme aç (Ctrl + Shift + N)
2. URL'yi yapıştır
3. Pod adını not et
4. Gizli sekmeyi kapat
5. **Yeni** gizli sekme aç
6. Tekrar aynı URL'yi aç
7. Farklı pod adı göreceksin! ✨

**Yöntem 2: PowerShell ile Test**
```powershell
# 5 kez istek at
for ($i=1; $i -le 5; $i++) {
    Write-Host "Request $i"
    Invoke-WebRequest -Uri http://localhost:32254/api/pod-info -UseBasicParsing | ConvertFrom-Json | Select-Object podName
    Start-Sleep -Seconds 1
}
```

**Yöntem 3: Real-time Pod İzleme**
```powershell
# Pod'ları canlı izle
kubectl get pods -l app=demo-app -w
```

**Yöntem 4: Çoklu İstek Testi**
```powershell
# Aynı anda birden fazla istek
for ($i=1; $i -le 10; $i++) {
    $result = Invoke-WebRequest -Uri http://localhost:32254 -UseBasicParsing | Select-Object -ExpandProperty Content | ConvertFrom-Json | Select-Object -ExpandProperty os | Select-Object -ExpandProperty hostname
    Write-Host "Request $i -> $result" -ForegroundColor Cyan
}
```

### 9. Pod Sayısını Ölçeklendir

```powershell
kubectl scale deployment demo-app --replicas=5
```

Pod sayısı 3'ten 5'e çıktı, daha fazla yük dağılımı olacak!

**Kontrol et:**
```powershell
kubectl get pods -l app=demo-app
```

### 10. Log'ları İncele

```powershell
# Tüm pod'ların log'ları
kubectl logs -l app=demo-app

# Belirli bir pod'un log'u
kubectl logs demo-app-78d45d4dff-db6bj
```

### 11. Pod Detaylarını Görüntüle

```powershell
kubectl describe pod -l app=demo-app
```

### 12. Demo'yu Temizle

```powershell
# Manuel temizleme
kubectl delete deployment demo-app
kubectl delete service demo-app

# Veya script ile
.\kubernetes-demo-cleanup.ps1
```

## 🧪 Yapılan Testler

### ✅ Başarılı Testler

1. **Docker Image Build**
   - Image başarıyla oluşturuldu
   - Boyut: 196MB
   - Tag: demo-app:latest

2. **Kubernetes Deployment**
   - 3 pod başarıyla oluşturuldu
   - Tüm pod'lar Running durumunda
   - Service başarıyla expose edildi

3. **Load Balancing**
   - Farklı gizli sekmelerde farklı pod'lar görüntülendi
   - Trafik farklı pod'lara dağıldı

4. **Frontend Arayüz**
   - Modern, responsive tasarım
   - Otomatik 5 saniye refresh
   - Request history tracking
   - Pod bilgisi gösterimi

5. **Scaling**
   - Pod sayısı 3'ten 5'e çıkarıldı
   - Yeni pod'lar başarıyla başlatıldı

6. **Git Push**
   - Tüm dosyalar GitHub'a push edildi
   - Repo: https://github.com/BartoooMuch/DockerKubernetesDemo

### 📊 Test Sonuçları

**Pod Durumu:**
```
NAME                        READY   STATUS    RESTARTS   AGE   IP
demo-app-78d45d4dff-db6bj   1/1     Running   0          12s   10.1.0.50
demo-app-78d45d4dff-tftlc   1/1     Running   0          12s   10.1.0.52
demo-app-78d45d4dff-tq9xm   1/1     Running   0          12s   10.1.0.51
```

**Service Bilgisi:**
```
NAME       TYPE       PORT(S)
demo-app   NodePort   8080:32254/TCP
```

## 🛠️ Kullanılan Komutlar

### Docker Komutları

```bash
# Image build et
docker build -t demo-app:latest .

# Image listesi
docker images | findstr demo-app

# Container durumu
docker ps
```

### Kubernetes Komutları

```bash
# Cluster bilgisi
kubectl cluster-info

# Node'ları listele
kubectl get nodes

# Pod'ları listele
kubectl get pods

# Service'leri listele
kubectl get services

# Deployment listele
kubectl get deployments

# Pod log'ları
kubectl logs -l app=demo-app

# Pod detayları
kubectl describe pod POD_NAME

# Ölçeklendirme
kubectl scale deployment demo-app --replicas=5

# Silme
kubectl delete deployment demo-app
kubectl delete service demo-app
```

## 📝 Önemli Notlar

1. **Image Pull Policy:** `Never` - Local image kullanıyor
2. **Replicas:** 3 pod (başlangıç)
3. **Service Type:** NodePort (8080:PORT_NUMBER)
4. **Container Port:** 8080
5. **Auto-refresh:** Frontend 5 saniyede bir güncellenir

## 🐛 Karşılaşılan Sorunlar ve Çözümler

### Sorun 1: ErrImagePull
**Hata:** `pull access denied for demo-app`
**Çözüm:** `deployment.yaml`'da `imagePullPolicy: Never` ayarlandı

### Sorun 2: Emoji Encoding Sorunu
**Hata:** PowerShell'de emoji karakterleri bozuluyor
**Çözüm:** Emoji'ler kaldırıldı, plain text kullanıldı

### Sorun 3: Port Bulunamadı
**Hata:** Port değişken olabiliyor
**Çözüm:** `kubectl get service demo-app` ile kontrol edilebilir

## 🎓 Öğrenilen Kavramlar

1. **Container Orchestration:** Kubernetes pod'ları otomatik yönetir
2. **Load Balancing:** Trafik farklı pod'lara dağıtılır
3. **Service Discovery:** Service ile network yönetimi
4. **Scaling:** Pod sayısı dinamik olarak artırılabilir
5. **High Availability:** Bir pod çökerse diğerleri devam eder
6. **Docker Integration:** Docker image'lar Kubernetes'te kullanılır

## 📚 Referanslar

- **Kubernetes Docs:** https://kubernetes.io/docs/
- **Docker Docs:** https://docs.docker.com/
- **GitHub Repo:** https://github.com/BartoooMuch/DockerKubernetesDemo
- **Ders:** SE 4458 - Software Architecture & Design of Modern Large Scale Systems
