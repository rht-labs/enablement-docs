# DevOps Culture & Practice
> Red Hat Open Innovation Labs Enablement Material. Preparing Engineers, consultants and TSMs with all the cultural and engineering practices for life in a Residency.

![jenkins-crio-ocp-star-wars-kubes](./images/jenkins-crio-ocp-star-wars-kubes.png)

This is a collection of practices and exercises to take a learner through a four day simulated residency experience. Learners can expect to be exposed to labs practices such as [Event Storming](https://rht-labs.github.io/practice-library/practices/event-storming/), [Social Contract](https://rht-labs.github.io/practice-library/practices/social-contract/) and [Impact Mapping](https://rht-labs.github.io/practice-library/practices/impact-mapping/) among many more which can be found in our [Practice Library](https://rht-labs.github.io/practice-library/). Learners will also be exposed to `Labs CI/CD` - how we use OpenShift & Ansible in conjunction with Jenkins to automate build and deploy of a sample todolist application and its required infrastructure.

## Learner Outcomes
1. Prepare participants to *jointly* deliver on upcoming Labs Residencies - specifically: senior consultants, architects, and agile PMs
2. Explore all principle practices used in a residency through a hands on real life experience
3. Enable countries and regions to run the session independently

## Cluster Information

An OpenShift Cluster is required to complete the Enablement exercises. Learners will receive by email (and by the instructors onsite) the following information regarding the OpenShift Platform:
 - <CLUSTER_URL> -- Openshift Webconsole/API url
 - <APPS_URL> -- Wildcard subdomain for the exposed applications deployed in the Cluster

## Learner pre-requisites
 | Software | Version | Check |
 | -------- | ------- | ----- |
 | OCP CLI | v3.9 | $ oc version &#124; grep -i --color oc  <br><span style="color:red">oc </span> v3.9.0+191fece |
 | Ansible | v2.5 | $ ansible --version &#124; grep -i --color ansible <br> <span style="color:red">ansible</span> 2.5.5 <br> .... <br>| 
 | NodeJS | v8.x | $ node -v <br> v8.11.3|
 | Git Installed | | $ git --version <br> git version 2.17.1|
 | Google Chrome Web Browser | (>59) | click [here](chrome://version/) if Google Chrome is your default browser else copy the link `chrome://version/` in your Chome |
 | Docker latest | Community Edition - Edge | $ docker --version <br> Docker version 18.05.0-ce, build f150324|
 | JDK | v8 | $ java -version <br>java version "1.8.0_131"<br>Java(TM) SE Runtime Environment (build 1.8.0_131-b11)<br>Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)|
 | Access to an OpenShift cluster | | `oc login -u <username> -p <password> <CLUSTER_URL>` |
 | Text editor such as Atom, IntelliJ or Visual Studio Code <br><br> (The exercises were created using `VSCode`, so the screenshots will match its layout and colour schemes) | - | - |

## Git and Containers 101
 - Git tutorial covering the basics - https://try.github.io/
 - Handy guide for those new to containers - https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/

## Setup your IDE
If you are using VSCode, Atom, Eclipse, IntelliJ or some other IDE that supports Plugins; some handy ones that will make the labs easier are:
 - YAML Syntax Highlighter
 - Autosave
 - JavaScript Syntax Highlighter
 - Vue.js
 - Eslint
