<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Configuration as code <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!--.slide: id="config-as-code" -->
## Configuration As Code



### Traditional Software Configuration
1. Manually install the operating system.
2. Manually install the software packages needed.
3. Modify the software configuration files by hand.
4. ...



### Configuration As Code
1. Select automated tools for provisioning and configuration.
   * Ansible, Chef, Puppet, etc.
   * OpenStack, AWS CLI, Terraform, etc.
2. Write installation and configuration sequences as code.
3. Design configuration options as templates.
4. Check source configuration code into a source control repository.
5. Use the automated tools to apply your configs.



### Configuration As Code
#### _Benefits_
* Central authority for configuration
* Available through source control
  * Traceability
  * History and Diffs
* Configuration drift detection and correction
  * Prevents unwanted config changes
  * No more Snowflake servers
* Phoenix Server: burn it all to the ground and bring it back exactly the
way it was!



### Everything As Code
The practice of **Everything as Code** goes even further than configuration as code. All
manual steps should be scripted, automated, and checked into a source control
management system.



<!--.slide: id="manual-menace" -->
## The Manual Menace



### Lab Exercise 1: The Manual Menace
* This exercise is all about automation and **configuration-as-code**.
* This exercise is aimed at the creation of the supporting tooling that will be
used to support the rest of the exercises using code.
* The high level goal is to create a collection of project namespaces and
populate them with Git, Jenkins, and Nexus using code.
* As a learner, you will be able to:
  1. Run the [openshift-applier](https://github.com/redhat-cop/openshift-applier/)
  to automate creating cluster content.
  2. Create and administer project namespaces in OpenShift.
  3. Deploy commonly used applications to support the development process.



![AnsibleEngine](images/PairAndMob/ansible.png)



![OpenShift](images/PairAndMob/openshift.png)



### What new Tools and Frameworks will we use?
* **OpenShift Container Platform**: Red Hat's cloud application deployment and
hosting platform
* **GitLab**: Community-driven Git server now with integrated DevOps toolchain
* **Nexus**: Repository manager for storing lots of application types
  * Can host npm and container registries
* **Jenkins**: Open source build automation server that is highly customizable with plugins
* **Ansible**: Red Hat's IT automation tool used to provision and manage the
state of cloud and physical infrastructure
* **openshift-applier**: A set of Ansible playbooks/roles to apply OpenShift
objects to an OpenShift cluster



## The Big Picture
![BP1](images/bp-1-manual-menace.jpg)



## Verify Your Lab Environment



### Let's Go!!!
Lab Exercise 1: _The Manual Menace_



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Everything As Code](https://openpracticelibrary.com/practice/everything-as-code/)
