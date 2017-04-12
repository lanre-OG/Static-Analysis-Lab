
__Static Analysis__: Static code analysis is based on the analysis of the source code (or the bytecode in more advanced analyzers), which allows the identification of specific code patterns prone to security vulnerabilities




### Table of Contents    
[Step 1: Install Docker](#step-1) 


### Step 1
First things first, Install docker to proceed [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)


```bash
# clone repo into the install directory
git clone https://github.com/lanreogunmola/I-Study.git .
 
 
# build image from docker file 
  mkdir docker-clang
  cd docker-clang
  
docker build -f /path/to/a/Dockerfile .
