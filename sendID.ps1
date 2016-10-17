
Param(
[Parameter(Mandatory=$true)]
[string] $subId
)

$target="https://jpggindonesia.azurewebsites.net/api/zerto?code=kz42t7k2csaod9o93wb0bjtxpanoheu9l1oq&subid={0}" -f $subId
Invoke-WebRequest -Uri $target
