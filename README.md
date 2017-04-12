
__Static Analysis__: Static code analysis is based on the analysis of the source code (or the bytecode in more advanced analyzers), which allows the identification of specific code patterns prone to security vulnerabilities

#### Static Analysis Techniques
* __Data Flow Analysis__:
* __Control Flow Graph(CFG)__:
* __Taint Analysis__:
* __Lexical Analysis__:


### Table of Contents    
[Step 1: Install Docker](#step-1) 

[Step 2: Clang Docker Image](#step-2) 


### Step 1
First install docker to proceed [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/).

[Top](#table-of-contents)

### Step 2
Follow the below steps to install Clang docker Image from Dockerfile.
```bash
# clone repo into the install directory
git clone https://github.com/lanreogunmola/I-Study.git .
 
 
# build image from docker file 
  mkdir docker-clang
  cd docker-clang
  
docker build -f /path/to/a/Dockerfile .
