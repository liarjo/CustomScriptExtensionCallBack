Param(
[Parameter(Mandatory=$true)]
[string] $subId
)

#Sample URL Target Callback with subsdcription ID as a parameter
$target="http://www.bing.com/search?q={0}" -f $subId 

Invoke-WebRequest -Uri $target
