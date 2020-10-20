# DevOps Culture & Practice

![jenkins-crio-ocp-star-wars-kubes](./images/jenkins-crio-ocp-star-wars-kubes.png)
[image-ref](https://www.cloudbees.com/blog/get-ripped-jenkins-docker-industrial-strength-continuous-delivery)

## Learner Outcomes
* Provide an immersive experience for students through practical application of DevOps culture using modern software development practices.

* Allow students to experience the cultural shift they need to make in order to begin a successful DevOps journey.

## Cluster Information

An OpenShift Cluster is required to complete the lab exercises. Students will receive by email (and by the instructors on site) the following information regarding the OpenShift cluster:
 - <**CLUSTER_URL**> -- OpenShift Webconsole/API Server URL
 - <**APPS_URL**> -- Wildcard subdomain for the exposed applications deployed in the Cluster

## Learner Pre-requisites
The following are the minimal hardware requirements for running the lab exercises in this course
* 64-bit Intel Core i5/i7 CPU or equivalent with virtualization extensions enabled
* 4GB memory
* 80GB hard disk

The lab exercises have been tested on the following operating systems
 * Fedora 30 or 31 64-bit x86_64
 * Microsoft Windows 10 Pro 64-bit
 * macOS 10.14 "Mojave"

The following table lists the software requirements for running the lab exercises:

 | Software | Version | Check |
 | -------- | ------- | ----- |
 | OCP CLI | v4.5 | $ oc version &#124; grep -i --color oc |
 | Ansible | => v2.8 | $ ansible --version &#124; grep -i --color ansible |
 | Node.js | v8.x LTS | $ node -v |
 | Git Installed | | $ git --version |
 | Google Chrome Web Browser | (>60) | click [here](chrome://version/) if Google Chrome is your default browser else copy the link `chrome://version/` in your Chome |
 | Docker latest | Community Edition | $ docker --version |
 | JDK | v1.8 | $ java -version |
 | Access to an OpenShift cluster | | `oc login -u <username> -p <password> https://api.do500.emea-1.rht-labs.com:6443` |
 | Text editor such as Atom or Visual Studio Code <br><br> (The exercises were created using `VSCode`, so the screenshots will match its layout and color schemes) | - | - |

 <p class="tip">
 <b>NOTE</b> - You will need administrator or super user level access on your system to install the prerequisite software for all the three operating systems.
 Locked down systems with restricted accounts are not supported.
 </p>

### Linux

1. Enable the nodejs 8 modules in Fedora and install the latest nodejs 8.x LTS release.
```bash
dnf module enable nodejs:8
dnf module install -y nodejs:8
```
or use the [node-version-manager](https://github.com/nvm-sh/nvm#install--update-script) to control your node versions across multiple projects.


2. Install OpenJDK version 1.8.
```bash
dnf install java-1.8.0-openjdk-devel
```

3. Install Chromium version 70 or higher.
```bash
dnf install chromium
```

4. Install Docker, Git and Ansible.
```bash
dnf install git ansible docker
systemctl enable docker
systemctl start docker
```

5. enable non-root user access to docker
```bash
groupadd docker
systemctl restart docker
usermod -aG docker $USER
```

6. Install the OpenShift 3.11 client binary.
```bash
dnf install origin-clients
```

### macOS
1. Install HomeBrew for macOS by following the installation instructions at https://brew.sh/

2. Install Node.js version 8.x LTS using the brew command, and follow the instructions to add the **node** binary to the **PATH** environment variable.
```bash
brew install node@8
```
or use the [node-version-manager](https://github.com/nvm-sh/nvm#install--update-script) to control your node versions across multiple projects.

3. Install JDK version 1.8 for MacOS by using the installer from the Oracle website at https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

4. Install Google Chrome version 70 or higher by downloading it from https://google.com/chrome

5. Install Docker for Mac by following the instructions from https://store.docker.com/editions/community/docker-ce-desktop-mac

6. Install Git using brew
```bash
brew install git
```

7. You need Ansible version 2.8 or greater to run the exercise playbooks. If you have not installed Ansible, or have an older version, install or upgrade it using brew
```bash
brew install ansible
```

8. Download and uncompress the OpenShift 3.11 client binary archive. Copy the ***oc*** binary to ***/usr/local/bin*** folder on your system
```bash
curl -L -O https://mirror.openshift.com/pub/openshift-v4/clients/oc/4.3/macosx/oc.tar.gz
tar xzvf oc.tar.gz
cp oc /usr/local/bin/
chmod +x /usr/local/bin/oc
```

### Microsoft Windows

You will be adding several directories to the ***PATH*** environment variable. Follow the instructions at https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/ to edit the ***PATH*** environment variable on Windows 10.

1. Download the Node.js 8.x LTS Windows 64-bit binary archive file from https://nodejs.org/dist/latest-v8.x/. The binary will be named as ***node-v8.x.y-win-x64.zip***, where 'x' and 'y' indicates the major and minor version of the latest Node.js 8 LTS release. 

2. Extract the zip file archive under a suitable folder in the ***C:\*** drive, for example ***C:\nodejs***. Make sure that your directory name does not have any spaces in it.

3. Add the directory where you uncompressed the zip file to the ***PATH*** environment variable, so that the ***node.exe*** and ***npm.cmd*** executable files are available in the system path.

4. Install JDK version 1.8 for Windows 64-bit by using the installer from the Oracle website at https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

Ensure that you install the JDK into a directory which has no spaces in its name, for example ***C:\Java***. Add a new environment variable called ***JAVA_HOME*** which points to the top level directory where you installed the JDK.

5. Add the ***JAVA_HOME\bin*** directory to the ***PATH*** environment variable, so that the ***java.exe*** and ***javac.exe*** executable files are available in the system path.

6. Install Google Chrome version 70 or higher by downloading it from https://google.com/chrome

7. Install Docker for Windows by following the instructions from https://hub.docker.com/editions/community/docker-ce-desktop-windows. Before downloading, you will be asked to create an account. Register and download Docker for Windows.

Ensure that you install Docker into a directory which has no spaces in its name, for example ***C:\Docker***. You will be prompted to enable Hyper-V during installation.

Windows will restart a couple of times after enabling Hyper-V and continue with the Docker installation. Follow the instructions provided in the link above to test and verify your Docker installation.

7. Download and install Git for Windows by using the 64-bit installer from https://github.com/git-for-windows/git/releases/download/v2.20.0.windows.1/Git-2.20.0-64-bit.exe.

8. Follow the instructions at https://www.atlassian.com/git/tutorials/install-git#windows to install and verify your Git installation. Ensure that you install Git into a directory which has no spaces in its name, for example ***C:\Git***.

<p class="tip">
<b>NOTE</b> - Ensure that the <i>Git Bash</i> component is selected during installation. You will need this to run bash shell scripts during the execution of lab exercises.
</p>

9. Download and install Atom text editor from https://github.com/atom/atom/releases/download/v1.33.0/AtomSetup-x64.exe, or Visual Studio Code from https://code.visualstudio.com/docs/?dv=win64

10. You will use a custom container image for running OpenShift client commands, and Ansible playbooks. You will map a directory on your local Windows system containing Ansible playbooks to a directory inside the container, and run the Ansible playbooks from within the container.

11. Execute the following commands in the ***Windows Command Prompt*** to run Ansible playbooks on Windows systems:

* Pull the container image containing the tools and utilities that are required for running Ansible playbooks:
```bash
docker pull quay.io/redhat/do500-toolbox
```
* Create a working directory under your ***C:\*** drive to store the lab exercise files and Ansible playbooks
```bash
mkdir C:\do500-workspace
```

* Launch the container and run a quick test:
```bash
docker run -it -v C:/do500-workspace:/home/tool-box/workarea:Z quay.io/redhat/do500-toolbox /bin/bash
```
<p class="tip">
<b>NOTE</b> - When you launch the container for the very first time, you will be prompted by Docker, as well as the Windows security subsystem to allow read and write access to the ***C:\do500-workspace*** directory. Allow read and write access to this directory by entering your Windows username and password when prompted.
</p>

* Once you are inside the container, you can log in to the OpenShift cluster using the OpenShift ***oc*** command-line client, and verify that Ansible is installed:
```bash
bash-4.4$ oc login -u <username> -p <password> https://api.do500.emea-1.rht-labs.com:6443
bash-4.4$ oc version
bash-4.4$ ansible --version
bash-4.4$ exit
```

Your instructor will provide the ***username*** and ***password*** information for the OpenShift cluster when you are ready to run the lab exercises.

## Git and Containers 101
 - Git tutorial covering the basics - https://try.github.io/
 - Handy guide for those new to containers - https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/

## Setup your IDE
The following plug-ins are useful for providing syntax highlighting for various lab files:
 - YAML Syntax Highlighter
 - Autosave
 - JavaScript Syntax Highlighter
 - Vue.js
 - ESlint
 - Jenkinsfile
