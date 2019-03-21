: ${RESOURCE_GROUP="azcontalk"}
: ${LOCATION="westeurope"}
: ${REGISTRY_NAME="azcontalk"}
: ${BUILD_TASK_NAME="helloworld"}
: ${IMAGE_NAME="helloworld"}

# create a resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# create the azure container registry
az acr create --name $REGISTRY_NAME \
              --resource-group $RESOURCE_GROUP \
              --sku Basic \
              --admin-enabled true

# create the build task
az acr task create --name $BUILD_TASK_NAME \
                   --registry $REGISTRY_NAME \
                   --context $GITHUB_URL \
                   --image $IMAGE_NAME:{{.Run.ID}} \
                   --git-access-token $GITHUB_ACCESSTOKEN \
                   --os Linux \
                   --commit-trigger-enabled true \
                   --branch master \
                   --file Dockerfile

# build the container
az acr task run --name $BUILD_TASK_NAME --registry $REGISTRY_NAME

# get the tag
: ${IMAGE_TAG=$IMAGE_NAME:`az acr repository show-tags --name $REGISTRY_NAME --repository $IMAGE_NAME --output json | jq -r .[-1]`}

echo $IMAGE_TAG
