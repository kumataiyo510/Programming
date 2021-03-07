####################################
# XXXXXXXX
####################################

$SETPWD = "XX"
$script:XXOU  = "OU=XX,DC=XX,DC=XX"
$script:XXOU  = "OU=XX,DC=XX DC=XX"
$XXOU = "CN=XX,DC=XX,DC=XX"
$XXOU = "OU=XX,DC=XX,DC=XX"
$COUNTER   = 0
$STOP      = 16
$EX        = 48
$YESORNO   = 4
$YES       = 6
$NO        = 7

# XXXX XXX
$secpwd = ConvertTo-SecureString $SETPWD -AsPlainText -Force
$script:mailnummem = 0
$script:accountlists = [System.Collections.ArrayList]::new()
$script:file = ".\XX.ps1"
$script:file = ".\XX.ps1"
$script:memaccount = [System.Collections.ArrayList]::new()


####################################
# XXXX
####################################

# PeopleXXXX
class People{
    # XXXXXXXX
    $kensuu
    $syubetsu
    $sei
    $mei
    $romasei
    $romamei
    $nowdeps
    $nextdeps
    $nowyakus
    $nextyakus
    $kaikeinenflg
    $yakusyokuflg
    $nowzokus  = [System.Collections.ArrayList]::new()
    $nextzokus = [System.Collections.ArrayList]::new()
    $counter = 0
    $accountname
    $email
    $emgc = 0


    # XXX
    People($inkensuu, $insyubetsu, $insei, $inmei, $inromasei, $inromamei, $innowdep, $innextdep, $innowyaku, $innextyaku, $inkaikeinenflg){
        $this.kensuu    = $inkensuu
        $this.syubetsu  = $insyubetsu
        $this.sei       = $insei
        $this.mei       = $inmei
        $this.romasei   = $inromasei
        $this.romamei   = $inromamei
        $this.nowdeps   = $innowdep -split ":"
        $this.nextdeps  = $innextdep -split ":"
        $this.nowyakus  = $innowyaku -split ":"
        $this.nextyakus = $innextyaku -split ":"
        $this.kaikeinenflg = $inkaikeinenflg

        # XXXXX
        $this.getAccountname()

        # XXXX設XX
        foreach($nextyaku IN $this.nextyakus){
            $this.setYakusyokuflg($nextyaku)
        }

        # XXXXXXX
        if(($this.kaikeinenflg -eq 0) -or ($this.yakusyokuflg -eq 1)){
            $this.getEmail()
        }

        # X
        $this.makeNijihai("nowdeps", "nowyakus", "nowzokus")

        # XXX
        $this.makeNijihai("nextdeps", "nextyakus", "nextzokus")
    }

    # XXXXXX

