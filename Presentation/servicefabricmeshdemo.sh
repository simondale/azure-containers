# deploy to service fabric mesh
az mesh deployment create --resource-group $RESOURCE_GROUP \
                          --template-file servicefabricmesh.json \
                          --parameters "{'codePackageName': { 'value': '$IMAGE_NAME' }, 'codePackageImage': {'value' : '$IMAGE_TAG' }, 'registryServer': {'value': '$REGISTRY_SERVER' }, 'registryUsername': {'value':'$REGISTRY_USERNAME'}, 'registryPassword': {'value': '$REGISTRY_PASSWORD'}, 'location': {'value':'$LOCATION'}}"

: ${MESH_URL="http://`az mesh gateway show --resource-group $RESOURCE_GROUP --name Gateway --output json | jq -r .ipAddress`:`az mesh gateway show --resource-group $RESOURCE_GROUP --name Gateway --output json | jq -r .tcp[0].port`"}

echo "Calling Service Fabric Mesh application: $MESH_URL"
curl $MESH_URL
echo
