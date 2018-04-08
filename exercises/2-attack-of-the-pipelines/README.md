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
    * a `Build` job is responsible for compiling and packaging our code:
        1. Checkout from source code (`develop` for `<yourname>-dev` & `master` for `<yourname>-test`)
        2. Install node dependencies and run a build / package
        3. Send the package to Nexus
        4. Archive the workspace to persist the workspace in case of failure
        4. Tag the GitLab repository with the `${JOB_NAME}.${BUILD_NUMBER}` from Jenkins. This is our `${BUILD_TAG}` which will be used on downstream jobs.
        5. Trigger the `bake` job with the `${BUILD_TAG}` param
    * a `Bake` job should take the package and put it in a Linux Container
        1. Take an input of the previous jobs `${BUILD_TAG}` ie `${JOB_NAME}.${BUILD_NUMBER}`.
        2. Checkout the binary from Nexus and unzip it's contents
        3. Run an oc start-build of the App's BuildConfig and tag it's imagestream with the provided `${BUILD_TAG}`
        4. Trigger a deploy job using the parameter `${BUILD_TAG}`
    * a `deploy` job should roll out the changes by updating the image tag in the DC:
        1. Take an input of the `${BUILD_TAG}`
        2. Patch / set the DeploymentConfig to the image's `${BUILD_TAG}`
        3. Rollout the changes
        4. Verify the deployment

2. Repeat the above setup for the backend `todolist-fe`. TIP - use the copy config to speed things up!

2. Verify that both apps and the DB are talking to one another as expected.

## Step by Step Instructions
> This is a fairly structured guide with references to exact filenames and sections of text to be added.

### Part 1 - Explore the Sample App
> _In this part of the exercise we will explore the sample application, become familiar with it locally before building and deploying in OCP Land_

2. Git clone the `todolist-fe` project to somewhere sensible and checkout the `develop` branch.
```bash
$ git clone https://github.com/springdo/todolist-fe.git
$ git checkout develop
```

2. Create a new project (internal) in GitLab called `todolist-fe` to host your clone of the project and copy it's remote address. ![new-gitlab-proj](../images/exercise2/new-gitlab-proj.png)

2. In your local clone of the `todolist-fe`, remove the origin and add the GitLab origin by replacing `<YOUR_GIT_LAB_PROJECT>`. Push your app to GitLab
```bash
$ git remote remove origin
$ git remote add origin <YOUR_GIT_LAB_PROJECT>
$ git push -u origin --all
```

