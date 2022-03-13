# azure-app-service
Deploy and run a containerized web app with Azure App Service

## Introduction
This terraform code (and related scripts) are based off of the following Microsoft learning path: 
* https://docs.microsoft.com/en-us/learn/modules/deploy-run-container-app-service/

## Local values
### local.az-service-principal
Retrieves information from a locally stored json file and uses it to supply provider authentication information for
authentication against Azure management API
```json
{
  "appId"       : "0000000000",
  "displayName" : "",
  "password"    : "0000000000",
  "subscription": "0000000000",
  "tenant"      : "0000000000"
}
```
### local.github-personal-access-token
Retrieves information from a locally stored json file and uses it to supply authentication information used as part of 
an Azure Container Registry Task
```json
{
  "expires": "YYYY-MM-DD",
  "name": "",
  "token": ""
}
```