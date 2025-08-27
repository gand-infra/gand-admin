$msg = ">>>NOW LOADING<<<"

for ($i = 0; $i -lt 100; $i++) {
    $out = $msg.Substring($i % $msg.Length) + $msg.Substring(0, $i % $msg.Length)
    Write-Host -NoNewline "`r$out"
    #Determines how long the scrolling text appears for
    Start-Sleep -Milliseconds 120
    }
Write-Host ""