# Azure Containers 

Edit `env.sh` and set GITHUB_URL and GITHUB_ACCESSTOKEN.

Use the following so changes and secrets are not accidentally committed
```
git update-index --assume-unchanged env.sh
``` 

Run the following commands to deploy the container:

```
. acrdemo.sh
. acidemo.sh
. servicefabricmeshdemo.sh
```

To clean up the resources execute:

```
az group delete --name $RESOURCE_GROUP --yes
```