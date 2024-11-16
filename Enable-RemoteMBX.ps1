[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    $Identity,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Regular","Room","Equipment","Shared")]
    $MailboxType
)

# Specify your remote rounting domain. E.g. mytenant.mail.microsoft.com
[string]$RemoteRoutingDomain = ""

if ([String]::IsNullOrWhiteSpace($RemoteRoutingDomain))
{
    Write-Host -ForegroundColor DarkCyan -Object "`nVariable 'RemoteRoutingDomain' not set. Please assign a value and try again. Exiting...`n"
    Exit
}

[hashtable]$Params = @{
    Identity = $Identity
    RemoteRoutingAddres = ($Identity + "@" + $RemoteRoutingDomain)
}

function EnableRMBX
{
    [CmdletBinding()]
    Param(
        [hashtable]$Params
    )

    try
    {
        Enable-RemoteMailbox @Params -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfullly enabled a Remote Mailbox for User $($Identity)."
    }

    catch
    {
        Write-Host -ForegroundColor Red -Object "Error enabling Remote Mailbox for User $($Identity). $($_)" 
    }
}

Switch ($MailboxType)
{
    "Room" {$Params.Add("Room",$true)}
    "Equipment" {$Params.Add("Equipment",$true)}
    "Shared" {$Params.Add("Shared",$true)}
    Default {}
}

EnableRMBX -Params $Params
