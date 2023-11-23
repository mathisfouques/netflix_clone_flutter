import os

# Function to list all files in a given directory
def list_files_in_directory(directory):
    file_names = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_names.append(os.path.join(root, file)[3:])
    return file_names

# Print the file names
for name in list_files_in_directory("lib/mock"):
    print("export '" +  name + "';")
