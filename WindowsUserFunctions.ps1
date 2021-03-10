
# Creates a user, modifies the user, then removes it. Changes are logged and printed in the terminal

########################################################################################################


#Run in case log sources aren't set up aren't set up
New-EventLog -LogName Application -Source 'AddWindowsUser'
New-EventLog -LogName Application -Source 'ChangeUserPassword'
New-EventLog -LogName Application -Source 'AddToLocalGroup'
New-EventLog -LogName Application -Source 'RemoveWindowsUser'
New-EventLog -LogName Application -Source 'RemoveFromLocalGroup'



function AddWindowsUser {

    [Cmdletbinding()]
    param (
        [string] $Username,
        [SecureString] $Password, 
        [string] $LocalGroup)

    try {
        $Password = Read-Host -AsSecureString
        New-LocalUser -Name "DemoUser" -Description "Assignment Demo User" -Password $Password -ErrorAction Stop
        Write-EventLog -EntryType SuccessAudit -LogName Application -Source "AddWindowsUser" -EventID 1 -Message "Windows User Created"
        
    }
    catch { 
        Write-Host -Object "Error: User with name DemoUser already exists."
        Write-EventLog -EntryType FailureAudit -LogName Application -Source "AddWindowsUser" -EventID 2 -Message "User not created"
        
    }
    
}
AddWindowsUser



Get-LocalUser



function ChangeUserPassword {

    [Cmdletbinding()]
    param (
        [string] $Username, 
        [SecureString] $Password
    )

    try {
        $NewPassword = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force

        $User = Get-LocalUser -Name "DemoUser"
        $User | Set-LocalUser -Password $NewPassword -ErrorAction Stop

        Write-EventLog -EntryType SuccessAudit -LogName Application -Source "ChangeUserPassword" -EventID 1 -Message "User Password Changed"
    }
    catch {
        "Error: Password not changed"
        Write-EventLog -EntryType FailureAudit -LogName Application -Source "ChangeUserPassword" -EventID 2 -Message "Password not changed"
    }
}
ChangeUserPassword


function AddToLocalGroup {

    [Cmdletbinding()]
    param (
        [string] $Username,
        [string] $Group)

    
    try {
        Add-LocalGroupMember -Group "Guests" -Member "DemoUser" -ErrorAction Stop
        Write-EventLog -EntryType SuccessAudit -LogName Application -Source "AddToLocalGroup" -EventID 1 -Message "User added to local group"
    }    
    catch {
        "Error: Could not add user to specified group"
        Write-EventLog -EntryType FailureAudit -LogName Application -Source "AddToLocalGroup" -EventID 2 -Message "Could not add user to specified group"
    }
        
    
        
}
AddToLocalGroup



function RemoveFromLocalGroup {

    [Cmdletbinding()]
    param (
        [string] $Username,
        [string] $Group
    )

    try {
        Remove-LocalGroupMember -Group "Guests" -Member "DemoUser" -ErrorAction Stop
        Write-EventLog -EntryType SuccessAudit -LogName Application -Source "RemoveFromLocalGroup" -EventID 1 -Message "User removed from local group"
    }
    catch {
        "Error: Could not remove specified user from group"
        Write-EventLog -EntryType FailureAudit -LogName Application -Source "RemoveFromLocalGroup" -EventID 2 -Message "Could not remove specified user from group"
    }
}
RemoveFromLocalGroup



function RemoveWindowsUser {

    [Cmdletbinding(SupportsShouldProcess)]
    param (
        [string] $UserName
    )

    try {
        Remove-LocalUser -Name "DemoUser" -WhatIf 
        Remove-LocalUser -Name "DemoUser" -ErrorAction Stop

        Write-EventLog -EntryType SuccessAudit -LogName Application -Source "RemoveWindowsUser" -EventID 1 -Message "Windows User Removed"
    }
    catch { 
        "Error: The specified user does not exist"
        Write-EventLog -EntryType FailureAudit -LogName Application -Source "RemoveWindowsUser" -EventID 2 -Message "User not removed"
    }
}
RemoveWindowsUser


#Get-LocalUser
