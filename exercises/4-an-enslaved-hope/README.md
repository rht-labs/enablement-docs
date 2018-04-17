# An Enslaved Hope

> In this exercise we'll break free from the chains of point'n'click Jenkins by introducting pipeline as code in the form of `Jenkinsfile`. Following this we will introduce some new Jenkins slaves that will be used in later labs. 

There are a number of ways pipeline as code can be achieved in Jenkins.
 * The Job DSL Plugin - this is a slightly older but very functional DSL mechanism to create reusable pipelines. Create a `groovy` file to run Jenkins Domain Specific Language to create jobs, functions and other items. In Jenkins; you then can execute this file which will build all of the config.xml files needed for each Job. 
 * The Scripted Pipelin - The scripted pipeline introduced the Jenkinsfile and the ability for developers to write their jenkins setup as groovy code. A repo with a Jenkinsfile in it's root can be pointed to by Jenkins and it will automatically build out each of the stages described within. The scriped pipeline is ultimately Groovy at it's core.
 * The Declarative Pipelin - This approach looks to simplify and opinionate what you can do and when you can do it in a pipeline. It does this by giving you top level `block` which define sections, directives and steps. The declarative syntax is not run as groovy but you can execute groovy inside script blocks. The advantage of it over scripted is validation of the config and lighter approach with requirement to understand all of the `groovy` syntax

_____

## Learning Outcomes
As a learner you will be able to
- Use a Jenkinsfile to create a declarative pipeline to build, bake and deploy the Todolist App 
- Identify the differences between scripted, declarative and DSL pipelines 
- Create Jenkins slave nodes for use in builds in future labs

## Tools and Frameworks
> Name of tool - short description and link to docs or website

