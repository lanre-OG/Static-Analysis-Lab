#### Learning Objectives
* Students will be able to configure and execute software analysis tools 
* Students will be able to analyze software analysis tool reports and understand impact to security objectives

__Static Analysis__: Static code analysis (also referred to as whitebox testing) is based on the analysis of the source code (or the bytecode in more advanced analyzers) without actually running the program. They enable the identification of specific code patterns prone to security vulnerabilities. Static code analysis tools are looking for a specific set of patterns or rules in the software code, very similar to the way antivirus programs search for viruses.

Static code analysis tools and techniques may produce false positives, since they are often based on methods using approximations. A number of tools and methods have sacrificed precision for performance and even accept some form of overapproximation. 

Some of the more advanced tools make it possible to add new rules to a set of predefined ones. We must also be aware that a tool will never find any error if this behavior has not been specified with rules or patterns. Examples of Static analysis tools are Findbugs, Flawfinder, Clang and cppcheck to mention a few.

#### Static Analysis Techniques
* __Data Flow Analysis__: Data flow analysis is about analyzing where data comes from, where data goes to, and how the data will be manipulated. Typical examples of data flow analysis methods includes: reaching definitions, live variables and available expressions
* __Control Flow Graph(CFG)__: CFG is an abstract graph representation of software by use of nodes that represent basic blocks. A node in a graph represents a block; directed edges are used to represent jumps (paths) from one block to another.
* __Taint Analysis__: Taint Analysis attempts to identify variables that have been 'tainted' with user controllable input and traces them to possible vulnerable functions also known as a 'sink'. If the tainted variable gets passed to a sink without first being sanitized it is flagged as a vulnerability.
* __Lexical Analysis__: Lexical Analysis converts source code syntax into ‘tokens’ of information in an attempt to abstract the source code and make it easier to manipulate.

