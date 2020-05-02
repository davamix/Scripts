import os
import argparse
from pathlib import Path

def create_folder(name):
    print("Creating folder structure...")

    app_path = Path(Path.cwd(), name)
    full_path = Path(app_path, "app", "src")
    
    os.makedirs(full_path)

    return app_path

def create_files(base_path):
    print("Adding files...")
    
    Path(base_path, ".gitignore").touch()
    Path(base_path, "app", "requirements.txt").touch()
    Path(base_path, "app", "src", "main.py").touch()
    Path(base_path, "app", "src", "__init__.py").touch()

def add_docker_files(base_path):
    print("Adding docker files...")

    Path(base_path, "docker-compose.yaml").touch()
    Path(base_path, "app", "Dockerfile").touch()
    

parser = argparse.ArgumentParser(description="Generate the basic structure for a Python application")
parser.add_argument("name", help="Application name")
parser.add_argument("--docker", "-d", action="store_true", help="Add Docker Compose and Dockerfile to the project")

args = parser.parse_args()

# Create folder structure
app_path = create_folder(args.name)

# Add files
create_files(app_path)

# Add docker files
if(args.docker):
    add_docker_files(app_path)

print(f"Structure for {args.name} created!")