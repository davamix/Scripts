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

def write_file(file_path, content):
    with open(file_path, "w+") as f:
        f.write(content)

parser = argparse.ArgumentParser(description="Generate the basic structure for a Python application")
parser.add_argument("name", help="Application name")
parser.add_argument("--docker", "-d", action="store_true", help="Add Docker Compose and Dockerfile to the project")

args = parser.parse_args()

# Create folder structure
app_path = create_folder(args.name)

# Create files
create_files(app_path)

# Add content to main file
main_content = ''.join(('def run():\n',
                        f'\tprint("Hello {args.name}")\n\n',
                        'if __name__ == "__main__":\n',
                        '\trun()'))

write_file(Path(app_path, "app", "src", "main.py"), main_content)

# Add docker files
if(args.docker):
    add_docker_files(app_path)

    # Dockerfile
    dockerfile_content = ''.join(('# FROM image\n\n',
                            f'WORKDIR /usr/src/{args.name}\n\n',
                            'RUN pip install --upgrade pip\n\n',
                            'ADD ./requirements.txt ./\n\n',
                            'RUN pip install -r requirements.txt\n\n',
                            'ADD . .\n\n',
                            'CMD ["python", "./src/main.py"]'))

    write_file(Path(app_path, "app", "Dockerfile"), dockerfile_content)

    # docker-compose
    compose_content = ''.join(('version: "3.7"\n\n',
                            'services:\n',
                            f'\t{args.name.lower()}:\n',
                            '\t\tbuild: ./app\n',
                            f'\t\timage: {args.name.lower()}:1.0\n'))

    write_file(Path(app_path, "docker-compose.yaml"), compose_content)


print(f"Structure for {args.name} created!")