__Clang Analyzer__: [Clang](https://clang-analyzer.llvm.org/) is an open-source compiler for the C family of programming language, it is built on the [LLVM](http://llvm.org) optimizer and code generator, thus, allowing it to provide high-quality optimization and code generation support for many targets. Clang performs semantic analysis, type checking and builds Abstract Syntax Trees(AST) for all valid input.

Not only does the Clang Static Analyzer use the same parser and grammar as the clang compiler, but it uses the resulting Abstract Syntax Tree (AST) to do the analysis. The static analyzer engine performs path-sensitive exploration of the program and relies on a set of checkers to implement the logic for detecting and constructing specific bug reports. These checkers are both configurable and extendable; Thus,the checkers can be enabled/disabled as well as customized. [See how to write custom checkers](http://llvm.org/devmtg/2012-11/Zaks-Rose-Checker24Hours.pdf)

  AST analysis often adopts a pattern-matching approach where rules for AST patterns are defined and the analysis is accomplished by traversing the AST and checking the visited structures against defined rules.

#### Clang Symbolic Execution 
* Performs a path-senstive walk of Clang's CFG
* Similar to program execution but
  * explores every possible path through the program
  * Uses symbolic values
* Collects the constraints on symbolic values along each path
* Uses constraints to determine feasibility of paths


### Table of Content    
[Step 1: Install Docker](#step-1) 

[Step 2: Build clang Docker Image](#step-2) 

[Step 3: Download Codebase](#step-3) 

[Step 4: Compile Codebase with Clang](#step-4) 

[Step 5: Map report warning to CWE's](#step-5) 

[Step 6: Map report warning to CWE's](#step-6) 

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
 
 Displays all images available

  `docker images`
  
 Displays all available container Id's.At this stage of the lab no container ID will be displayed.
 

  `docker ps -a`

  
 ##### Run an interactive shell into the docker image built and confirm if Clang was successfully installed
  ```bash
   docker run -it <IMAGE ID> bash
  ``` 
<img width="698" alt="screen shot 2017-04-11 at 9 54 31 pm" src="https://cloud.githubusercontent.com/assets/18354718/24939249/9cc75c54-1f01-11e7-8ea2-ead7264a5a4e.png">

#### Step 3
Download codebase of choice (C or C++). 

For this lab we will be using [NIST SAMATE Juliet Test Suite](https://samate.nist.gov/SRD/view.php?tsID=101) and [Epic modbus](https://github.com/epics-modules/modbus) Programmable Logic Controller and its [dependencies](http://cars.uchicago.edu/software/epics/modbus.html)

##### Mount or copy codebase from location on host machine into the docker container(Optional)
```bash
#docker copy
docker cp <directory on host> image name or container ID: <path on image>
docker cp ~/desktop/codebase faac57a823a8:/usr/bin 
 ``` 
 OR
 
```bash
#docker mount volume
docker run -it -v <codebase directory on host>:<directory in docker image> <IMAGE ID> bash
docker run -it -v ~/Desktop:/Desktop <IMAGE ID> bash
 ``` 
 <img width="600" alt="screen shot 2017-04-11 at 10 19 33 pm" src="https://cloud.githubusercontent.com/assets/18354718/24939748/0b130dea-1f05-11e7-832e-76d8accec323.png">

#### Step 4
Navigate into the top directory of mounted codebase and compile codebase with clang using [scan-build](https://clang-analyzer.llvm.org/scan-build.html)
```bash
scan-build 
```
<img width="600" alt="screen shot 2017-04-11 at 10 36 53 pm" src="https://cloud.githubusercontent.com/assets/18354718/24940271/bddb05fc-1f07-11e7-81da-46b6797b8b4a.png">

If a bug is found, clang generates a bug summary report and further details about the bug can be reviewed by clicking on view report tab. 

This can be reviewed by running ```scan-view``` on the report directory

<img width="600" alt="screen shot 2017-04-24 at 9 54 36 am" src="https://cloud.githubusercontent.com/assets/18354718/25343371/7644acbc-28d4-11e7-9637-9d07b54944b0.png">



<img width="600" alt="screen shot 2017-04-24 at 10 10 39 am" src="https://cloud.githubusercontent.com/assets/18354718/25344444/c3fdf744-28d7-11e7-8c6c-0f493ed7909f.png">

View bug report generated


<img width="600" alt="screen shot 2017-04-24 at 10 07 21 am" src="https://cloud.githubusercontent.com/assets/18354718/25344193/ff342528-28d6-11e7-9211-813860379074.png">

Bug report summary

<img width="600" alt="screen shot 2017-04-24 at 10 07 27 am" src="https://cloud.githubusercontent.com/assets/18354718/25344544/055cb158-28d8-11e7-800b-0c658d4df7aa.png">

Detailed report view

#### Step 5

The Common Weakness and Enumeration [(CWE)](http://cwe.mitre.org/) database helps to provide a unified, measurable set of software weaknesses that enables and enhances more effective discussion, description, selection, and use of software security tools and services.
The ability to systematically map warning from various tool outputs to CWE database will enhance the reporting of weaknesses as it will serve as:
 * A common language for describing software security weaknesses in architecture, design, or code
 * A standard measuring stick for software security tools targeting these weaknesses.
 * Provide a common baseline standard for weakness identification, mitigation, and prevention efforts

#### CWE Mapping Guidelines
 * Map to a weakness only
 * Do Not Map to Views or Categories
 * Map to the lowest abstraction level possible
 
The first thing will be to have a clear description of the warning or weakness from tool output. From the example above the warning is "dereference null pointer ".

Carryout a [Full text search](https://cwe.mitre.org/find/index.html)

<img width="600" alt="screen shot 2017-04-24 at 8 02 09 pm" src="https://cloud.githubusercontent.com/assets/18354718/25364602/2a2b20cc-2929-11e7-8c2a-ae47b57145c1.png">
 
 
Select the results of the full text search, confirm if it's base or variant and if it matches the lowest abstraction level by navigating through the presentation filters at the top right as shown below.

Important things to consider when finding the best match for a tool output will be the description summary, extended description, technical impact and example code used to further explain the weaknesses.
 
<img width="600" alt="screen shot 2017-04-25 at 10 44 38 pm" src="https://cloud.githubusercontent.com/assets/18354718/25417328/ee5574ea-2a08-11e7-912d-3ae9a330e08f.png">



## Building Clang from source and registering new or modified checkers

Follow the below the Clang Getting Started [link here](https://clang.llvm.org/get_started.html) for steps to build clang from source on a unix-like system.

In this repository is a mapping of clang static analyzer's security checkers to CWE ID's [Clang-CWE Mapping](https://github.com/lanreogunmola/Static-Analysis-Lab/blob/master/Clang-checker-CWE-mapping.xlsx) and also a directory containing clang checkers with modifications to the warning descriptions to report closely related CWE ID's. 


To add these checkers during the initial build process of clang from source, follow steps 1-4 of the Clang Getting Started [link here](https://clang.llvm.org/get_started.html). Then find the analyzer source code located under the Clang source tree: 

`$ cd llvm/tools/clang`
See: include/clang/StaticAnalyzer, lib/StaticAnalyzer, test/Analysis.

Copy the checkers from this repository and overwrite the default checkers in `lib/StaticAnalyzer` and conclude the remaining steps in Clang getting started guide.


## Additional Resources

* [Clang 24hours checkers](http://llvm.org/devmtg/2012-11/Zaks-Rose-Checker24Hours.pdf)
* [Docker commands](https://docs.docker.com/engine/reference/commandline/docker/)
* [Another CWE mapping approach](https://github.com/lanreogunmola/Static-Analysis-Lab/wiki/CWE-Mapping-approach)
* [Finding bugs with Clang](http://web.cs.ucla.edu/~tianyi.zhang/tutorial.html)
* [Lightweight formal models of software weaknesses](http://ieeexplore.ieee.org/document/6612277/)
* [MODBUS Application Protocol Specification](http://www.modbus.org/docs/Modbus_Application_Protocol_V1_1b.pdf)
 

## Special Thanks

* A special thanks to Dr Robin Gandhi for his guidiance, reviews and thoughtful contributions.


## License    
Copyright (C) 2017

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
