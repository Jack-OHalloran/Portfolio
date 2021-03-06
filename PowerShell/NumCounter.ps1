#Program counts from 1 to 9 in 1 second intervals. 
#Numbers are split into 3 different groups, and have a distinct background colour per group.

Write-Host –NoNewLine “Counting from 1 to 9 (in seconds):  “

foreach($element in 1..3){

  Write-Host –NoNewLine  “${element} ” -BackgroundColor “Green” -ForegroundColor “Black”

  Start-Sleep –Seconds 1

}

foreach($element in 4..6){

  Write-Host –NoNewLine  “${element} ” -BackgroundColor “Yellow” -ForegroundColor “Black”

  Start-Sleep –Seconds 1

}

foreach($element in 7..9){

  Write-Host –NoNewLine  “${element} ” -BackgroundColor “Red” -ForegroundColor “Black”

  Start-Sleep –Seconds 1

}

Write-Host “”





