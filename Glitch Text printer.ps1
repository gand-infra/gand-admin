function Make-GlitchLine {
    param (
        [string]$FinalText,
        [int]$DelayPerChar = 50, #Will determine how fast it will randomly iterate through $charset per character
        [int]$GlitchInterations = 20 #Determines how many random characters to go through before stopping at intended character
        )
    
    #Define variables
    $charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-=_+"
    $output = ""
    $totalLength = $FinalText.Length

    #Loop to check values per character
    for ($i = 0; $i -lt $FinalText.Length; $i++) {
        $targetChar = $FinalText[$i]
        if ($targetChar -eq " ") {
            $output += " "
            continue
        }

        #Loop to invoke random character glitch text
        for ($j = 0; $j -lt $GlitchInterations; $j++) {
            $randomChar = $charset[(Get-Random -Minimum 0 -Maximum $charset.Length)]
            $fakeOutput = $output + $randomChar
            $clearLine = $fakeOutput.PadRight($totalLength)
            #Moves cursor back to start to overwrite line
            Write-Host -NoNewline "`r$clearLine"
            Start-Sleep -Milliseconds ($DelayPerChar / $GlitchInterations)
            }
        
        $output += $targetChar
        $cleanFinal = $output.PadRight($totalLength)
        Write-Host -NoNewline "`r$cleanFinal"
        }

        Write-Host ""
    }
    
Make-GlitchLine -FinalText "TEST..." -DelayPerChar 80