from office365.sharepoint.client_context import ClientContext
from office365.runtime.client_request_exception import ClientRequestException
import yaml
from yaml.loader import SafeLoader

with open("./parameters.yaml", "r") as stream:
    config = yaml.load(stream, Loader=SafeLoader)

ctx = ClientContext(config["sharepoint"]["url"]).with_user_credentials(config["credentials"]["username"], config["credentials"]["password"])

root_folder = ctx.web.default_document_library().root_folder
taget_folder = config["sharepoint"]["target_folder"]

def enum_folder(parent_folder, action):
    parent_folder.expand(["Folders"]).get().execute_query()
    target_url = f"{folder_stat(parent_folder)}/{taget_folder}"
    folder = ctx.web.get_folder_by_server_relative_url(target_url)
    action(folder)

def folder_stat(folder):
    return(folder.serverRelativeUrl)

def upload_files(folder):
    for repo in config["archive_file_config"]["list"]:
        path = f"./archive/{repo}.zip"
        with open(path, 'rb') as f:
            file = folder.files.upload(f).execute_query()
        print("File has been uploaded into: {0}".format(file.serverRelativeUrl))

enum_folder(root_folder, upload_files)