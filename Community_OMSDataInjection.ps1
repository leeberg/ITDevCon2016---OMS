Install-Module -Name OMSDataInjection
#https://www.powershellgallery.com/packages/OMSDataInjection/1.0.1


#requires -Version 3 -Modules OMSDataInjection
$LogName = 'OMSTestData'
$UTCTimeStampField = 'LogTime'
$Now = [Datetime]::UtcNow
$ISONow = "{0:yyyy-MM-ddThh:mm:ssZ}" -f $now
#Change the OMSWorkspaceId
$OMSWorkSpaceId = "b811a"  
$PrimaryKey = "T++IA10p9VN0gr9vMVskbA=="
$SecondaryKey = "afFQtt/vHm0tciRufg=="

#region Test PS object input
$ObjProperties = @{
Computer = $env:COMPUTERNAME
Username = $env:USERNAME
Message  = 'This is a test message injected by the OMSDataInjection module. COMMUNITY Input data type: PSObject'
LogTime  = $Now
}
$OMSDataObject = New-Object -TypeName PSObject -Property $ObjProperties

#Inject data
Write-Output "Injecting PSobject data into OMS"
$InjectData = New-OMSDataInjection -OMSWorkSpaceId $OMSWorkSpaceId -PrimaryKey $PrimaryKey -SecondaryKey $SecondaryKey -LogType $LogName -UTCTimeStampField 'LogTime' -OMSDataObject $OMSDataObject -Verbose
#endregion

#region test JSON input
#Placing the OMS Workspace ID and primary key into a hashtable
$OMSConnection = @{
OMSWorkSpaceId = $OMSWorkSpaceId
PrimaryKey = $PrimaryKey
}
$OMSDataJSON = @"
{
"Username":  "$env:USERNAME",
"Message":  "This is a test message injected by the OMSDataInjection COMMUNITY module. Input data type: JSON",
"LogTime":  "$ISONow",
"Computer":  "$env:COMPUTERNAME"
}
"@
Write-Output "Injecting JSON data into OMS"
$InjectData = New-OMSDataInjection -OMSConnection $OMSConnection -LogType $LogName -UTCTimeStampField 'LogTime' -OMSDataJSON $OMSDataJSON -verbose
#endregion