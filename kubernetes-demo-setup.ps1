# Kubernetes Demo Setup Script
# Windows PowerShell

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Kubernetes Demo Kurulumu Basliyor..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Kubernetes baglantisini kontrol et
Write-Host "1. Kubernetes baglantisi kontrol ediliyor..." -ForegroundColor Yellow
try {
    $null = kubectl cluster-info 2>&1 | Out-Null
    Write-Host "OK Kubernetes hazir!" -ForegroundColor Green
} catch {
    Write-Host "HATA: Kubernetes baglantisi kurulamadi!" -ForegroundColor Red
    Write-Host "   Docker Desktop'ta Kubernetes'in aktif oldugundan emin olun."
    Write-Host "   Docker Desktop > Settings > Kubernetes > Enable Kubernetes"
    exit 1
}
Write-Host ""

# 2. Eski demo'lari temizle
Write-Host "2. Eski demo deployment'lar temizleniyor..." -ForegroundColor Yellow
kubectl delete deployment demo-app --ignore-not-found=true 2>&1 | Out-Null
kubectl delete service demo-app --ignore-not-found=true 2>&1 | Out-Null
Start-Sleep -Seconds 2
Write-Host "OK Temizleme tamamlandi!" -ForegroundColor Green
Write-Host ""

# 3. Yeni deployment olustur
Write-Host "3. Demo uygulamasi deploy ediliyor (3 pod)..." -ForegroundColor Yellow
kubectl create deployment demo-app --image=demo-app:latest --replicas=3
Write-Host ""

# 4. Pod'larin hazir olmasini bekle
Write-Host "4. Pod'larin baslamasi bekleniyor..." -ForegroundColor Yellow
Write-Host "   (Bu 20-30 saniye surebilir)" -ForegroundColor Gray

kubectl wait --for=condition=ready pod -l app=demo-app --timeout=60s 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "OK Tum pod'lar hazir!" -ForegroundColor Green
} else {
    Write-Host "UYARI: Bazi pod'lar henuz hazir degil, devam ediliyor..." -ForegroundColor Yellow
}
Write-Host ""

# 5. Service olustur
Write-Host "5. Service olusturuluyor..." -ForegroundColor Yellow
kubectl expose deployment demo-app --type=NodePort --port=8080 --target-port=8080
Start-Sleep -Seconds 2
Write-Host "OK Service olusturuldu!" -ForegroundColor Green
Write-Host ""

# 6. Port numarasini al
Write-Host "6. Baglanti bilgileri aliniyor..." -ForegroundColor Yellow
$portOutput = kubectl get service demo-app -o jsonpath='{.spec.ports[0].nodePort}'
Write-Host ""

# 7. Ozet bilgi
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  DEMO HAZIR!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Pod'lar:" -ForegroundColor Cyan
kubectl get pods -o wide
Write-Host ""

Write-Host "Service Bilgileri:" -ForegroundColor Cyan
kubectl get service demo-app
Write-Host ""

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "DEMO URL:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   http://localhost:$portOutput" -ForegroundColor Green
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Kullanim Talimatlari:" -ForegroundColor Cyan
Write-Host "   1. Tarayicide GIZLI SEKME ac"
Write-Host "   2. Yukaridaki URL'yi gir"
Write-Host "   3. JSON'da 'os.hostname' degerine bak"
Write-Host "   4. Sekmeyi kapat, YENI gizli sekme ac"
Write-Host "   5. Farkli hostname goreceksin!"
Write-Host ""
Write-Host "Test komutu:" -ForegroundColor Cyan
Write-Host "   curl http://localhost:$portOutput | Select-String hostname"
Write-Host ""
Write-Host "Pod'lari olceklendirmek icin:" -ForegroundColor Cyan
Write-Host "   kubectl scale deployment demo-app --replicas=5"
Write-Host ""
Write-Host "Demo'yu temizlemek icin:" -ForegroundColor Cyan
Write-Host "   .\kubernetes-demo-cleanup.ps1"
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Basarilar!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan