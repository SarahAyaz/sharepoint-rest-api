## Clean DevOps
This repo aids in the process of archiving old DevOps repos to Sharepoint site

**Outcomes**
- Clone repositories and compress them
- Upload the compressed files to Sharepoint site

**Prerequisites**
- [Create a PAT](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows) with Read, Write and Manage scope in Azure DevOps
- Access to Sharepoint site


**Steps**
- Clone the repo
- Set ENV variables (if required)
- Replace values in yaml configuration file
- Execute entrypoint.sh