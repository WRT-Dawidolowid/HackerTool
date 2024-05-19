param (
    [string]$ip
)

$response = Invoke-RestMethod -Uri "http://ip-api.com/json/$ip"
if ($response.status -eq "success") {
    Write-Host "Geolocation: Success" -ForegroundColor Yellow
    Write-Host "Query: $($response.query)" -ForegroundColor Red
    Write-Host "   ISP: $($response.isp)" -ForegroundColor White
    Write-Host "   ORG: $($response.org)" -ForegroundColor White
    Write-Host "   AS: $($response.as) "-ForegroundColor White
    Write-Host "Country: $($response.country) ($($response.countryCode))" -ForegroundColor Green
    Write-Host "   Timezone: $($response.timezone)" -ForegroundColor White
    Write-Host "   Region: $($response.regionname) ($($response.region))" -ForegroundColor Green
    Write-Host "      City: $($response.city)" -ForegroundColor White
    Write-Host "      ZIP: $($response.zip)" -ForegroundColor White
    Write-Host "      Lat: $($response.lat)" -ForegroundColor White
    Write-Host "      Lon: $($response.lon)" -ForegroundColor White
} else {
    Write-Host "Geolocation: Failed" -ForegroundColor Yellow
    Write-Host "Request failed with query $($response.query)" -ForegroundColor Red
}
