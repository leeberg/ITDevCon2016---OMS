Find-Module AzureRM.OperationalInsights | Install-Module
Login-AzureRmAccount -SubscriptionId 'SubID' -TenantId 'TenID'

$ResourceGroupName = "rgname"
$WorkSpaceName = "WorkSpaceName" 


#Get all saved searches
$query = Get-AzureRmOperationalInsightsSavedSearch `
 -ResourceGroupName $ResourceGroupName `
 -WorkspaceName $WorkSpaceName
$query.value | Format-List


#Execute a specific saved search

$result = Get-AzureRmOperationalInsightsSavedSearchResults `
-ResourceGroupName $ResourceGroupName `
-WorkspaceName $WorkSpaceName `
-SavedSearchId "SavedSearchID"
$result.value | ConvertFrom-Json




#Execute an ad-hoc query with a start and end time

$dynamicQuery = "Type=Event | Measure count() by Computer"
$StartDateAndTime = "2016-10-10T18:20:58.8Z"
$EndDateAndTime = "2016-10-12T18:30:58.8Z"
$result = Get-AzureRmOperationalInsightsSearchResults `
-ResourceGroupName $ResourceGroupName `
-WorkspaceName $WorkSpaceName `
-Query $dynamicQuery `
-Start $StartDateAndTime `
-End $EndDateAndTime
$result.Value | ConvertFrom-Json