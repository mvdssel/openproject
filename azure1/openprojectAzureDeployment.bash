#!/usr/bin/env bash

# Load dependencies
. ~/bin/printexec
. ~/bin/colors
. ~/bin/pause

# Change these four parameters as needed
RESOURCE_GROUP=huisje
STORAGE_ACCOUNT_NAME=huisje
LOCATION=westeurope
PGDATA_SHARE_NAME=pgdatashare
ASSETS_SHARE_NAME=assetsshare

# Create the storage account with the parameters
pause "Next: Creating storage account..."
printexec az storage account create \
    --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT_NAME \
    --location $LOCATION \
    --sku Standard_LRS

# Retrieve storage account key
pause "Next: retrieval of storage key..."
STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)
echo STORAGE_KEY: $STORAGE_KEY

# Create the file share
pause "Next: creating storage share..."
printexec az storage share create \
  --name $PGDATA_SHARE_NAME \
  --account-name $STORAGE_ACCOUNT_NAME

# Create the file share
pause "Next: creating storage share..."
printexec az storage share create \
  --name $ASSETS_SHARE_NAME \
  --account-name $STORAGE_ACCOUNT_NAME

# Deploy with YAML template
pause "Next: deploying container..."
printexec az container create --resource-group $RESOURCE_GROUP --file ./deploy-openproject.yaml
pause 
