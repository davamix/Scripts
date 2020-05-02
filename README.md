# Scripts #

* [cpp-template.sh](https://github.com/davamix/Scripts/blob/master/cpp-template.sh): script to create a folder structure for a C++ project with Google Test as a testing framework.

```
sh cpp-template.sh ProjectName
```
Structure folder created:
```
ProjectName/
    src/
        CMakeLists.txt
    tests/
        ProjectName-test.cpp
        CMakeLists.txt
        CMakeLists.txt.in
    build/
    CMakeLists.txt
    .gitignore
```

* [python-template.py](https://github.com/davamix/Scripts/blob/master/python-template.py): script to create a folder structure for a Python project

```
python-template.py [-h] [--docker] name
```

```
name/
    app/
        src/
            __init__.py
            main.py
        Dockerfile
        requirements.txt
    .gitignore
    docker-compose.yaml
```