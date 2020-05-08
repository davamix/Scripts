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
___

* [python-template.py](https://github.com/davamix/Scripts/blob/master/python-template.py): script to create a folder structure for a Python project

```
python-template.py [-h] [--docker] name
```
Structure folder created:
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
___

* [arxiv-downloader.py](https://github.com/davamix/Scripts/blob/master/arxiv-downloader.py): script to download pdf papers from [arXiv](https://export.arxiv.org)

```
python3 arxiv-downloader.py
```
There are 3 values that can be configure `url_query`, `start_at` and `max_results`.

More info about how to build the query [https://export.arxiv.org/help/api/user-manual#search_query_and_id_list](https://export.arxiv.org/help/api/user-manual#search_query_and_id_list)

___

* [pdf-image.py](https://github.com/davamix/Scripts/blob/master/pdf-image.py): This script converts all pdf from the source folder into images

```
pdf-image.py [-h] [--group] source
```
By default all images are saved into the `output` folder.

With the `[--group | -g]` option the script will create a folder per pdf into the `output` folder and save the images in there.

___

* [split-data.py](https://github.com/davamix/Scripts/blob/master/split-data.py): This script split the data from a source folder into a training set and validation set.

```
split-data.py [-h] [--validation VALIDATION] source train
```