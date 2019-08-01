# An Enslaved Hope

> In this exercise we'll break free from the chains of point'n'click Jenkins by introducing pipeline as code in the form of `Jenkinsfile`. Following this we will introduce some new Jenkins slaves that will be used in later exercises.

![jenkins-fail-meme](../images/exercise4/jenkins-fail-meme.jpeg)
[image-ref](https://memegenerator.net/instance/76565947/days-since-its-been-0-days-since-a-jenkins-fail)

There are a number of ways pipeline as code can be achieved in Jenkins.

 * The Job DSL Plugin - this is a slightly older but very functional DSL mechanism to create reusable pipelines. Create a `groovy` file to run Jenkins Domain Specific Language to create jobs, functions and other items. In Jenkins; you then can execute this file which will build all of the config.xml files needed for each Job.

 * The Scripted Pipeline - The scripted pipeline introduced the Jenkinsfile and the ability for developers to write their Jenkins setup as groovy code. A repo with a Jenkinsfile in its root can be pointed to by Jenkins and it will automatically build out each of the stages described within. The scripted pipeline is ultimately Groovy at its core.

 * The Declarative Pipeline - This approach looks to simplify and opinionate what you can do and when you can do it in a pipeline. It does this by giving you top level `block` which define sections, directives and steps. The declarative syntax is not run as groovy but you can execute groovy inside script blocks. The advantage of it over scripted is validation of the config and lighter approach with requirement to understand all of the `groovy` syntax

_____

## Learning Outcomes
As a learner you will be able to
- Use a Jenkinsfile to create a declarative pipeline to build, bake and deploy the Todolist App
- Identify the differences between scripted, declarative and DSL pipelines
- Create Jenkins slave nodes for use in builds in future exercises

## Tools and Frameworks

1. [Zed Attack Proxy](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) - The OWASP Zed Attack Proxy (ZAP) is one of the world’s most popular free security tools and is actively maintained by hundreds of international volunteers*. It can help you automatically find security vulnerabilities in your web applications while you are developing and testing your applications. Its also a great tool for experienced pentesters to use for manual security testing.
2. [Arachni Crawler](http://www.arachni-scanner.com/) - Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of modern web applications. It is free, with its source code public and available for review. It is versatile enough to cover a great deal of use cases, ranging from a simple command line scanner utility, to a global high performance grid of scanners, to a Ruby library allowing for scripted audits, to a multi-user multi-scan web collaboration platform. In addition, its simple REST API makes integration a cinch.
3. [OpenShift Pipeline](https://docs.openshift.com/container-platform/3.11/dev_guide/openshift_pipeline.html) - OpenShift Pipelines give you control over building, deploying, and promoting your applications on OpenShift. Using a combination of the Jenkins Pipeline Build Strategy, Jenkinsfiles, and the OpenShift Domain Specific Language (DSL) (provided by the OpenShift Jenkins Client Plug-in), you can create advanced build, test, deploy, and promote pipelines for any scenario.

## Big Picture
> From the previous exercise; we gated our pipeline. Now we will add a pipeline-as-code in the form of the Jenkinfile and re-use it on the Backend too.

![big-picture](../images/big-picture/big-picture-4.jpg)

_____

<!-- ## 10,000 Ft View
> The goal of this exercise is to move to using the Jenkinsfile in the todolist-api and todolist projects. Additionally we will create new slaves for use in the next exercise.

1. On Jenkins; create a multibranch pipeline project to scan the GitLab endpoint for each app. Use the Jenkinsfile provided to run the stages. Replace `<YOUR_NAME>` with the appropriate variable.

2. Create two new Jenkins slaves for the `OWASP ZAP` scanner and the `Arachni` WebCrawler -->

## Step by Step Instructions

### Part 1 - Security Scanning Slaves
> _This part of the exercise focuses on updating the `enablement-ci-cd` repo with some new jenkins-slave pods for use in future exercise_

#### 1a - OWASP ZAP
> _OWASP ZAP (Zed Attack Proxy) is a free open source security tool used for finding security vulnerabilities in web applications._

1. On your  editor; move to the `enablement-ci-cd` repo and opten the `inventory/host_vars/ci-cd-tooling.yml`.

2. Create an object in `inventory/host_vars/ci-cd-tooling.yml` called `jenkins-slave-zap` and add the following variables to tell your template where to find the slave definition

<kbd>*inventory/host_vars/ci-cd-tooling.yml*</kbd>
```yaml
  ---

  zap:
    SOURCE_REPOSITORY_URL: https://github.com/redhat-cop/containers-quickstarts.git
    SOURCE_CONTEXT_DIR: jenkins-slaves/jenkins-slave-zap
    BUILDER_IMAGE_NAME: centos:centos7
    NAME: jenkins-slave-zap
    SOURCE_REPOSITORY_REF: "{{ cop_quickstarts_raw_version_tag }}"
    DOCKERFILE_PATH: Dockerfile
    SLAVE_IMAGE_TAG: latest
```

3. Create the object for feeding the template with the parameters

<kbd>*inventory/host_vars/ci-cd-tooling.yml*</kbd>
```yaml
- object: jenkins-slave-nodes
  content:
  - name: jenkins-slave-zap
    template: "{{ cop_quickstarts_raw }}/{{ cop_quickstarts_raw_version_tag }}/jenkins-slaves/.openshift/templates/jenkins-slave-generic-template.yml"
    params_from_vars: "{{ zap }}"
    namespace: "{{ ci_cd_namespace }}"
    tags:
    - jenkins-slaves
    - zap-slave
```
![zap-object](../images/exercise4/zap-object.png)

4. Run the ansible playbook filtering with tag `zap` so only the zap build pods are run.
```bash
ansible-playbook apply.yml -e target=tools \
     -i inventory/ \
     -e "filter_tags=zap-slave"
```

5. Head to <CLUSTER_URL> on OpenShift and move to your ci-cd project > builds. You should see `jenkins-slave-zap` has been built.
![zap-build](../images/exercise4/zap-build.png)

#### 1b - Arachni Scan
> _Arachni is a feature-full, modular, high-performance Ruby framework aimed towards helping penetration testers and administrators evaluate the security of web applications._

1. Create an object in `inventory/host_vars/ci-cd-tooling.yml` called `jenkins-slave-arachni` with the following content for our Arachni slave:

<kbd>*inventory/host_vars/ci-cd-tooling.yml*</kbd>
```yaml
arachni:
  SOURCE_REPOSITORY_URL: "{{ cop_quickstarts }}"
  SOURCE_CONTEXT_DIR: jenkins-slaves/jenkins-slave-arachni
  BUILDER_IMAGE_NAME: registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7:v3.11
  NAME: jenkins-slave-arachni
  SOURCE_REPOSITORY_REF: "{{ cop_quickstarts_raw_version_tag }}"
  SLAVE_IMAGE_TAG: latest
```

2. Add the definition below underneath the Zap config

<kbd>*inventory/host_vars/ci-cd-tooling.yml*</kbd>
```yaml
  - name: jenkins-slave-arachni
    template: "{{ cop_quickstarts_raw }}/{{ cop_quickstarts_raw_version_tag }}/jenkins-slaves/.openshift/templates/jenkins-slave-generic-template.yml"
    params_from_vars: "{{ arachni }}"
    namespace: "{{ ci_cd_namespace }}"
    tags:
    - jenkins-slaves
    - arachni-slave
```
![arachni-object](../images/exercise4/arachni-object.png)

3. Run the ansible playbook filtering with tag `arachni` so only the arachni build pods are run.
```bash
ansible-playbook apply.yml -e target=tools \
     -i inventory/ \
     -e "filter_tags=arachni-slave"
```

4. With these changes in place, push your changes to the `master` branch.
```bash
git add .
```
```bash
git commit -m "ADD - Arachni and Zap scanning images"
```
```bash
git push
```

5. Your OpenShift cluster should now show both slaves have been built in your `ci-cd` namepsace
![all-slaves](../images/exercise4/all-slaves.png)


### Part 2 - OCP Pipeline
> _This exercise adds a new BuildConfig to our cluster for the todolist-apps to run their pipelines in OpenShift using the OpenShift Jenkins Sync Plugin. We will use the OpenShift Applier to create the content in the cluster_

1. For the rest of the lab, ensure that you are working from the `master` branch
```bash
cd todolist
git checkout master
```

2. Open the `todolist` app in your favourite editor. Move to the `.openshift-applier` directory. Explore the `template/ocp-pipeline`. This template creates a BuildConfig for OpenShift with a Jenkinsfile from a given repo. In this case; it will be the `Jenkinsfile` at the root of our application.

3. Open the `params/ocp-pipeline` file and update `PIPELINE_SOURCE_REPOSITORY_URL` with the git url of your project (Don't forget to add the `.git` at the end). For example:
```
PIPELINE_SOURCE_REPOSITORY_URL=https://gitlab.<APPS_URL>/<GIT_USERNAME>/todolist.git
PIPELINE_SOURCE_REPOSITORY_REF=develop
NAME=todolist
```

4. Create a new object in `inventory/group_vars/all.yml` to drive the `ocp-pipeline` template with the parameters file you've just created. It can be put under the existing `todolist-build` object.

<kbd>*inventory/group_vars/all.yml*</kbd>
```yaml
  - name: todolist-pipeline
    template: "{{ playbook_dir }}/templates/ocp-pipeline.yml"
    params: "{{ playbook_dir }}/params/ocp-pipeline"
    namespace: "{{ ci_cd_namespace }}"
    tags:
    - pipeline
```
![ocp-pipeline-applier](../images/exercise4/ocp-pipeline-applier.png)

5. Log in to OpenShift using the `oc` client, and use the OpenShift Applier to create the cluster content
```bash
oc login https://<CLUSTER_URL>
```
```bash
cd todolist/.openshift-applier
```
```bash
ansible-playbook apply.yml -i inventory/ \
     -e "filter_tags=pipeline"
```

6. With these changes in place, commit your changes to GitLab
```bash
git add .
```
```bash
git commit -m "ADD - ocp pipeline in git repo"
```
```bash
git push
```

7. Login to your OpenShift Cluster and go to the `<YOUR_NAME>-ci-cd` namespace. On the side menu; hit `Builds > Pipeline` to see your newly created pipeline running in OCP Land.
![ocp-pipeline-view](../images/exercise4/ocp-pipeline-view.png)

8. Running the pipeline from here will run it in Jenkins. You can see the job sync between OpenShift and Jenkins if you login to Jenkins. You should see a folder with `<YOUR_NAME>-ci-cd` and your pipeline jobs inside of it.
![ocp-pipeline-jenkins](../images/exercise4/ocp-pipeline-jenkins.png)

<p class="tip">
<b>NOTE</b> - If you see failures in the first pipeline run, re-run the pipeline again and it should succeed.
</p>
_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

Jenkins S2I
 - Add the multi-branch configuration to the S2I to have Jenkins come alive with the `todolist-api` and `` configuration cooked into it for future uses.

Jenkins Pipeline Extension
 - Add an extension to the pipeline that promotes code to the UAT environment once the master job has been successful.
 - Use a WAIT to allow for manual input to approve the promotion

Jenkins e2e extension (blue/green)
 - Add a step in the pipeline to only deploy to the `test` environment if the e2e tests have run successfully against which ever environment (blue or green) is not deployed.

<!-- ## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

## Slide Links

- [Intro](https://docs.google.com/presentation/d/1B3Fv4g66zZ8ZkqBq9TYmImJhUDvMecXCt4q3DXGWhjc/)
- [Wrap-up](https://docs.google.com/presentation/d/1EOk6y798Xh1hsaQlxRuqyr23FIIf7sNY4any_yXIL7A/)
- [All Material](https://drive.google.com/drive/folders/1oCjpl33Db7aPocmpu3NNF0B9czRvFq3m) -->

