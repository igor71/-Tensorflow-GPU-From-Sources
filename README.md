# -Tensorflow-GPU-From-Sources
Build Tesorflow GPU Package From The Sources

Tensorflow package can be builded from the sources based on python 2.7 or 3.6

In order to build package for proper python version need to change in jenkins configuration

appropriate docker cload template:

Lables: Tflow-GPU-Python-3.6-srv-<server-nuber here>

Docker Image: yi/tflow-build:0.6-python-v.3.6.3 -->> for python 3.6

              yi/tflow-build:0.6 -->> for python 2.7
              
