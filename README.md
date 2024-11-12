# Enable-RemoteMBX

Script to enable a remote mailbox for an existing AD user.

Replace "@mytenant.mail.onmicrosoft.com" for variable $RemoteRoutingDomain.

Use value of AD SamAccountName for the "-Identity" Parameter.

RemoteRoutingAddress will be automatically generated based on "-Identity" and $RemoteRoutingDomain.

Parameter "-MailboxType" allows specifying which mailbox will be created (e.g. Room, Shared, etc.)
