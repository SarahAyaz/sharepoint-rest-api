project=$(python -m yq '.devops.project' ./parameters.yaml | tr -d '"')
repo_list=()

while IFS=', ' read -r line
do
    repo="${line}"
    repo_id=$(az repos show -r $repo --query id -p $project | tr -d '"')
    echo "Deleting $repo with id $repo_id" && \
    az repos delete --yes --id $repo_id -p $project
    repo_list+=("$file_name")
done <<< "$(python -m yq '.archive_file_config.list' ./parameters.yaml | tr -d '[""],' | sed '/^[[:space:]]*$/d')" \
&& echo "Successfully Archived all repositories"
