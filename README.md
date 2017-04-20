
__Static Analysis__: Static code analysis (also referred to as whitebox testing) is based on the analysis of the source code (or the bytecode in more advanced analyzers) without actually running the program. They enable the identification of specific code patterns prone to security vulnerabilities. Static code analysis tools are looking for a specific set of patterns or rules in the software code, very similar to the way antivirus programs search for viruses.

Static code analysis tools and techniques may produce false positives, since they are often based on methods using approximations. A number of tools and methods have sacrificed precision for performance and even accept some form of overapproximation. 

Some of the more advanced tools make it possible to add new rules to a set of predefined ones. We must also be aware that a tool will never find any error if this behavior has not been specified with rules or patterns. Examples of Static analysis tools are Findbugs, Flawfinder, Clang and cppcheck to mention a few.

#### Static Analysis Techniques
* __Data Flow Analysis__: Data flow analysis is about analyzing where data comes from, where data goes to, and how the data will be manipulated. Typical examples of data flow analysis methods includes: reaching definitions, live variables and available expressions
* __Control Flow Graph(CFG)__:
* __Taint Analysis__: Taint Analysis attempts to identify variables that have been 'tainted' with user controllable input and traces them to possible vulnerable functions also known as a 'sink'. If the tainted variable gets passed to a sink without first being sanitized it is flagged as a vulnerability.
* __Lexical Analysis__: Lexical Analysis converts source code syntax into ‘tokens’ of information in an attempt to abstract the source code and make it easier to manipulate.

__Clang Analyzer__: [Clang](https://clang-analyzer.llvm.org/) is an open-source compiler for the C family of programming language, it is built on the LLVM optimizer and code generator, thus, allowing it to provide high-quality optimization and code generation support for many targets. Clang performs semantic analysis, type checking and builds Abstract Syntax Trees(AST) for all valid input.

Not only does the Clang Static Analyzer use the same parser and grammar as the clang compiler, but it uses the resulting Abstract Syntax Tree (AST) to do the analysis. It is also both configurable and extendable; it allows both checkers to be enabled/disabled as well as added.

  AST analysis often adopts a pattern-matching approach where rules for AST patterns are defined and the analysis is accomplished by traversing the AST and checking the visited structures against defined rules.


#### Learning Objectives
* Students will be able to configure and execute software analysis tools 
* Students will be able to analyze software analysis tool reports and understand impact to security objectives

### Table of Content    
[Step 1: Install Docker](#step-1) 

[Step 2: Build clang Docker Image](#step-2) 

[Step 3: Download Codebase](#step-3) 

[Step 4: Compile Codebase with Clang](#step-4) 

#### Step 1
First install docker to proceed [https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/).

#### Step 2
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

#### Step 3
Download codebase of choice (C or C++). 

For this lab we will be using [NIST SAMATE Juliet Test Suite](https://samate.nist.gov/SRD/view.php?tsID=101) and [Epic modbus](https://github.com/epics-modules/modbus) Programmable Logic Controller and its [dependencies](http://cars.uchicago.edu/software/epics/modbus.html)

##### Mount or copy codebase from location on host machine into the docker container
```bash
#docker copy
docker cp <directory on host> image name or container ID: <path on image>
docker cp ~/desktop/codebase faac57a823a8:/usr/bin 

#docker mount volume
docker run -it -v <codebase directory on host>:<directory in docker image> <IMAGE ID> bash
docker run -it -v ~/Desktop:/Desktop <IMAGE ID> bash
 ``` 
 <img width="700" alt="screen shot 2017-04-11 at 10 19 33 pm" src="https://cloud.githubusercontent.com/assets/18354718/24939748/0b130dea-1f05-11e7-832e-76d8accec323.png">

#### Step 4
Navigate into the top directory of mounted codebase and compile codebase with clang using [scan-build](https://clang-analyzer.llvm.org/scan-build.html)
```bash
scan-build 
```
<img width="694" alt="screen shot 2017-04-11 at 10 36 53 pm" src="https://cloud.githubusercontent.com/assets/18354718/24940271/bddb05fc-1f07-11e7-81da-46b6797b8b4a.png">


[Top](#table-of-contents)
