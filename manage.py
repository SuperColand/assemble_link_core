import pygrading.project_utils as project
import os

pygrading_version = "1.1.8.dev0"
project_name = "p4-core"
project_version = "0.1"
project_path = os.path.dirname(os.path.abspath(__file__))

if __name__ == '__main__':
    os.chdir(project_path)
    project.main(project_name, project_version, pygrading_version)