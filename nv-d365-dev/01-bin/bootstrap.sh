#!/bin/bash
set -e

# Only run this script once to setup terraform state bucket
# Storage account key should be saved in Azure Vault
# Working as of July 2022

RESOURCE_GROUP_NAME=nv-d365-dev-core
STORAGE_ACCOUNT_NAME=nvd365tfstate
CONTAINER_NAME=nv-tf-state
LOCATION=westeurope
SUBSCRIPTION_NAME=NV-D365-Dev
VAULT_OWNER_GROUP="NV TechOps Role"
VAULT_ROLE="Key Vault Administrator"

# Set right subscription
az account set --subscription $SUBSCRIPTION_NAME

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob --allow-blob-public-access false

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# Create a vault to store storage account key
az keyvault create --name $RESOURCE_GROUP_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION --enable-rbac-authorization

# Set Permissions on vault
ASSIGNEE=$(az ad group show --group $VAULT_OWNER_GROUP | | jq -r .id)
SUBSCRIPTION_ID=$(az account show | jq -r .id)

azlatest role assignment create  --role $VAULT_ROLE --assignee $VAULT_OWNER_GROUP --scope "/subscriptions/bd728441-1b83-4daa-a72f-91d5dc6284f1/resourceGroups/${RESOURCE_GROUP_NAME}/providers/Microsoft.KeyVault/vaults/${RESOURCE_GROUP_NAME}"

# Add storage account key to vault
az keyvault secret set --vault-name $RESOURCE_GROUP_NAME --name "tfstate-storage-account" --value $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "To set storage account key, run:"
printf "\nexport ARM_ACCESS_KEY=\$(az keyvault secret show --name tfstate-storage-account --vault-name $RESOURCE_GROUP_NAME --query value -o tsv)\n\n"
