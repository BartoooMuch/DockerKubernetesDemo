# Kubernetes Demo Cleanup Script
# Windows PowerShell

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Kubernetes Demo Temizleniyor..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Deployment'i sil
Write-Host "1. Deployment siliniyor..." -ForegroundColor Yellow
kubectl delete deployment demo-app --ignore-not-found=true 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "OK Deployment silindi!" -ForegroundColor Green
} else {
    Write-Host "UYARI: Deployment bulunamadi veya zaten silinmis." -ForegroundColor Yellow
}
Write-Host ""

# 2. Service'i sil
Write-Host "2. Service siliniyor..." -ForegroundColor Yellow
kubectl delete service demo-app --ignore-not-found=true 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "OK Service silindi!" -ForegroundColor Green
} else {
    Write-Host "UYARI: Service bulunamadi veya zaten silinmis." -ForegroundColor Yellow
}
Write-Host ""

# 3. Pod'larin silinmesini bekle
Write-Host "3. Pod'larin tamamen silinmesi bekleniyor..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# 4. Kontrol et
Write-Host "4. Kalan kaynaklar kontrol ediliyor..." -ForegroundColor Yellow

$remainingPods = kubectl get pods -l app=demo-app 2>&1 | Select-String -Pattern "demo-app" | Measure-Object | Select-Object -ExpandProperty Count

if ($remainingPods -eq 0) {
    Write-Host "OK Tum kaynaklar temizlendi!" -ForegroundColor Green
} else {
    Write-Host "UYARI: Bazi pod'lar hala sonlanıyor... ($remainingPods pod)" -ForegroundColor Yellow
    Write-Host "   Biraz sonra otomatik olarak silinecekler."
}
Write-Host ""

# 5. Ozet
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  TEMIZLEME TAMAMLANDI!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Kalan pod'lar (bossa normal):" -ForegroundColor Cyan
$podCheck = kubectl get pods -l app=demo-app 2>&1
if ($LASTEXITCODE -eq 0 -and $podCheck -match "demo-app") {
    kubectl get pods -l app=demo-app
} else {
    Write-Host "   Hic pod yok. OK" -ForegroundColor Green
}
Write-Host ""

Write-Host "Kalan service'ler (bossa normal):" -ForegroundColor Cyan
$serviceCheck = kubectl get service demo-app 2>&1
if ($LASTEXITCODE -eq 0 -and $serviceCheck -notmatch "NotFound") {
    kubectl get service demo-app
} else {
    Write-Host "   Hic service yok. OK" -ForegroundColor Green
}
Write-Host ""

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Sistem temiz!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan