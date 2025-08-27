for ($i = 0; $i -lt 100; $i++) {
    $line = ""
    for ($j = 0; $j -lt 60; $j++) {
        $value = Get-Random -Minimum 0 -Maximum 100
        if ($value -lt 5) {
            $line += "x"
        } else {
            $line += " "
        }
    }
    Write-Host $line
    Start-Sleep -Milliseconds 50
}