2. To get the app running locally; first check you've got node and npm installed
```bash
$ node -v
$ npm -v
```
<p class="tip" > 
NOTE - If you are missing these dependencies; install them with ease using the [Node Version Manager](https://github.com/creationix/nvm)
</p>
![node-version](../images/exercise2/node-version.png)

2. The `todolist-fe` has a package.json at the root of the project, this defines some configuration for the app including it's dependencies, dev dependencies, scripts and other configuration. Install the apps dependencies
```bash
$ npm install
```

2. The `todolist-fe` has some scripts defined in the package.json at the root of the project. To Run any of these scripts run `npm run <SCRIPT_NAME>`. Let's start by serving our application
 ![npm-scripts](../images/exercise2/npm-scripts.png)
```bash
npm run serve
```

2. This will take sometime to execute; but once done it should open the browser for you displaying the `todolist-fe` app.
 ![todo-list-app](../images/exercise2/todo-list-app.png)
    * The server hosting it live reloads; so as you make changes to your code; the app will live update
    * The Data you see in the screen is dummy / stubbed data. This is served up when there is no backend connection found

2. The app is a todolist manager built in Vue.js. Play around with the App. You will notice when you add todos they appear and clear as expected. If you refresh the page you'll loose all additions. This is because there is persistence

3. The structure of the `todolist-fe` is as follows.
```bash
todolist-fe
├── jest.config.js
├── jsconfig.json
├── nightwatch.config.js
├── node_modules
├── package.json
├── public
│   ├── favicon.ico
│   ├── img
│   ├── index.html
│   └── manifest.json
├── src
│   ├── App.vue
│   ├── assets
│   ├── components
│   ├── config
│   ├── main.js
│   ├── registerServiceWorker.js
│   ├── router.js
│   ├── scss
│   ├── services
│   ├── store
│   └── views
├── tests
│   ├── e2e
│   └── unit
└── vue.config.js
```
where the following are the important things:
    * `./src` is the main collection of files needed by the app. The entrypoint is the `main.js` which is used to load the root `App.vue` file.
    * `./node_modules` is where the dependencies are stored
    * `./test` contains our end-to-end tests and unit tests. More covered on these in later labs.
    * `./src/components` contains small, lightweight reusable components for our app. These include the `NewTodo` component which encapsulates the styling, logic and data for adding a new todo to our list
    * `./src/store` is the `vuex` files for managing application state and backend connectivity
    * `./src/views` is the view containers; which are responsible for loading components and managing their interactions.
    * the `./src/router.js` controls routing logic. In our case the app only has one real endpoint.
    * `./src/scss` contains custom  SCSS used in the application.
    * `./*.js` is mostly config files for running and managing the app and the tests

2. Now let's move on to the `todolist-api` and wire them together. As with the `todolist-fe` we need to clone the repo and add it to our GitLab in the cluster.
```bash
$ git clone https://github.com/springdo/todolist-api.git
$ git checkout develop
```

2. Create a new project (internal) in GitLab called `todolist-api` to host your clone of the project and copy it's remote address.

2. In your local clone of the `todolist-api`, remove the origin and add the GitLab origin by replacing `<YOUR_GIT_LAB_PROJECT>`. Push your app to GitLab
```bash
$ git remote remove origin
$ git remote add origin <YOUR_GIT_LAB_PROJECT>
$ git push -u origin --all
```

2. Once pushed; explore the application. It is a NodeJS application with the Express.js framework and MongoDB for persistent storage. Same as before, the `package.json` defines most of the configuration etc. Install the dependencies
```bash
$ npm i
```

2. While the dependencies are being installed; explore the project structure.
```bash
todolist-api
├── Dockerfile
├── Gruntfile.js
├── README.md
├── node_modules
├── package-lock.json
├── package.json
├── server
│   ├── api
│   │   └── todo
│   ├── app.js
│   ├── components
│   │   └── errors
│   ├── config
│   │   ├── environment
│   │   ├── express.js
│   │   ├── local.env.sample.js
│   │   └── seed.js
│   ├── mocks
│   │   ├── mock-routes-config.json
│   │   ├── mock-routes.js
│   │   └── mock-routes.spec.js
│   ├── routes.js
│   └── views
│       └── 404.html
└── tasks
    └── perf-test.js
```
where the following are the important things:
    * `./server` is the main collection of files needed by the app. The entrypoint is the `app.js`
    * `./node_modules` is where the dependencies are stored
    * `./server/api` is where the api's controller, data model & unit test are stored. 
    * `./server/mocks` is a mock server used for when there is no DB access    
    * `./server/config` stores our Express JS config, header information and other middlewear.
    * `./server/config/environment` stores enviromnent specific config; such as connectivity to backend services like the MongoDB.
    * `./tasks` is a collection of additional `Grunt` tasks which will be used in later labs
    * `package.json` contains the dependency list and a lot of very helpful scripts for managing the app lifecycle

2. The npm scripts are shown below. There are application start scripts, build and test items which will be used in the build. The ones for MongoDB are just provided for convenience and require Docker installed to execute.
```json
  "scripts": {
    "start": "node server/app.js",
    "dev": "./node_modules/.bin/grunt serve",
    "jshint": "./node_modules/.bin/grunt jshint",
    "jshint:ci": "./node_modules/.bin/grunt jshint:ci_server",
    "clean": "rm -rf reports package-contents*",
    "build": "mkdir -p package-contents && cp -vr server Dockerfile package.json package-contents",
    "package": "zip -r package-contents.zip package-contents",
    "test": "node_modules/.bin/nyc node_modules/.bin/mocha server/**/*.spec.js --exit",
    "test:ci": "export MOCHA_FILE='reports/server/mocha/test-results.xml' && export NODE_ENV=ci && node_modules/.bin/nyc node_modules/.bin/mocha server/**/*.spec.js -R mocha-junit-reporter --exit",
    "mongo" : "docker run -i -d --name mongo-local -p 27017:27017 mongo",
    "mongo:drop" : "npm run mongo:stop && docker rm mongo-local",
    "mongo:stop" : "docker stop mongo-local",
    "mongo:start" : "docker start mongo-local"
  },
```

2. To run the application; start a new instance of the MongoDB by running. 
```bash
$ npm run mongo
```
<p class="tip">
`npm run mongo:drop` is used to completely remove the running container. `npm run mongo:stop` & `npm run mongo:start` will preserve data in the container
</p>

2. Fire up the `todolist-api` by running.
```bash
$ npm run start
```
![node-app-started](../images/exercise2/node-app-started.png)

2. Check things are responding correctly by running and checking the response. It contains some seeded data (stored in `server/config/seed.js`)
```bash
$ curl localhost:9000/api/todos
```
```json
[{
    "_id": "5ac8ff1fdfafb02138698948",
    "title": "Learn some stuff about MongoDB",
    "completed": false,
    "__v": 0
  },
  {
    "_id": "5ac8ff1fdfafb02138698949",
    "title": "Play with NodeJS",
    "completed": true,
    "__v": 0
}]
```

2. Now let's check out `todolist-fe` app by reloading the browser. We should now see our dummy front end data is replaced by the backend seed data 
![fullstack-app](../images/exercise2/fullstack-app.png)


### Part 2 - Create a NodeJS Build slave
> _In this exercise; we will create a build configuration for to generate a slave for Jenkins to use in it's builds_

3. In order for Jenkins to be able to run `npm` builds and installs as we have done locally, we must configure a `jenkins-build-slave` for Jenkins to use. This slave will be dynamically provisioned when we run a build. It needs to have NodeJS and npm installed in it. In your `enablement-cd-cd` repository, checkout the template and configuration. This will bring in the template, the params & the `Docerfile`.
```bash
$ git checkout exercise2/jenkins-slave docker/ templates/ params/
```

3. Open the `params/jenkins-slave-npm` file and update `<YOUR_ENABLEMENT_GIT_REPO>` accordingly. This set of parameters will clone from the enablement repo and run a docker build of the Dockerfile stored in `docker/jenkins-slave-npm`.
```bash
SOURCE_REPOSITORY_URL=<YOUR_ENABLEMENT_GIT_REPO>
SOURCE_CONTEXT_DIR=docker/jenkins-slave-npm
NAME=npm-jenkins-slave
```

3. Create an item in the ansible variables file under the `ci-cd-builds` object to run the template with. Don't forget to substitute `<YOUR_NAME>`
```yaml
  - name: "jenkins-npm-slave"
    namespace: "<YOUR_NAME>-ci-cd"
    template: "{{ inventory_dir }}/../templates/jenkins-slave-generic-template.yml"
    params: "{{ inventory_dir }}/../params/jenkins-slave-npm"
    tags:
    - jenkins-slave
```
![jenkins-slave-ansible](../images/exercise2/jenkins-slave-ansible.png)

3. Run the OpenShift Applier to trigger a build of this jenkins slave image.
```bash
$ ansible-playbook roles/openshift-applier/playbooks/openshift-cluster-seed.yml \
     -i inventory/ \
     -e "filter_tags=jenkins-slave"
```

3. Verify the build executed successfully by logging into the cluster and checking the `builds` tab of the `<YOUR_NAME>-ci-cd` project.
![jenkins-slave-npm-build](../images/exercise2/jenkins-slave-npm-build.png)

3. You should now be able to apply the label `jenkins-slave-npm` to a build job to run a build on this newly created slave as we will see in the rest of this lab
<p class="tip">
NOTE - Jenkins may need to be restarted for the configuration to appear. To do this; navigate to your jenkins instance and add `/restart` to the url.
</p>

### Part 3 - Add configs to cluster 
> _In this exercise; we will use the OpenShift Applier to drive the creation of cluster content required by the app such and MongoDB and the Apps Build / Deploy Config_

4. TODO - waiting for Justins example before proceeding here

### Part 4 - Build > Bake > Deploy 
> _In this exercise; we take what we have working locally and get it working in OpenShift_

3. This exercise will involve creating three stages (or items) in our pipeline, each of these is detailed below at a very high level. Move on to the next step to begin implementation.
    * a *build* job is responsible for compiling and packaging our code:
        1. Checkout from source code (`develop` for `<yourname>-dev` & `master` for `<yourname>-test`)
        2. Install node dependencies and run a build / package
        3. Send the package to Nexus
        4. Archive the workspace to persist the workspace in case of failure
        4. Tag the GitLab repository with the `${JOB_NAME}.${BUILD_NUMBER}` from Jenkins. This is our `${BUILD_TAG}` which will be used on downstream jobs.
        5. Trigger the `bake` job with the `${BUILD_TAG}` param
    * a *bake* job should take the package and put it in a Linux Container
        1. Take an input of the previous jobs `${BUILD_TAG}` ie `${JOB_NAME}.${BUILD_NUMBER}`.
        2. Checkout the binary from Nexus and unzip it's contents
        3. Run an oc start-build of the App's BuildConfig and tag it's imagestream with the provided `${BUILD_TAG}`
        4. Trigger a deploy job using the parameter `${BUILD_TAG}`
    * a *deploy* job should roll out the changes by updating the image tag in the DC:
        1. Take an input of the `${BUILD_TAG}`
        2. Patch / set the DeploymentConfig to the image's `${BUILD_TAG}`
        3. Rollout the changes
        4. Verify the deployment
We will now to through these steps in detail.

3. With the BuildConfig and DeployConfig in place from previous steps; Log into Jenkins and create a `New Item` which is jenkins speak for a new job configuration. ![new-item](../images/exercise2/new-item.png)

3. Name this job `dev-todolist-fe-build` and select `Freestyle Job`. All our jobs will take the form of `<ENV>-<APP_NAME>-<JOB_PURPOSE>`. ![freestyle-job](../images/exercise2/freestyle-job.png)

3. The page that loads is the Job Configuration page. It can be returned to at anytime from Jenkins. To conserve space; we will make sure Jenkins only keeps the last builds artifacts. Tick the `Discard old builds` checkbox and set `Max # of builds to keep with artifacts` to 1 as below ![keep-artifacts](../images/exercise2/keep-artifacts.png)

3. Our NodeJS build needs to be run on the `jenkins-slave-npm` we created earlier. Specify this in the box labelled `Restrict where this project can be run` ![label-jenkins-slave](../images/exercise2/label-jenkins-slave.png)

3. On the Source Code Management tab, specify the endpoint for our GitLab `todolist-fe` Project and specify your credentials from the dropdown box. Set the Branch Specifier to `develop`. ![git-scm](../images/exercise2/git-scm.png)

3. Scroll down to the Build Environment tab and select the `Color ANSI Console Output` checkbox ![ansi](../images/exercise2/ansi.png)

3. Move on to the Build section and select `Add build step`. From the dropdown select `Execute Shell`. On the box tha appears; insert the following, to build package and deploy our app to Nexus:
```bash
#!/bin/bash
set -o xtrace
scl enable rh-nodejs8 'npm install'
scl enable rh-nodejs8 'npm run build:ci:dev'
scl enable rh-nodejs8 'npm run package'
scl enable rh-nodejs8 'npm run publish'
```
![build-step](../images/exercise2/build-step.png)

3. Scroll to the final section; the Post-build Actions. Add a new post-build action from the dropdown called `Archive the artifacts` and specify `**` in the box. This will zip the entire workspace and copy it back to Jenkins for inspection if needed. ![archive-artifacts](../images/exercise2/archive-artifacts.png)

3. On the Post-build Actions; Add another post-build action from the dropdown called `Git Publisher`. This is useful for tying the git check-in to the feature in your tracking tool to the built product.
    * Tick the box `Push Only If Build Succeeds`
    * Add the Tag to push of 
```bash
${JOB_NAME}.${BUILD_NUMBER}
```
    * Specify the commit message to be
```bash
Automated commit by jenkins from ${JOB_NAME}.${BUILD_NUMBER}
```
![git-publisher](../images/exercise2/git-publisher.png)

3. Finally; add the trigger for the next job in the pipeline. Add another post-build action from the dropdown called `Trigger parameterized build on other projects`. 
    * Set the project to build to be `dev-todolist-fe-bake` 
    * Set the condition to be `Stable or unstable but not failed`. 
    * Click Add Parameters dropdown and select Predefined parameters. 
    * In the box, insert our BUILD_TAG as follows
```bash
BUILD_TAG=${JOB_NAME}.${BUILD_NUMBER}
```
![param-trigger](../images/exercise2/param-trigger.png)
<p class="tip">
    NOTE - Jenkins might say "No such project ‘dev-todolist-fe-bake’. Did you mean ...." at this point. Don't worry; it's because we have not created the next job yet.
</p>

3. Hit `save` which will take you to the job overview page - and that's it; our *build* phase is complete!

3. Next we will setup our *bake* phase; which is a little simpler. Go to Jenkins home and create another Freestyle Job (as before) called `dev-todolist-fe-bake`.

3. This job is will take in the BUILD_TAG from the previous one so check the `This project is parameterized` box on the General tab.
    * Add string parameter type
    * set the name to `BUILD_TAG`. This will be available to the job as an Enviroment Variable.
    * You can set `dev-todolist-fe-build.` as the default value for ease when triggering manually.
    * The description is not required but a handy one for reference would be `${JOB_NAME}.${BUILD_NUMBER} of previous build eg dev-todolist-fe-build.1232`
![param-trigger-bake](../images/exercise2/param-trigger-bake.png)

3. This time set the `Restrict where this project can be run` label to `master`.
<p class="tip">
    This the default node that jobs run on. We don't want jenkins to execute the *bake* on any other nodes if the `master` is busy so it is always safer to specify it here.
</p>

3. There is no Git or SCM needed for this job so move down to the Build Environment and tick `Delete workspace before build starts`

3. Scroll down to the Build Environment tab and select the `Color ANSI Console Output` checkbox ![delete-ansi](../images/exercise2/delete-ansi.png)

3. Move on to the Build section and select `Add build step`. From the dropdown select `Execute Shell`. On the box the appears; insert the following, to pull the package from Nexus. We patch the BuildConfig with the Jenkins Tag to get traceablility from feature to source code to built item. Finally; the oc start-build command is run:
```bash
#!/bin/bash
curl -v -f http://admin:admin123@${NEXUS_ENDPOINT}/repository/zip/com/redhat/todolist/${BUILD_TAG}/package-contents.zip -o package-contents.zip
unzip package-contents.zip
oc project <YOUR_NAME>-ci-cd # probs not needed
NAME=todolist-fe
oc patch bc ${NAME} -p "spec:
   output:
     to:
       kind: ImageStreamTag
       name: '${NAME}:${BUILD_TAG}'"
oc start-build ${NAME} --from-dir=package-contents/ --follow
```
![bake-step](../images/exercise2/bake-step.png)

3. Finally; add the trigger for the next job in the pipeline. Add a post-build action from the dropdown called `Trigger parameterized build on other projects`.
    * Set the project to build to be `dev-todolist-fe-deploy`
    * Set the condition to be `Stable`.
    * Click Add Parameters dropdown and select Current build parameters. This will pass the ${BUILD_TAG} to the downstream job which we will create next.
    * In the box, insert our BUILD_TAG as follows
![downstream-trigger-deploy](../images/exercise2/downstream-trigger-deploy.png)

3. Hit save! That's our *bake* phase done! Finally; on to our *deploy*

3. 
_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution available and are provided for additional scope._

- Git Tasks
    * Add a GitHub Webhook to trigger your build on each commit
- Promote build
    * Create a _promote-to-uat_ phase after the <master> branch deploy
    * Create a `uat` env using the OpenShift Applier as seen before
    * Tag and promote the image without rebuilding after the `test-**-deploy`
- MongoDB tasks 
    * Add MongoDB Stateful set for the UAT environment (or test)
    * Inject MongoDB config into the NodeJS app using config map & secrets.
    * Improve the security of the DB by making the user /passwords randomly generated
- Setup Nexus as an `npm` mirror registry and use it in the builds to speed up the build time

## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

 -  What's in a package.json?

## Slide links
> link back to the deck for the supporting material