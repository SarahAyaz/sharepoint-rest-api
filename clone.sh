project=$(yq e '.devops.project' ./parameters.yaml)
repo_list=()
while IFS= read -r line
do
    file_name="${line#- }"
    repo_list+=("$file_name")
done < <(yq e '.archive_file_config.list' ./parameters.yaml)

for repo in ${repo_list[@]}
do
    echo "Cloning $repo"
    az repos show -r $repo --query sshUrl -p $project | tr -d '"' | while read sshUrl ; do git clone ${sshUrl} archive/$repo ; done
    cd archive/$repo
    git archive --format zip -o ../$repo.zip HEAD
    cd ..
    rm -r -f $repo
    cd ..
done    

echo "Archive complete"
