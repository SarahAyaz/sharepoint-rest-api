## Clean DevOps
This script automate the process of archiving old repos in Azure DevOps

**Outcomes**
- Download the repos as zip
- Upload the zip folders to Sharepoint

**Prerequisites**
- Create a PAT with Read, Write and Manage scope for repositories
- Login to Azure DevOps with token
```
az dveops login --organization "https:dev.azure.com/{MyOrganization}/"
```
