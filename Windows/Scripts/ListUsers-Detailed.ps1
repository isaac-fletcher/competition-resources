# Author: Dylan Harvey
# lists all the curent users, state, etc. in a nice format. (and groups)

# Function to format user details
function Get-UserDetails {
    param ([Microsoft.PowerShell.Commands.LocalUser]$user)

    $details = @{}
    $details["Name"] = $user.Name
    $details["Enabled"] = $user.Enabled
    $details["Last Logon"] = $user.LastLogon
    $details["Password Changeable"] = $user.PasswordChangeable
    $details["Password Required"] = $user.PasswordRequired
    $details["Account Locked"] = $user.AccountLockedOut
    return $details
}

# List all users with details
Write-Output "Detailed User Information:"
Get-LocalUser | ForEach-Object {
    $userDetails = Get-UserDetails $_
    Write-Output "---------------------------"
    Write-Output "Name: $($userDetails['Name'])"
    Write-Output "Enabled: $($userDetails['Enabled'])"
    Write-Output "Last Logon: $($userDetails['Last Logon'])"
    Write-Output "Password Changeable: $($userDetails['Password Changeable'])"
    Write-Output "Password Required: $($userDetails['Password Required'])"
    Write-Output "Account Locked: $($userDetails['Account Locked'])"
}

# List all groups with members
Write-Output "`nGroups and Members:"
Get-LocalGroup | ForEach-Object {
    Write-Output "---------------------------"
    Write-Output "Group: $($_.Name)"
    $members = Get-LocalGroupMember -Group $_.Name
    if ($members) {
        $members | ForEach-Object { Write-Output "  Member: $($_.Name)" }
    } else {
        Write-Output "  No members in this group."
    }
}

pause