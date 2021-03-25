$CompanyName = Read-Host "Please enter your Eloqua Company Name"
$Pod = Read-Host "Please enter your Eloqua Pod Number (found in your eloqua URL ex: secure.p04.eloqua.com would be 04)"
$Username = Read-Host "Please enter your Eloqua Username (First.Last) -- ex: John.Doe"
$Password = Read-Host "Please enter your Eloqua Password"
$Company = $CompanyName + '\' + $Username + ':' + $Password
$Bytes = [System.Text.Encoding]::UTF8.GetBytes($Company)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedID = 'Basic ' + $EncodedText
$Form = Read-Host "Please enter the Eloqua Form ID"
$Record = Read-Host "Please enter the Record/Row ID"
$URL = 'https://secure.p' + $Pod + '.eloqua.com/api/REST/2.0/data/form/' + $Form + '/datarow/' + $Record
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $EncodedID)
$response = Invoke-RestMethod $URL -Method 'DELETE' -Headers $headers
$response | ConvertTo-Json
