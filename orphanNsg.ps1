$subscriptions = Get-AzSubscription | Where-Object { $_.Id -NotIn $excludedSubs }

foreach ($subscription in $subscriptions) {
        
    # set context to the current subscription
    $subscriptionId = $subscription.id
    Set-AzContext -SubscriptionId $subscriptionId

    
$Token = (Get-AzAccessToken)
$Headers = @{Authorization = "Bearer {0}" -f ($Token. Token) }
$Uri = "https://management.azure.com/providers/Microsoft.ResourceGraph/resources?api-version=2021-03-01"
$Results = @()
$Query = "Resources| where type =~ 'microsoft.network/networksecuritygroups' and isnull(properties.networkInterfaces) and isnull(properties.subnets)| project Resource=id, resourceGroup, subscriptionId, location"
[System.Collections.ArrayList]$Collections = @()
do{
    $Body = [pscustomobject]@{
        subscriptions = @($(Get-AzSubscription). SubscriptionId)
        query = $Query
        options = [pscustomobject]@{
            "`$skipToken" = $skipToken
        }
    } | ConvertTo-Json -Depth 10
$Results = (Invoke-RestMethod -Uri $Uri -Method Post -ContentType 'application/json' -Body $Body -Headers $Headers -Verbose)
$Collections.AddRange($Results.data)
$skipToken = $Results.'$skipToken'
} until ($null -eq $skipToken)

$Collections | Export-Csv .\report\orphanNsgList.csv -NoTypeInformation

}

