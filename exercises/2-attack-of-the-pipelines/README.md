# Attack of the Pipelines

> In this lab we will explore the sample TODO List application and create a pipeline in Jenkins to build and deploy our code.

![jenkins-time](../images/exercise2/jenkins-time.jpg)

_____

## Learning Outcomes
As a learner by the end of this lesson you will be able to

- Build and run the full stack of the TODO List application locally
- Create an un-gated pipeline using the Jenkins UI for the backend and frontend
- Add branching to the pipeline to target specific namespace

## Tools and Frameworks
> The following tools are used throughout this exercise. Familiarity with them is not required but knowing what they are may help!

1. [Jenkins](https://jenkins.io/) - OpenSource build automation server; highly customisable through plugins
1. [NodeJS](https://nodejs.org/en/) - Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient. Node.js' package ecosystem, npm, is the largest ecosystem of open source libraries in the world.
1. [MongoDB](https://www.mongodb.com/what-is-mongodb) - MongoDB stores data in flexible, JSON-like documents, meaning fields can vary from document to document and data structure can be changed over time
1. [VueJS](https://vuejs.org/) - Vue (pronounced /vjuː/, like view) is a progressive framework for building user interfaces. It is designed from the ground up to be incrementally adoptable, and can easily scale between a library and a framework depending on different use cases. It consists of an approachable core library that focuses on the view layer only, and an ecosystem of supporting libraries that helps you tackle complexity in large Single-Page Applications.

## Big Picture
> From the previous exercise; we created some supporting tooling needed by our app/

_____

## 10,000 Ft View
> _This lab requires users to take the sample TODO app and create a build pipeline in Jenkins by clicking your way to success ending up with an app deployed to each of the namespaces created previously_

2. Import the projects into your gitlab instance. See README of each for build instructions

2. Deploy a `MongoDB` using the provided template to all project namespace.

2. Create 2 pipline with three stages (`build`, `bake`, `deploy`) in jenkins for `develop` & `master` branches on the `todolist-fe` such that:
    * `Build` job should:
        1. Checkout from source code (`develop` for `<yourname>-dev` & `master` for `<yourname>-test`)
        2. Install node dependencies and run a build / package
        3. Send the package to Nexus (as a zip)
        4. Tag the git repository with the `${JOB_NAME}.${BUILD_NUMBER}` from Jenkins
        5. Trigger the `bake` job
    * `Bake` job should:
        1. Take an input of the previous jobs `${BUILD_TAG}` ie `${JOB_NAME}.${BUILD_NUMBER}`.
        2. Checkout the binary from Nexus and unzip it's contents
        3. Run and OC build of the App and tag it's imagestream with the provided `${BUILD_TAG}`
        4. Trigger a deploy job using the parameter `${BUILD_TAG}`
    * `deploy` job should:
        1. Take an input of the `${BUILD_TAG}`
        2. Patch / set the DeploymentConfig to the image's `${BUILD_TAG}`
        3. Rollout the changes
        4. Verify the deployment

2. Repeat the above setup for the backend `todolist-fe`. TIP - use the copy config to speed things up!

2. Verify that both apps and the DB are talking to one another as expected.

## Step by Step Instructions
> This is a fairly structured guide with references to exact filenames and sections of text to be added. Include pictures and code snippets where appropriate. Rule of thumb is learners are dumb.... so over describe _why_ we're doing things

### Part 1 - do some things
> _prefix of exercise and why we're doing it_

2. Do thing using tool X.
2. Insert blah into `file1.txt`
```
export SOME_THING=biscuits
```
2. Open console and navigate to `New Item` and click it ![new-item](./images/new-item.png)

### Part 2 - do some other things
> _prefix of exercise and why we're doing it_

3. Do other things

_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

 - Create a _promote-to-uat_ phase after the <master> branch deploy
 - Add MongoDB Stateful set for the UAT environment (or test)
 - Do some other stuff

## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

## Slide links
> link back to the deck for the supporting material