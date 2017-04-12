
__Static Analysis__: Static code analysis is based on the analysis of the source code (or the bytecode in more advanced analyzers), which allows the identification of specific code patterns prone to security vulnerabilities

#### Static Analysis Techniques
* __Data Flow Analysis__:
* __Control Flow Graph(CFG)__:
* __Taint Analysis__:
* __Lexical Analysis__:


### Table of Contents    
[Step 1: Install Docker](#step-1) 

[Step 2: Build clang Docker Image](#step-2) 


### Step 1
First install docker to proceed [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/).

[Top](#table-of-contents)

### Step 2
Follow the steps below to build Clang docker Image from Dockerfile.

```bash
# Create directory for project
  mkdir docker-clang
  cd docker-clang

# Clone git repository or copy Dockerfile from repository
  git clone https://github.com/lanreogunmola/I-Study.git .
 
# build Clang image from docker file 
  docker build -f /path/to/a/Dockerfile .
  e.g docker build -f /docker-clang/Dockerfile .
  
 # Identify image ID, name and container ID
   docker images
   
   
