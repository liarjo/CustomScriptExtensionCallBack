# Deploy a Windows VM and execute a HTTP Callback with Target Azure subscription ID.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fliarjo%2FCustomScriptExtensionCallBack%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fliarjo%2FCustomScriptExtensionCallBack%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


Based on the 201-vm-custom-script-windows template built by: [philon-msft](https://github.com/philon-msft)
##Template objetive
Template’s objective is send a HTTP callback notification every time your template is deployed. You will receive a HTTP GET with target subscription ID as parameter.

##How this template works

This template use [Custom Script extension](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-windows-extensions-customscript/) to call a target URL and pass Azure subscription ID as parameter, in this way every time this template is deployed you will receive a notification with the target subscription’s ID.

The template use a PowerShell script, it is how receive the subscription ID from the ARM on deployment process and execute the HTTP callback.

The template key is the CustomScriptExtension resource, where the script receive and pass parameter using ARM template function **subscription().subscriptionId** and concatenate it like a parameter value.


```json
{
          "type": "extensions",
          "name": "CustomScriptExtension",
          "apiVersion": "2015-05-01-preview",
          "location": "[resourceGroup().location]",
          "dependsOn": [
            "[variables('vmName')]"
          ],
          "properties": {
            "publisher": "Microsoft.Compute",
            "type": "CustomScriptExtension",
            "typeHandlerVersion": "1.8",
            "autoUpgradeMinorVersion": true,
            "settings": {
              "fileUris": [
                "[concat(parameters('_artifactsLocation'), '/', variables('ScriptFolder'), '/', variables('ScriptFileName'), parameters('_artifactsLocationSasToken'))]"
              ],
              "commandToExecute": "[concat('powershell -ExecutionPolicy Unrestricted -File ', variables('ScriptFolder'), '/', variables('ScriptFileName'), ' -subID ', subscription().subscriptionId)]"
            }
          }
        }
```
