: ${CONTAINER_NAME=$IMAGE_NAME}
: ${REGISTRY_SERVER=`az acr show --name $REGISTRY_NAME --output json | jq -r .loginServer`}
: ${REGISTRY_USERNAME=`az acr credential show --name $REGISTRY_NAME --output json | jq -r .username`}
: ${REGISTRY_PASSWORD=`az acr credential show --name $REGISTRY_NAME --output json | jq -r .passwords[0].value`}

# create a container
az container create --name $CONTAINER_NAME \
                    --resource-group $RESOURCE_GROUP \
                    --image $REGISTRY_SERVER/$IMAGE_TAG \
                    --os-type Linux \
                    --ip-address Public \
                    --ports 80 \
                    --registry-login-server $REGISTRY_SERVER \
                    --registry-username $REGISTRY_USERNAME \
                    --registry-password $REGISTRY_PASSWORD

: ${CONTAINER_URL="http://$(az container show --name helloworld --resource-group $RESOURCE_GROUP --query "ipAddress.ip" | sed -e 's/\"//g'):$(az container show --name helloworld --resource-group $RESOURCE_GROUP --query "ipAddress.ports[0].port" | sed -e 's/\"//g')"}

#echo "Calling Azure Container Instance URL: $CONTAINER_URL"
#curl $CONTAINER_URL
#echo ''



