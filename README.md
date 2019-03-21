# Azure Containers 

## Prerequisites

The following software is required to run these examples:

* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* [jq](https://stedolan.github.io/jq/)

Once these are installed run the following command:

```
az extension add --name mesh
```

## Instructions

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