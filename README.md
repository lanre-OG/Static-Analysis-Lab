
### Step 1
First things first, Install docker to proceed [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)


```bash
# clone repo into the install directory
git clone https://github.com/lanreogunmola/I-Study.git .
 
 
# build image from docker file 
  mkdir docker-clang
  cd docker-clang
  
docker build -f /path/to/a/Dockerfile .
