#!/bin/bash
set -e

# Only run this script once to setup terraform state bucket
# Storage account key should be saved in Azure Vault

RESOURCE_GROUP_NAME=nv-infra-core
STORAGE_ACCOUNT_NAME=nvinfratfstate
CONTAINER_NAME=nv-tf-state
LOCATION=westeurope

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# Create a vault to store storage account key
az keyvault create --name $RESOURCE_GROUP_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION

# Add storage account key to vault
az keyvault secret set --vault-name $RESOURCE_GROUP_NAME --name "tfstate-storage-account" --value $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "To set storage account key, run:"
printf "\nexport ARM_ACCESS_KEY=\$(az keyvault secret show --name tfstate-storage-account --vault-name $RESOURCE_GROUP_NAME --query value -o tsv)\n\n"