1. [Pipeline](https://jenkins.io/doc/book/pipeline/) - Overview of the Jenkinsfile approach
1. [Pipeline Syntax](https://jenkins.io/doc/book/pipeline/syntax/) - Documentation for the declarative pipeline
1. [Groovy](http://groovy-lang.org/) - Groovy is a powerful, optionally typed and dynamic language, with static-typing and static compilation capabilities, for the Java platform aimed at improving developer productivity thanks to a concise, familiar and easy to learn syntax. It integrates smoothly with any Java program, and immediately delivers to your application powerful features, including scripting capabilities, Domain-Specific Language authoring, runtime and compile-time meta-programming and functional programming.

## Big Picture
This exercise begins cluster containing blah blah

_____

## 10,000 Ft View
> The goal of this exercise is to move to using the Jenkinsfile in the todolist-api and todolist-fe projects. Additionally we will create new slaves for use in the next lab

2. On Jenkins; create a multibranch pipeline project to scan the GitLab endpoint for each app. Use the Jenkinsfile provided to run the stages. Replace the `<YOUR_NAME>` with appropriate variable.

2. Create two new Jenkins slaves for the `OWASP ZAP` scanner and the `Arachni` WebCrawler

## Step by Step Instructions
> This is a fairly structured guide with references to exact filenames and sections of text to be added. 

### Part 1 - The Jenkinsfile
> _In this exercise we'll replace the Pipeline we created in Lab 2 with a Jenkinsfile approach_

2. On your terminal navigate to your `todolist-api` project and checkout the pipeline feature branch that's been already created for you.
```bash
$ git checkout feature/jenkinsfile
```

2. Open up your `todolist-api` application in your favourite editor and move to the `Jenkinsfile` in the root of the project. The highlevel structure of the file is shown collapsed below. 
![pipeline-overview](../images/exercise4/pipeline-overview.png)
Some of the key things to note:
    * `pipeline {}` is how all declarative jenkins pipelines begin.
    * `environment {}` defines environment varibales to be used across all build stages
    * `options {}` contains specific Job specs you want to run globally across the jobs eg setting the terminal colour
    * `stage {}` all jobs must have one stage. This is the logical part of the build that will be executed eg `bake-image`
    * `steps {}` each `stage` has one or more steps involved. These could be execute shell or git checkout etc.
    * `agent {}` specifies the node the build should be run on eg `jenkins-slave-npm`
    * `post {}` hook is used to specify the post-build-actions. Jenkins declarative provides very useful callbacks for `success`, `failure` and `always` which are useful for controlling the job flow
    * `when {}` is used for flow control. It can be used at stage level and be used to stop pipeline entering that stage. eg when branch is master; deploy to `test` environment.

2. The Jenkinsfile is mostly complete to do all the testing etc that was done in previous labs. Some minor changes will be needed to orchestrate namespaces. Find and replace all instances of `<YOUR_NAME>` in the Jenkinsfile and update the `GITLAB_DOMAIN` accordingly. 
```groovy
    environment {
        // GLobal Vars
        PIPELINES_NAMESPACE = "donal-ci-cd"
        APP_NAME = "todolist-api"

        JENKINS_TAG = "${JOB_NAME}.${BUILD_NUMBER}".replace("/", "-")
        JOB_NAME = "${JOB_NAME}".replace("/", "-")

        GIT_SSL_NO_VERIFY = true
        GIT_CREDENTIALS = credentials('jenkins-git-creds')
        GITLAB_DOMAIN = "gitlab-donal-ci-cd.apps.somedomain.com"
        GITLAB_PROJECT = "donal"
    }
```

2. With these changes in place, push your changes to the `feature/jenkinsfile` branch.
```bash
$ git add Jenkinsfile
$ git commit -m "ADD - namespace and git repo to pipeline"
$ git push
```

2. When the changes have been successfully pushed; Open Jenkins.

2. Create a `New Item` on Jenkins. Give it the name `todolist-api` and select `Multibranch Pipeline` from the bottom of the list as the job type.
![multibranch-select](../images/exercise4/multibranch-select.png)

2. On the job's configure page; set the Branch Sources to `git`
![multibranch-select-git](../images/exercise4/multibranch-select-git.png)

2. Fill in the Git settings with your `todolist-api` project url and setting the credentials
![multibranch-git](../images/exercise4/multibranch-git.png)

2. Set the `Scan Multibranch Pipeline Triggers` to be periodical and the internal to 1 minute. This will poll the gitlab instance for new branches or change sets to build.
![multibranch-scan-time](../images/exercise4/multibranch-scan-time.png)

2. Save the Job configuration to run the intial scan. The log will show scans for `master` and `develop` branch which have no `Jenkinsfile` so are skipped. The resulting view will show the `feature/jenkisifle` job corresponding the only branch that currently has one. The build should run automatically. 
![todolist-api-multi](../images/exercise4/todolist-api-multi.png)

2. The pipeline file is setup to only run `bake` & `deploy` stages when on `master` or `develop` branch. This is to provide us with very fast feedback for team memebers working on feature or bug fix branches. Each time someone commits or creates a new branch a basic build with testing occurs to give very rapid feedback to the team. Let's now update our branches to include the Jenkinsfile and delete the feature branch.
```bash
$ git checkout develop
$ git merge feature/jenkinsfile
$ git checkout master
$ git merge develop
$ git push -u origin --all
# this is to delete the branch from the remote
$ git push origin :feature/jenkinsfile
```

2. Back on Jenkins we should see our `todolist-api` pipelines have changed with the `develop` and `master` now appearing. The feature was deleted so this job should have gone away.
![todolist-api-multi-dev-test](../images/exercise4/todolist-api-multi-dev-test.png)

2. With the builds running for  `develop` and `master` we can explore the Blue Ocean View for Jenkins. On the Job overview page, hit the Open Blue Ocean ![open-blue-ocean](../images/exercise4/open-blue-ocean.png)
 button on the side to see what modern Jenkins looks like.
![blue-ocean-todolist-api](../images/exercise4/blue-ocean-todolist-api.png)

2.  We can move on to the `todolist-fe` job. The process is the same as before, checkout the feature branch
```bash
$ cd todolist-fe
$ git checkout feature/jenkinsfile
```

2. Open up your `todolist-fe` application in your favourite editor and move to the `Jenkinsfile` in the root of the project. Update all `<YOUR_NAME>` and `GITLAB_DOMAIN` references accordingly. 

2. Commit your changes to your feature branch as you did previously. 
```bash
$ git add Jenkinsfile
$ git commit -m "ADD - namespace and git repo to pipeline"
$ git push
```

2. This time update your master and develop branches before creating config in Jenkins
```
git checkout develop
git merge feature/jenkinsfile
git checkout master
git merge develop
git push -u origin --all
```

2. On Jenkins; create a new `Multibranch Pipeline` job called `todolist-fe`.

2. Add the `todolist-fe` git repository and set the credentials for git accordingly. 

2. Set the trigger to scan every minute as done previously. Save the configuration and we should see the collection of Jobs as shown below.
![todolist-fe-multi](../images/exercise4/todolist-fe-multi.png)

3. Run the jobs and validate the app is working as expected in the `test` environment!

### Part 2 - Security Scanning Slaves
> _This exercise focuses on updating the `enablement-ci-cd` repo with some new jenkins-slave pods for use in future exercise_

3. TODO!

_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

OpenShift Sync plugin
 - Use the `Jenkinsfile` provided to create a pipeline that runs in OpenShift's pipeline ie using it as the BuildConfig.

Jenkins S2I
 - Add the multi-branch configuration to the S2I to have Jenkins come alive with the `todolist-api` and `-fe` configuration cooked into it for future uses.

Jenkins Pipeline Extension
 - Add an extension to the pipeline that promotes code to UAT environment once the master job has been successful. 
 - Use a WAIT to allow for manual input to appove the promotion

Jenkins e2e extension (blue/green)
 - Add a step in the pipeline to only deploy to the `test` environment if the e2e tests have run successfully against which ever environemnt (blue or green) is not deployed.

## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

## Slide links
> link back to the deck for the supporting material