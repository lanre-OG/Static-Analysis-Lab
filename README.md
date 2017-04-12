
__Static Analysis__: Static code analysis is based on the analysis of the source code (or the bytecode in more advanced analyzers), which allows the identification of specific code patterns prone to security vulnerabilities

#### Static Analysis Techniques
* __Data Flow Analysis__:
* __Control Flow Graph(CFG)__:
* __Taint Analysis__:
* __Lexical Analysis__:

__Clang Analyzer__: Clang is an open-source compiler for the C family of programming language, it is built on the LLVM optimizer and code generator, thus, allowing it to provide high-quality optimization and code generation support for many targets. Clang performs semantic analysis, type checking and builds Abstract Syntax Trees(AST) for all valid input.

### Table of Contents    
[Step 1: Install Docker](#step-1) 

[Step 2: Build clang Docker Image](#step-2) 

[Step 3: Download Codebase](#step-3) 


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
  ``` 
  <img width="699" alt="docker-build" src="https://cloud.githubusercontent.com/assets/18354718/24938951/e1e0739a-1eff-11e7-9a37-c1e69ea84a27.png"> 
  

 ##### Identify image ID, name and container ID
  ```bash
  docker images
  docker ps -a
  ``` 
 ##### Run an interactive shell into the docker image built and confirm if Clang was successfully installed
  ```bash
   docker run -it <IMAGE ID> bash
  ``` 
<img width="698" alt="screen shot 2017-04-11 at 9 54 31 pm" src="https://cloud.githubusercontent.com/assets/18354718/24939249/9cc75c54-1f01-11e7-8ea2-ead7264a5a4e.png">

### Step 3
Download codebase of choice (C or C++). 

For this lab we will be using [NIST SAMATE Juliet Test Suite](https://samate.nist.gov/SRD/view.php?tsID=86) and [Epic modbus](https://github.com/epics-modules/modbus) Programmable Logic Controller and its [dependencies](http://cars.uchicago.edu/software/epics/modbus.html)

##### Mount codebase from location on host machine into docker container
```bash
docker run -it -v <codebase directory on host>:<directory in docker image> <IMAGE ID> bash
docker run -it -v ~/Desktop:/Desktop <IMAGE ID> bash
 ``` 
 <img width="700" alt="screen shot 2017-04-11 at 10 19 33 pm" src="https://cloud.githubusercontent.com/assets/18354718/24939748/0b130dea-1f05-11e7-832e-76d8accec323.png">
