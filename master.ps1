New-Item ".\report" -itemType Directory ;
&"$PSScriptroot\resources.ps1"
&"$PSScriptroot\orphanDisk.ps1"
&"$PSScriptroot\orphanIp.ps1"
&"$PSScriptroot\orphanNsg.ps1"
&"$PSScriptroot\orphanNic.ps1"
&"$PSScriptroot\orphanRg.ps1"
&"$PSScriptroot\orphanAppsrvcs.ps1"
&"$PSScriptroot\orphanRT.ps1"
&"$PSScriptroot\orphanLB.ps1"




