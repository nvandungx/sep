# Đường dẫn thư mục chứa file .ovpn
$folder = "C:\Users\tung.nguyen\OpenVPN\config\tung.nguyen"

# IP cũ và IP mới
$oldIP = "27\.72\.31\.182"   # nhớ escape dấu chấm nếu dùng regex
$newIP = "27.72.88.64"

# 1️⃣ Backup toàn bộ file trước khi sửa
$backupFolder = "C:\Config Data\backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $backupFolder | Out-Null
Copy-Item "$folder\*.ovpn" $backupFolder

Write-Host "✅ Backup đã tạo ở: $backupFolder"

# 2️⃣ Tìm và replace trong tất cả file .ovpn
Get-ChildItem -Path $folder -Filter "*.ovpn" | ForEach-Object {
    (Get-Content $_.FullName) -replace "remote\s+$oldIP", "remote $newIP" |
        Set-Content $_.FullName -Force
    Write-Host "Đã sửa file:" $_.Name
}

Write-Host "🎯 Hoàn tất! Tất cả file .ovpn đã được thay IP."
