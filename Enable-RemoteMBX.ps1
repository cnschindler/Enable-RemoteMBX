[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    $Identity,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Regular","Room","Equipment","Shared")]
    $MailboxType
)

$RemoteRoutingDomain = "@ntxbocgat.mail.onmicrosoft.com"

[hashtable]$Params = @{
    Identity = $Identity
    RemoteRoutingAddres = ($Identity + $RemoteRoutingDomain)
}

function EnableRMBX
{
    [CmdletBinding()]
    Param(
        [hashtable]$Params
    )

    try
    {
        Enable-RemoteMailbox $Params -ErrorAction Stop
        Write-Host -ForegroundColor Green -Object "Successfullly enabled a Remote Mailbox for User $($Identity)."
    }
    
    catch
    {
        Write-Host -ForegroundColor Red -Object "Error enabling Remote Mailbox for User $($Identity). $($_)" 
    }
}

Switch ($MailboxType)
{
    "Room" {$Params.Add("Room",$null)}
    "Equipment" {$Params.Add("Equipment",$null)}
    "Shared" {$Params.Add("Shared",$null)}
    Default {}
}

EnableRMBX -Params $Params
