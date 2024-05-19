if ($args.Count -eq 0) {
    Write-Host "Please provide the path to the JSON file as an argument."
    exit
}

$jsonFilePath = $args[0]
$jsonContent = Get-Content -Path $jsonFilePath -Raw

$jsonData = $jsonContent | ConvertFrom-Json

$method = $jsonData.Method
$urlAPI = $jsonData.urlAPI
$showHTAPIOutput = $jsonData.showHTAPIOutput
$showOutput = $jsonData.showOutput
$postContent = $jsonData.postContent
$color = $jsonData.colorOutput
$colorHO = $jsonData.colorHTAPIOutput

if ($showHTAPIOutput -eq $true) {
    Write-Host "Method: $method" -ForegroundColor $colorHO
    Write-Host "API URL: $urlAPI" -ForegroundColor $colorHO
    Write-Host "Show Output: $showHTAPIOutput" -ForegroundColor $colorHO
}

if ($method -eq "GET") {
    $response = Invoke-RestMethod -Uri $urlAPI -Method $method
} elseif ($method -eq "POST") {
    $response = Invoke-RestMethod -Uri $urlAPI -Method $method -Body ($postContent | ConvertTo-Json) -ContentType "application/json"
} else {
    Write-Host "Unsupported HTTP method: $method"
    exit
}

Write-Host ""
if ($showOutput -eq $true) {
    if ($response) {
        foreach ($field in $response.PSObject.Properties) {
            Write-Host "$($field.Name): $($field.Value)" -ForegroundColor $color
        }
    } else {
        Write-Host "Failed to retrieve data from the API."
    }
}