### Tensorflow-GPU-From-Sources as Jenkins Pipline Job
Build Tesorflow GPU Package From The Sources

Tensorflow package can be builded from the sources based on python 2.7 or 3.6

In order to build package for proper python version need to change in jenkins configuration

appropriate docker cloud template:

Lables: Tflow-GPU-Python-3.6-srv-21 or 5, 9 etc

And make sure docker appropriate docker image exist on desired server

Docker Image: 

              yi/tflow-build:0.6-python-v.3.6.3 -->> for tflow version 1.5-1.9 & python 3.6

              yi/tflow-build:0.6 -->> for tflow version 1.5-1.9 & python 2.7
              
              yi/tflow-build:0.7-python-v.3.6.3 -->> for tflow version 1.10 & python 3.6
              
              yi/tflow-build:0.7 -->> for tflow version 1.10 & python 2.7
              
              yi/tflow-build:0.8 -->> for tflow version 1.11 -1.13 & python 2.7
              
              yi/tflow-build:0.8.11-python-v.3.6 -->> for tflow version 1.11 & python 3.6.8
              
              yi/tflow-build:0.8.12-python-v.3.6 -->> for tflow version 1.12 & python 3.6.8
              
              yi/tflow-build:0.8.13-python-v.3.6 -->> for tflow version 1.13 & python 3.6.8
              
              yi/tflow-build:0.9-python-v.3.6 -->> for tflow version 2.0 & Ubuntu 16.04.6 with python 3.6.8
              
              yi/tflow-build:1.0-python-v.3.6 -->> for tflow version 2.0 & Ubuntu 18.04.2 with python 3.6.8
              
              yi/tflow-build:1.1-python-v.3.6 -->> for tflow version 1.13 with CUDA 10.0 & Ubuntu 18.04.2 with python 3.6.8
              
              yi/tflow-build:1.2-python-v.3.6 -->> for tflow version 1.14 with CUDA 10.0 & Ubuntu 18.04.2 with python 3.6.8
              
              
              
 
 ### Tensorflow-GPU-From-Sources Manual build steps
 ```
 pv /media/common/DOCKER_IMAGES/TFlow-Build/yi-tflow-build-ssh-0.x.tar | docker load
 
 pv /media/common/DOCKER_IMAGES/TFlow-Build/yi-tflow-build-ssh-0.x-python-v.3.6.3.tar | docker load
 
 docker images  -->> note image ID
 
 docker tag <Image ID> yi/tflow-build:0.x
  
 docker tag <Image ID> yi/tflow-build:0.x-python-v.3.6.3
 
 ################# Ubuntu 16.04.X ######################################################################
 
 nvidia-docker run -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:0.x 
 
 nvidia-docker run -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:0.x-python-v.3.6.3
 
 ################# Ubuntu 18.04.X ######################################################################
 
 docker run --runtime=nvidia -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:1.x-python-v.3.6
 
 docker exec -it tflow_build /bin/bash
 
 git clone --branch=master --depth=1 https://github.com/igor71/Tensorflow-GPU-From-Sources
 
 cd Tensorflow-GPU-From-Sources
 
 ####### Edit tflow-build.sh for proper tensorflow release version ###############
 
 nano tflow-build.sh
 
 #################################################################################
 
 /bin/bash tflow-build.sh
 
 cd /whl
 
 TFLOW=$(ls | sort -V | tail -n 1)
 
 pv /whl/$TFLOW > /media/common/DOCKER_IMAGES/Tensorflow/Current/$TFLOW
 
 pip --no-cache-dir install --upgrade $TFLOW
 
 cd /
 
 ipython gpu_tf_check.py
 ```
