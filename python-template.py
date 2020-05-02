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
    Path(base_path, "docker-compose.yaml").touch()
    Path(base_path, "app", "Dockerfile").touch()
    Path(base_path, "app", "requirements.txt").touch()
    Path(base_path, "app", "src", "main.py").touch()
    Path(base_path, "app", "src", "__init__.py").touch()
    

parser = argparse.ArgumentParser(description="Generate the basic structure for a Python application")
parser.add_argument("name", help="Application name")

args = parser.parse_args()

app_path = create_folder(args.name)

create_files(app_path)

print(f"Structure for {args.name} created!")