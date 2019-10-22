### Tensorflow-GPU-From-Sources as Jenkins Pipline Job
Build Tesorflow GPU Package From The Sources

Tensorflow package can be build from the sources based on python 2.7 or 3.6

In order to build package for proper python version need to perform following steps:

1. Change in jenkins configuration appropriate docker cloud template:

    `Lables: Tflow-GPU-Python-3.6-srv-21 or 5, 9 etc `
    
   And chose proper docker image that will be used for build proccess (e.g `yi/tflow-build:1.0-python-v.3.6 ` )

2. Make sure appropriate docker build image exist on desired server.

3. Before running Jenkins job, please change `TF_BRANCH=rX.X` in tflow_build.sh desired TF version, e.g  `TF_BRANCH=r2.0 `

#### Note, In this branch auto_build.sh .tf_configure.bazelrc files will be used for compilation proccess.

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
  
 docker tag <Image ID> yi/tflow-build:0.x-python-v.3.6
 
 ################# Ubuntu 16.04.X ######################################################################
 
 nvidia-docker run -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:0.x 
 
 nvidia-docker run -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:0.x-python-v.3.6
 
 ################# Ubuntu 18.04.X ######################################################################
 
 docker run --runtime=nvidia -d -p 37001:22 --name tflow_build -v /media:/media yi/tflow-build:1.x-python-v.3.6
 
 docker exec -it tflow_build /bin/bash 
 
 Or used preconfigured function yi-dockeradmin
 
 yi-dockeradmin tflow_build
 
 ###################### Build TF Package ###################################################
 
 git clone --branch=develop --depth=1 https://github.com/igor71/Tensorflow-GPU-From-Sources
 
 cd Tensorflow-GPU-From-Sources
 
 ####### Edit tflow-build.sh for proper tensorflow release version ###############
 
 nano tflow-build.sh
 
 #################################################################################
 
 su jenkins
 
 /bin/bash tflow-build.sh
 
 exit
 
 cd /whl
 
 TFLOW=$(ls | sort -V | tail -n 1)
 
 pv /whl/$TFLOW > /media/common/DOCKER_IMAGES/Tensorflow/Current/$TFLOW
 
 sudo su
 
 pip --no-cache-dir install --upgrade $TFLOW
 
 cd /
 
 python -c "import tensorflow as tf; print(tf.__version__)"
 
 ipython gpu_tf_check.py
 ```
