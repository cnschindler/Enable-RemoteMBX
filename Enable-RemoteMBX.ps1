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