    # XX
    newPerson(){
        # XXXXXX
        try{
            Get-ADUser -Identity $this.accountname
            $message = "errormessage"
            $popupw = New-Object -ComObject wscript.shell
            $result = $popupw.Popup($message, 0, "errormessage", $script:YESORNO)
            
            # XXXXXX
            if($result -eq $script:YES){
                exit
            }
            
            # X
            for($i = 1; $i -le ($this.romamei).Length; $i++){
                $account  = ($this.romamei).Substring(0, $i) + "." + $this.romasei

                try{
                    # XXXXXXX（XXXXX）X
                    $result = Get-ADUser -Identity $account
                }
                catch{
                    # XXXXXXX（X）XXXXX
                    try{
                        if(!($script:memaccount.Contains($account))){
                            $this.accoutnna = $account
                            return
                        }
                        else {
                        }
                    }
                    catch {
                        $this.accountname = $account
                        return
                    }
                }
            }
            throw
        }
        catch{
            # XX
            $line = "New-ADUser $($this.accountname) -Surname `"$($this.sei)`" -GivenName `"$($this.mei)`" -DisplayName `"$($this.accountname)`" -SamAccountName `"$($this.accountname)`" -Path `"$script:XXOU`" -AccountPassword `$secpwd -ChangePasswordAtLogon `$true -EmailAddress `"test$($this.email)@XX.XX..jp`" -UserPrincipalName `"$($this.accountname)`@XX.XX`" -Enabled `$true"
            $line2 = "Add-ADGroupMember `"PSO_KOJIN_Group`" -Members `"$($this.accountname)`""
            $line | Out-File -FilePath $script:file -Encoding default -Append
            $line2 | Out-File -FilePath $script:file -Encoding default -Append        
           
            $line = "New-ADUser $($this.accountname) -Surname `"$($this.sei)`" -GivenName `"$($this.mei)`" -DisplayName `"$($this.accountname)`" -SamAccountName `"$($this.accountname)`" -Path `"$script:XXOU`" -EmailAddress `"test$($this.email)@XX.XX..jp`" -UserPrincipalName `"$($this.accountname)`@XX.XX`" -PasswordNotRequired `$true -Enabled `$true"
            $line2 = "Add-ADGroupMember `"SHAREACCOUNT`" -Members `"$($this.accountname)`""
            $line | Out-File -FilePath $script:file -Encoding default -Append
            $line2 | Out-File -FilePath $script:file -Encoding default -Append
           
            # XX
            for($i = 0; $i -lt ($this.nextzokus).Count; $i++){
                $this.yakusyokuflg = 0
                $nextyaku = $this.nextzokus[$i][1]
                $this.setYakusyokuflg($nextyaku)
                
                if($this.yakusyokuflg -eq 1){
           
                    if($nextyaku -like "*XX"){
                        $line = "Add-ADGroupMember -Identity `"XX`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
           
                        $nextdep = $this.nextzokus[$i][0]
                        $line = "Add-ADGroupMember -Identity `"$nextdep`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                    }
                    else {
                        $line = "Add-ADGroupMember -Identity `"$nextyaku`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                    }
                }
                else{
                    # X
                    $nextdep = $this.nextzokus[$i][0]
                    try{
                        Get-ADGroup -Identity $nextdep
                        $line = "Add-ADGroupMember -Identity `"$nextdep`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                    }
                    catch{
                        $message = "# $($this.kensuu)XXXX`r`nXXXXXX、XXXXXX"
                        $popupw = New-Object -ComObject wscript.shell
                        $popupw.Popup($message, 0, "XXXX", $script:STOP)
                        $lmessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
                        $imessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
                        $popupw = New-Object -ComObject wscript.shell
                        $popupw.Popup($lmessage, 0, "XXXX", $script:STOP)
                        $popupw.Popup($imessage, 0, "XXXX", $script:STOP)
                        $lmessage | Out-File -FilePath $script:file -Encoding default -Append
                        $imessage | Out-File -FilePath $script:file -Encoding default -Append
                        exit
                    }
                }
            }
        }
    }

    # XXX
    exitPerson(){
        try{
            Get-ADUser -Identity $this.accountname | Out-Null
            $line = "Set-ADUser -Identity `"$($this.accountname)`" -Enabled `$false"
            $line | Out-File -FilePath $script:file -Encoding default -Append
            $line | Out-File -FilePath $script:file -Encoding default -Append
        }
        catch{
            # XXXXX
            $popupw = New-Object -ComObject wscript.shell
            $popupw.Popup("$($this.kensuu)XXXX$($this.accountname)XXX", 0, "XXXX", $script:STOP)
            $line = "$($this.kensuu)XXXX$($this.accountname)XXX"
            $line | Out-File -FilePath $script:file -Encoding default -Append
            $line | Out-File -FilePath $script:file -Encoding default -Append
            exit
        }
    }

    # XX
    movePerson(){

        # XXXXXX
        for($i = 0; $i -lt ($this.nowzokus).Count; $i++){
            $this.yakusyokuflg = 0
            $nowyaku = $this.nowzokus[$i][1]
            $this.setYakusyokuflg($nowyaku)
            
            # XXXX
            if($this.yakusyokuflg -eq 1){
                if($nowyaku -like "*XX"){
                    $line = "Remove-ADGroupMember -Identity `"XX`" -Members `"$($this.accountname)`" -Confirm:`$false"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append

                    $nowdep = $this.nowzokus[$i][0]
                    $line = "Remove-ADGroupMember -Identity `"$nowdep`" -Members `"$($this.accountname)`" -Confirm:`$false"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                }
                else {
                    $line = "Remove-ADGroupMember -Identity `"$nowyaku`" -Members `"$($this.accountname)`" -Confirm:`$false"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                }
            }
            else{
                # X
                $nowdep = $this.nowzokus[$i][0]
                try{
                    Get-ADGroup -Identity $nowdep
                    $line = "Remove-ADGroupMember -Identity `"$nowdep`" -Members `"$($this.accountname)`" -Confirm:`$false"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                }
                catch{
                    $message = "# $($this.kensuu)XX`r`nXXXX、XXXXXX"
                    $popupw = New-Object -ComObject wscript.shell
                    $popupw.Popup($message, 0, "XXXX", $script:STOP)
                    $lmessage = "New-ADGroup -Name `"$nowdep`" -DisplayName `"$nowdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nowdep`" -path `"$script:XXOU`""
                    $imessage = "New-ADGroup -Name `"$nowdep`" -DisplayName `"$nowdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nowdep`" -path `"$script:XXOU`""
                    $popupw = New-Object -ComObject wscript.shell
                    $popupw.Popup($lmessage, 0, "XXXX", $script:STOP)
                    $popupw.Popup($imessage, 0, "XXXX", $script:STOP)
                    $lmessage | Out-File -FilePath $script:file -Encoding default -Append
                    $imessage | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
            }
        }  
        # XXXX
        for($i = 0; $i -lt ($this.nextzokus).Count; $i++){
            $this.yakusyokuflg = 0
            $nextyaku = $this.nextzokus[$i][1]
            $this.setYakusyokuflg($nextyaku)
            
            #XXXX
            if($this.yakusyokuflg -eq 1){
                try{
                    if($nextyaku -like "*XX"){
                        $line = "Add-ADGroupMember -Identity `"XX`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                       
                        $nextdep = $this.nextzokus[$i][0]
                        $line = "Add-ADGroupMember -Identity `"$nextdep`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                    }
                    else{
                        Get-ADGroup -Identity $nextyaku
                        $line = "Add-ADGroupMember -Identity `"$nextyaku`" -Members `"$($this.accountname)`""
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                        $line | Out-File -FilePath $script:file -Encoding default -Append
                    }
                }
                catch{
                    $popupw = New-Object -ComObject wscript.shell
                    [void]$popupw.Popup("$($this.kensuu)XX", 0, "XXXX", $script:STOP)
                    $line = "$($this.kensuu)XX"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
            }
            else{
                # X
                $nextdep = $this.nextzokus[$i][0]
                try{
                    Get-ADGroup -Identity $nextdep
                    $line = "Add-ADGroupMember -Identity `"$nextdep`" -Members `"$($this.accountname)`""
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                }
                catch{
                    $message = "# $($this.kensuu)XXXX`r`nXXXX、XXXXXX"
                    $popupw = New-Object -ComObject wscript.shell
                    $popupw.Popup($message, 0, "XXXX", $script:STOP)
                    $lmessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
                    $imessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
                    $popupw = New-Object -ComObject wscript.shell
                    $popupw.Popup($lmessage, 0, "XXXX", $script:STOP)
                    $popupw.Popup($imessage, 0, "XXXX", $script:STOP)
                    $lmessage | Out-File -FilePath $script:file -Encoding default -Append
                    $imessage | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
            }
        }  
    }

    # XX
    getEmail(){
        try{
            $nownum = (Get-ADUser -Identity $this.accountname -Properties mail | Select-Object mail | ForEach-Object {$_.mail -replace "\D", ""})
            if($nownum -eq ""){
                $mailsobj = Get-ADUser -Filter * -Properties mail | Where-Object mail -ne $null | Select-Object mail
                $this.email = $mailsobj -replace "\D", "" | Measure-Object -Maximum
                $this.email = checkMailnum ($this.email).maximum
            }
            else {
                $this.email = $nownum
            }
        }
        catch {
            $mailsobj = Get-ADUser -Filter * -Properties mail | Where-Object mail -ne $null | Select-Object mail
            $this.email = $mailsobj -replace "\D", "" | Measure-Object -Maximum
            $this.email = checkMailnum ($this.email).maximum
        }
    }

    # XXXXX
    getAccountname(){
        $this.accountname = (Get-ADUser -Filter "sn -like ""$($this.sei)"" -and givenName -like ""$($this.mei)""").SamAccountName

        # XXXXX（XXXXX、X）
        if($null -eq $this.accountname){
            $kouho = Get-ADUser -Filter "sn -like ""$($this.sei)"" -or givenName -like ""$($this.mei)"""
            # XX
            foreach($kou IN $kouho){
                $message = $this.sei + $this.mei + "XX" + $kou.Surname + $kou.givenName + "X？`r`n（XXXXX、XX）"
                $result = errMessNuke $message 4

                # XXXXX（XXXXXX）
                if($result -eq 6){
                    $message = "# XXXX（XXXXX）XXXXXXX（CSVXXXXXXX）"
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    $popupw = New-Object -ComObject wscript.shell
                    $popupw.Popup($message, 0, "XXXX", $script:STOP)
                    $this.accountname = $kou.samaccountname
                    $this.emgc = 1
                    return
                }
            }
            # XXXXXX（XXXXXXX）
            for($i = 1; $i -le ($this.romamei).Length; $i++){
                $account  = ($this.romamei).Substring(0, $i) + "." + $this.romasei

                try{
                    # XXXXXXX（XXXXX）X
                    $result = Get-ADUser -Identity $account
                }
                catch{
                    # XXXXXXX（X）XXXXX
                    try{
                        if(!($script:memaccount.Contains($account))){
                            $this.accoutnna = $account
                            return
                        }
                        else {
                        }
                    }
                    catch {
                        $this.accountname = $account
                        return
                    }
                }
            }
        }
    }

    # XX（XXXX）
    makeNijihai($nownextdeps, $nownextyakus, $nownextzokus){
        $i = 0
        foreach($tmpdep IN $this.$nownextdeps){
            $tmp = @($this.$nownextdeps[$i], $this.$nownextyakus[$i])
            $this.$nownextzokus.Add($tmp)
            $this.$nownextzokus[$i]
            $i ++
        }
    }

    # XX [bool]$XXXXFALSEXXXXXXNULLXXXX
    checkData(){

        # XXXX項XX（XXXX）
        if((@($this.nowdeps).Length -ne @($this.nowyakus).Length) -or (@($this.nextdeps).Length -ne @($this.nextyakus).Length)){
            $message = $this.kensuu + "X"
            errMessNuke $message 16
            $message | Out-File -FilePath $script:file -Encoding default -Append
            $message | Out-File -FilePath $script:file -Encoding default -Append
            exit
        }

        # XXXXXXX
        Switch($this.syubetsu){
            {$_ -eq "XX"} {
                if($this.kensuu -eq "" -or $this.sei -eq "" -or $this.mei -eq "" -or $this.romasei -eq "" -or $this.romamei -eq "" -or [bool]$this.nextdeps -eq $false -or [bool]$this.nextyakus -eq $false -or $this.kaikeinenflg -eq ""){
                    $message = $this.kensuu + "XXXX、XXX！" 
                    errMessNuke $message 16
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
                ;break
            }
            {$_ -eq "XXX"} {
                if($this.kensuu -eq "" -or $this.sei -eq "" -or $this.mei -eq "" -or [bool]$this.nowdeps -eq $false -or [bool]$this.nowyakus -eq $false -or $this.kaikeinenflg -eq ""){
                    $message = $this.kensuu + "XXXX、XXX！" 
                    errMessNuke $message 16
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
                ;break
            }
            {$_ -eq "XX"} {
                if($this.kensuu -eq "" -or $this.sei -eq "" -or $this.mei -eq "" -or [bool]$this.nowdeps -eq $false -or [bool]$this.nextdeps -eq $false -or [bool]$this.nowyakus -eq $false -or [bool]$this.nextyakus -eq $false -or $this.kaikeinenflg -eq ""){
                    $message = $this.kensuu + "XXXX、XXX！" 
                    errMessNuke $message 16
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    $message | Out-File -FilePath $script:file -Encoding default -Append
                    exit
                }
                ;break
            }
            default {
                $message = $this.kensuu + "XXXXXXXX「XX」XXXX「XXX」XXXX「XX」XXXXX！"
                errMessNuke $message 16
                $message | Out-File -FilePath $script:file -Encoding default -Append
                $message | Out-File -FilePath $script:file -Encoding default -Append
                exit
                ;break
            }
        }
    }

    # XXXX設XXXX
    setYakusyokuflg($nextyaku){
        if($this.yakusyokuflg -lt 1){
            switch($nextyaku){
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                {$_ -like "*XX"} {$this.yakusyokuflg = 1; break}
                default {$this.yakusyokuflg = 0; break}
            }
        }
    }

    # DEBUGXXXXXX
    writeDebug($message){
        Write-Host $this.kensuu "XX" "$message"
    }
}


####################################
# XX
####################################

# XXXX
Function errMessNuke($message, $kind){
    $popupw = New-Object -ComObject wscript.shell
    $result = $popupw.Popup($message, 0, "XXXX", $kind)
    return $result
}

# XX
### XXX
Function getShareaccount($dep){
    try{
        $groupmember = Get-ADGroupMember -Identity $dep | Where-Object SamAccountName -Like "*-*"
        return $groupmember
    }
    catch{
        # XXX
        try{
            if(Get-ADGroup -Identity $dep){
                # XXX
                $popupw = New-Object -ComObject wscript.shell
                $result = $popupw.Popup("$dep XXXXXXXX", 0, "XXXX", $STOP)
                $line = "$dep XXXXXXXX"
                $line | Out-File -FilePath $script:file -Encoding default -Append
                $line | Out-File -FilePath $script:file -Encoding default -Append

                # XXXXXXX
                $lmessage = @()
                $imessage = @()
                $lmessage[0] = "New-ADUser -Surname $dep -DisplayName `"XXXXX<example>`" -SamAccountName `"XXXXX<example>`" -Path $script:XXOU -AccountPassword `"XX`" -ChangePasswordAtLogon `$true -EmailAddress `"test番XX@XX.XX..jp`" -UserPrincipalName `"XXXXX<example>`"`@XX.XX -Enabled `$true"
                $lmessage[1] = "Add-ADGroupMember -Identity $dep -Members `"XXXXX<example>`""
                $lmessage[2] = "Add-ADGroupMember -Identity `"SHAREACCOUNT`" -Members `"XXXXX<example>`""
                $imessage[0] = "New-ADUser -Surname $dep -DisplayName `"XXXXX<example>`" -SamAccountName `"XXXXX<example>`" -Path $script:XXOU -EmailAddress `"test番XX@XX.XX..jp`" -UserPrincipalName `"XXXXX<example>`"`@XX.XX -Enabled `$true"
                $imessage[1] = "Add-ADGroupMember -Identity $dep -Members `"XXXXX<example>`""
                $imessage[2] = "Add-ADGroupMember -Identity `"SHAREACCOUNT`" -Members `"XXXXX<example>`""

                $popupw = New-Object -ComObject wscript.shell
                for($i = 0; $i -le 2; $i++){
                    $popupw.Popup($lmessage[$i], 0, "XX", $STOP)
                    $lmessage[$i] | Out-File -FilePath $script:file -Encoding default -Append
                }
                for($i = 0; $i -le 2; $i++){
                    $popupw.Popup($imessage[$i], 0, "XX", $STOP)
                    $imessage[$i] | Out-File -FilePath $script:file -Encoding default -Append
                }
                exit
            }
        }
        catch{
            # XXXXX
            $popupw = New-Object -ComObject wscript.shell
            $result = $popupw.Popup("$dep XXX", 0, "XXXX", $STOP)
            $line = "$dep XXX"
            $line | Out-File -FilePath $script:file -Encoding default -Append
            $line | Out-File -FilePath $script:file -Encoding default -Append
            
            # 
            $lmessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
            $imessage = "New-ADGroup -Name `"$nextdep`" -DisplayName `"$nextdep`" -GroupScope Global -GroupCategory Security -SamAccountName `"$nextdep`" -path `"$script:XXOU`""
            $popupw = New-Object -ComObject wscript.shell
            $popupw.Popup($lmessage, 0, "XXXX", $STOP)
            $popupw.Popup($imessage, 0, "XXXX", $STOP)
            $lmessage | Out-File -FilePath $script:file -Encoding default -Append
            $imessage | Out-File -FilePath $script:file -Encoding default -Append
            exit
        }
    }
}

Function checkMailnum($inmailnum){
    if($script:mailnummem -eq $inmailnum){
        $script:mailnummem = $inmailnum + 1
    }
    elseif($script:mailnummem -gt $inmailnum){
        $script:mailnummem = $mailnummem + 1
    }
    elseif($script:mailnummem -eq 0){
        $script:mailnummem = $inmailnum
    }
    return $script:mailnummem
}


####################################
# XXXX
####################################

# CSVX込XX
$file = Import-Csv .\jinji.csv -Encoding Default

# XXXXXXX
if(Test-Path $script:file){
    Remove-Item -Path $script:file
}

if(Test-Path $script:file){
    Remove-Item -Path $script:file
}

# XX
New-Item $file -ItemType File | Out-Null
New-Item $file -ItemType File | Out-Null

# X込XX
$line = '$SETPWD = "XX"'
$line | Out-File -FilePath $script:file -Encoding default -Append
$line | Out-File -FilePath $script:file -Encoding default -Append

$line = '$secpwd = ConvertTo-SecureString $SETPWD -AsPlainText -Force'
$line | Out-File -FilePath $script:file -Encoding default -Append
$line | Out-File -FilePath $script:file -Encoding default -Append

# XXXX
if(Test-Path .\RemoveFile.ps1){
    Remove-Item -Path .\RemoveFile.ps1
}
New-Item -Path .\RemoveFile.ps1 | Out-Null

# XXXXXXXX
foreach($person IN $file){
    # XXX
    $personobj = New-Object People($person.XX, $person.XX, $person.XX, $person.XX, $person.sei, $person.mei, $person.XX, $person.XX, $person.XX, $person.XX, $person.XX)

    # XXXX
    if($personobj.emgc -eq 1){
        exit
    }

    # XXX
    $personobj.checkData()

    # XXXXXX、XXXXXXX
    if($script:memaccount.Contains($personobj.accountname)){
        $personobj.getAccountname()
    }
    [void]$script:memaccount.Add($personobj.accountname)

    # XXXX込XX（XX.Xx）
    "# " + $($personobj.kensuu) + "XX" + $($personobj.sei) + $($personobj.mei) | Out-File -FilePath $file -Encoding default -Append
    "# " + $($personobj.kensuu) + "XX" + $($personobj.sei) + $($personobj.mei) | Out-File -FilePath $file -Encoding default -Append
    
    # XXXXXXXX
    if($personobj.yakusyokuflg -eq 1){
        
        # XX系XXXX
        switch($personobj.syubetsu){
            "XX" {$personobj.newPerson();break}
            "XXX" {$personobj.exitPerson();break}
            "XX" {$personobj.movePerson();break}
            defaul {;break}
        }
    }

    # X
    else {
        # kaikeinenflgXX
        if($personobj.kaikeinenflg -ne 1){
            
            # XXXXXXXX
            switch($personobj.syubetsu){
                "XX" {$personobj.newPerson();break}
                "XXX" {$personobj.exitPerson();break}
                "XX" {$personobj.movePerson();break}
                default {Write-Host "XXXXXXX";break}
            }
        }
        
        # kaikeinenflgXXXX、XXXXX
        elseif(($personobj.kaikeinenflg -eq 1) -and ($personobj.yakusyokuflg -ne 1)){

            switch($personobj.syubetsu){
                # XXXXXXXX
                {($_ -like "XX") -or ($_ -like "XX")} {
                    for($i = 0;$i -lt ($personobj.nextzokus).Count;$i ++){
                    
                        # XXXXXXX
                        $message = getShareaccount $personobj.nextzokus[$i][0]
                        $message = "# " + $personobj.kensuu + "XXXX" + $message.SamAccountName + "XXXX"
                        $popupw = New-Object -ComObject wscript.shell
                        $result = $popupw.Popup($message, 0, "XXXX事項", $EX)
                        $message | Out-File -FilePath $script:file -Encoding default -Append
                        $message | Out-File -FilePath $script:file -Encoding default -Append

                        try{
                            Get-ADUser -Identity $personobj.accountname | Out-Null
                            $personobj.exitperson()
                        }
                        catch{
                        }
                        ;break
                    }
                }
                # XXX
                "XXX" { 
                    $popupw = New-Object -ComObject wscript.shell
                    [void]$popupw.Popup("$($personobj.kensuu)XXXX、XXX", 0, "XXXX", $EX)
                    $line = "# $($personobj.kensuu)XXXX、XXX"
                    $line | Out-File -FilePath $script:file -Encoding default -Append
                    $line | Out-File -FilePath $script:file -Encoding default -Append

                    try{
                            Get-ADUser -Identity $personobj.accountname | Out-Null
                            $personobj.exitperson()
                    }
                    catch{
                    }
                    ; break
                }
                default {Write-Host "XXXXXXX"; break}
            }
        }
    }

    # XXXXXX
    $testline = "Remove-ADUser -Identity `"$($personobj.accountname)`" -Confirm:`$false"
    $testline | Out-File -FilePath .\RemoveFile.ps1 -Encoding default -Append
}