<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Pipelines As Code <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



## Pipelines As Code



### Everything As Code
Everything as Code can be described as a methodology or practice which consists of 
extending the idea of how applications are treated as code and applying these concepts 
to all other IT components like operating systems, network configurations, and pipelines.



### Pipelines As Code
#### _What Is It?_
* Based on the practice **everything as code**
* Allows pipelines jobs and configurations to be defined as code in order to 
easily install and maintain them from a Git repository
* Couples pipeline steps to exact commit, ensuring the ability to rebuild is there



### Jenkins Pipelines as Code
* A Jenkins pipeline can be defined with code in a **Jenkinsfile**.
* Jenkins jobs and configurations could be configured as code, creating automation around common tasks (no more point and click in Jenkins)
* Jenkinfiles are written in Groovy



### Jenkins Pipelines as Code
![BP4](images/pipelines/jenkins_pipeline_template.png)



### Jenkins Pipelines as Code
![BP4](images/pipelines/jenkins_pipeline_code.png)




### Tekton Pipelines as Code
* A Tekton pipeline can be defined with code in a **yaml files**.
* Tekton tasks and resources could be configured as code
* Tekton pipelines doesn't have a specific programing language



### Tekton Pipelines as Code
![BP4](images/pipelines/tekton_pipeline_yaml.png)



<!-- .slide: id="enslaved-hope" -->
## An Enslaved Hope



### Lab Exercise 4: An Enslaved Hope
The purpose of this lab is to replace the manually created Jenkins jobs from
Lab Exercise 2 with a source-controlled Jenkinsfile to automate pipeline
creation.



### What new tools and frameworks will we use?
* **Jenkinsfile**: a Jenkins pipeline can be described in this single file
* **Jenkins Agent**: provides a flexible way to add compute nodes with
specific configurations to a Jenkins instance



### The Big Picture
![BP4](images/bp-4-enslaved-hope.jpg)



### Let's Go!!!
Lab Exercise 4: _An Enslaved Hope_



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Continuous Integration](https://openpracticelibrary.com/practice/continuous-integration/)
- [Continuous Delivery](https://openpracticelibrary.com/practice/continuous-delivery)
- [Everything as Code](https://openpracticelibrary.com/practice/everything-as-code/)
