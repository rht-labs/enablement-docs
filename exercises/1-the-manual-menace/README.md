# The Manual Menace

> In this lab learners will use Ansible to drive automated provisioning of Projects, Access Control, Git, Jenkins and Nexus

_____

## Learning Outcomes
As a learner you will be able to

1. Run the OpenShift Applier to automate creating cluster content
1. Create and admin project namespaces in OpenShift
1. Deploy commonly used applications to support the development process

## Tools and Frameworks

* [GitLab](https://about.gitlab.com/) - Community driven Git server now with integrated DevOps Toolchain.
* [Nexus](https://www.sonatype.com/nexus-repository-sonatype) - Repository manager for storing lots of application types. Can also host `npm` and `Docker` registries.
* [Jenkins](https://jenkins.io/) - OpenSource Build automation server. Highly customisable with plugins.
* [Ansible](https://www.ansible.com/) - IT Automation tool used to provision and manage state of cloud and physical infrastructure.
* [OpenShift Applier](https://github.com/redhat-cop/openshift-applier) - Community driven Git server

## Big Picture
This exercise begins with an empty Cluster
> TODO - add big picture here...

_____

## 10,000 Ft View
> This lab is aimed at the creation of the tooling that will be used to support the rest of the Exercises. The highlevel goal is to create a collection of project namespaces and populate them with Git, Jenkins & Nexus.

If you're feeling confident and don't want to follow the step-by-step guide these highlevel instructions should provide a challenge for you:

2. Clone the repo `git@github.com:rht-labs/enablement-ci-cd.git` which contains the scaffold of the project.

2. Create `<your-name>-ci-cd`, `<your-name>-dev` and `<your-name>-test` project namespaces using the inventory and run them with the OpenShift Applier to populate the cluster

2. Use the templates provided to create build and deployment configs in `<your-name>-ci-cd` for. Templates are on a branch called `exercise1/git-nexus` && `exercise1/jenkins`:
    * Nexus
    * GitLab
    * Jenkins (using an s2i to pre-configure jenkins)

2. Commit your `enablement-ci-cd` repository to the GitLab Instance you've created

2. Burn it all down and re-apply your inventory proving config-as-code works. 

## Step by Step Instructions
> This is a structured guide with references to exact filenames and explanations.

### Part 1 - Create OpenShift Projects
> _Using the OpenShift Applier, we will add new project namespaces to the cluster which will be used throughout the exercise._

3. Clone the scaffold project to your local machine and open it in your favourite editor.
```bash
git clone git@github.com:rht-labs/enablement-ci-cd.git
```

3. The project is laid out as follows
```
.
├── README.md
├── docker
│   └── jenkins-slave-node
├── inventory
│   ├── group_vars
│   │   └── all.yml
│   └── hosts
├── jenkins-s2i
│   ├── configuration
├── params
│   └── project-requests-ci-cd
├── requirements.yml
└── templates
        └── project-requests.yml
```
 * `docker` folder contains our jenkins-slave images that will be used by the builds.
 * `jenkins-s2i` contains the configuration and plugins we want to bring jenkins to life with
 * `params` houses the variables we will load the templates with
 * `templates` is a collection of OpenShift templates
 * `inventory/group_vars/all.yml` is the collection of objects we want to insert into the cluster.
 * `requirements.yml` is a manifest which contains the ansible modules needed to run the playbook
Open the `inventory/group_vars/all.yml` file; you should see a some variables setup to create the `ci-cd` namespace. This calls the `templates/project-requests.yml` template with the `params/project-requests-ci-cd` parameters. We will add some additional content here but first let's explore the parameters and the template

3. Open the `params/project-requests-ci-cd` and replace the `<YOUR_NAME or initials>` with your name to create the correstponding projects in the cluster. 
![new-item](../images/exercise1/ci-cd-project-namespace.png)

3. Create another two params files for `params/project-requests-dev` & `params/project-requests-test` and add the `NAMESPACE=<YOUR_NAME>-dev` && `NAMESPACE=<YOUR_NAME>-test` and update their Display names.

3. In the `inventory/group_vars/all.yml` file; add the new inventory items for the projects you want to create (dev & test) by adding another object to the content array. You can copy and paste them from the `ci-cd` example and update them accordingly eg
```yaml
    - name: <YOUR_NAME>-dev
      template: "{{ inventory_dir }}/../templates/project-requests.yml"
      template_action: create
      params: "{{ inventory_dir }}/../params/project-requests-dev"
      tags:
      - projects
    - name: <YOUR_NAME>-test
      template: "{{ inventory_dir }}/../templates/project-requests.yml"
      template_action: create
      params: "{{ inventory_dir }}/../params/project-requests-test"
      tags:
      - projects
```
![project-request-yaml](../images/exercise1/project-request-yml.png)

3. With the configuration in place; install the OpenShift Applier dependency
```bash
$ ansible-galaxy install -r requirements.yml --roles-path=roles
```

3. Apply the inventory by logging into OpenShift and then running 
```bash
$ oc login -p <password> -u <user> <cluster_url>
$ ansible-playbook roles/openshift-applier/playbooks/openshift-cluster-seed.yml -i inventory/
``` 

3. Once successful you should see an output similar to this ![playbook-success](../images/exercise1/play-book-success.png)

### Part 2 - Nexus and GitLab
> _Now that we have our Projects setup; we can start to populate them with Apps to be used in our dev lifecycle_

4. In the `enablement-ci-cd` repo, checkout the templates for Nexus by running
```bash
$ git checkout exercise1/git-nexus templates/nexus.yml
```
The tempate contains all the things needed to setup a persistent nexus server, exposing a service and route while also creating the persistent volume needed. Have a read through the template; at the bottom you'll see a collection of parameters we will pass to the template.

4. Add some parameters for running the template by creating a new file in the `params` directory. 
```bash
$ touch params/nexus
```

4. The essential params to inclue in this file are: `params` directory. 
```bash
VOLUME_CAPACITY=5Gi
MEMORY_LIMIT=2Gi
```

4. Create a new object in the inventory variables called `ci-cd-deployments` and populate it's `content` is as follows remembering to swap `<YOUR_NAME>-ci-cd` for the namespace you created previously
```yaml
  - object: ci-cd-deployments
    content:
    - name: "nexus"
      namespace: "<YOUR_NAME>-ci-cd"
      template: "{{ inventory_dir }}/../templates/nexus.yml"
      params: "{{ inventory_dir }}/../params/nexus"
      tags:
      - nexus
```
![ci-cd-deployments-yml](../images/exercise1/ci-cd-deployments-yml.png)

4. Run the OpenShift applier, specifying the tag `nexus` to speed up it's execution.
```bash
$ ansible-playbook roles/openshift-applier/playbooks/openshift-cluster-seed.yml \
     -i inventory/ \
     -e "filter_tags=nexus"
```

4. Once successful; login to the cluster and navigate to the `<YOUR_NAME>-ci-cd`. You should see Nexus up and running. You can login with default credentials (admin / admin123) ![nexus-up-and-running](../images/exercise1/nexus-up-and-running.png)

4. Now lets do the same thing for GitLab to get it up and running. Checkout the template provided by running
```bash
$ git checkout exercise1/gitlab-nexus templates/gitlab.yml
``` 
Explore the template; it contains the PVC, buildConfig and services. The DeploymentConfig is made up of these apps
 - Redis (3.2.3)
 - PostgreSQL (9.4)
 - GitLab CE (v10.2.3)

4. Add a new params file in the `params` folder called `gitlab`
```bash
$ touch params/gitlab
```

4. Open the `params/gitlab` file and add the following params
```
LDAP_BIND_DN=uid=<BIND_USER>,ou=People,dc=<YOUR_DOMAIN>,dc=com
LDAP_USER_FILTER=(memberof=CN=YourGroup,OU=Users,DC=<YOUR_DOMAIN>,DC=com)
LDAP_PASSWORD=<BIND_USER_PASSWORD>
LDAP_HOST=<LDAP_HOST>
LDAP_BASE=ou=People,dc=<YOUR_DOMAIN>,dc=com
LDAP_LABEL="<LDAP_DESCRIPTION>"
GITLAB_ROOT_PASSWORD=<GITLAB_ROOT_USER_PASSWORD>
GITLAB_DATA_VOL_SIZE=2Gi
POSTGRESQL_VOL_SIZE=1Gi
APPLICATION_HOSTNAME=<GITLAB_URL>
NAMESPACE=<YOUR_NAME>-ci-cd
```
where the following need to be replaced by actual values:
    * `<BIND_USER>` is the user used to query the LDAP
    * `<BIND_USER_PASSWORD>` is the password used when querying the LDAP
    * `<YOUR_DOMAIN>` is the domain the LDAP is hosted on
    * `<LDAP_HOST>` is fqdn of the LDAP server
    * `<LDAP_DESCRIPTION>` is the description to be used on the sign-in header for GitLab eg "Name LDAP Login"
    * `<GITLAB_ROOT_USER_PASSWORD>` is the root user for GOD access on the GitLab instance eg password123
    * `<GITLAB_URL>` is the endpoint for gitlab. It will take the form `gitlab-<YOUR_NAME>-ci-cd.apps.<ENV_ID>.<YOUR_DOMAIN>.com`
<p class="tip">
Note - some of the values here for the LDAP will be provided by your tutor.
</p>

4. Create another object in the inventory `all_vars.yml` file to run the build & deploy of this template. Add the following and update the `namespace:` accordingly
```yaml
    - name: "gitlab"
      namespace: "<YOUR_NAME>-ci-cd"
      template: "{{ inventory_dir }}/../templates/gitlab.yml"
      params: "{{ inventory_dir }}/../params/gitlab"
      tags:
      - gitlab
```

4. Run the OpenShift applier, specifying the tag `gitlab` to speed up it's execution.
```bash
$ ansible-playbook roles/openshift-applier/playbooks/openshift-cluster-seed.yml \
     -i inventory/ \
     -e "filter_tags=gitlab"
```

4. Once successful; login to the cluster and navigate to the `<YOUR_NAME>-ci-cd`. You should see GitLab up and running. ![gitlab-up-and-running](../images/exercise1/gitlab-up-and-running.png)

4. Navigate to gitlab. You can login with using your cluster credentials using the LDAP tab displaying your `<LDAP_DESCRIPTION>` from previous steps

![gitlab-ui](../images/exercise1/gitlab-ui.png)

4. Once logged in create a new project called `enablement-ci-cd` and mark it as internal. Once created; copy out the `git remote add origin ...` instructions for use on the next step.
![gitlab-new-project](../images/exercise1/gitlab-new-project.png)
<p class="tip">
Note - we would not normally make the project under your name but create an group and add the project there on residency but for simplicity of the exercise we'll do that here
</p>

4. Commit your local project to this new origin by first removing the existing origin (github) where the the project was cloned from. Remember to substitute `<YOUR_NEW_GIT_PROJECT>` accordingly
```bash
$ git remote remove origin
$ git remote add origin <YOUR_NEW_GIT_PROJECT>
$ git add . 
$ git commit -m "Adding git and nexus config"
$ git push -u origin --all
```

### Part 3 - Jenkins & s2i
> _Create a build and deployment config for Jenkins. Add new configuration and plugins to the OCP Stock Jenkins using s2i_

5. Add the Jenkins Build & Deployment configs to the `enablement-ci-cd` repo by merging the contents `exercise1/jenkins` in
```bash
$ git checkout exercise1/jenkins templates/jenkins.yml
```

5. Add the Jenkins Build & Deployment configs to the `enablement-ci-cd` repo by merging the contents `exercise1/jenkins` in
```bash
$ git checkout exercise1/jenkins templates/jenkins.yml
```
The Jenkins template is essentially the standard persistent jenkins one with OpenShift.

5. As before; create a new set of params by creating a `params/jenkins` file and adding some overrides to the template and updating the `NAMESPACE` value.
```bash
MEMORY_LIMIT=8Gi
VOLUME_CAPACITY=5Gi
JVM_ARCH=x86_64
NAMESPACE=<YOUR_NAME>-ci-cd
JENKINS_OPTS=--sessionTimeout=720
```
5. Add a `jenkins` variable to the ansible inventory underneath the git and nexus ones. Remember to replace `<YOUR_NAME>` with the appropriate value.
```yaml
    - name: "jenkins"
      namespace: "<YOUR_NAME>-ci-cd"
      template: "{{ inventory_dir }}/../templates/jenkins.yml"
      params: "{{ inventory_dir }}/../params/jenkins"
      tags:
      - jenkins
```
This configuration if applied now; it will create the deployment configuration needed for Jenkins but the `${NAMESPACE}:${JENKINS_IMAGE_STREAM_TAG}` in the template won't exist yet.

5. To create this image we will take the supported OpenShift Jenkins Image and bake into it some extra configuration using an [s2i](https://github.com/openshift/source-to-image) builder image. More information on Jenkins s2i is found on the [openshift/jenkins](https://github.com/openshift/jenkins#installing-using-s2i-build) github page. To create an s2i configuration for jenkins, check out the pre-canned configuration source in the `enablement-ci-cd` repo
```bash
$ git checkout exercise1/jenkins-s2i jenkins-s2i
```
The structure of the jenkins s2i config is 
```
jenkins-s2i
├── README.md
├── configuration
│   ├── build-failure-analyzer.xml
│   ├── init.groovy
│   ├── jenkins.plugins.slack.SlackNotifier.xml
│   └── jobs
│       └── seed-multibranch-job
│           └── config.xml
└── plugins.txt
```
 * `plugins.txt` is a list of `pluginId:version` for Jenkins to pre-install when starting
 * `./configuration` contains content that is placed in `${JENKINS_HOME}`. A `config.xml` could be placed in here to control the bulk of Jenkins configuration.
 * `./configuration/jobs/*` contains job names and xml config that jenkins loads when starting. The seed job in there we will return to in later lessons.
 * `build-failure-analyzer.xml` is config for the plugin to read the logs and look for key items based on a Regex. More on this in later lessons.
 * `init.groovy` contains a collection of settings jenkins configures itself with when launching

5. Let's add a plugin for Jenkins to be started with, [green-balls](https://plugins.jenkins.io/greenballs). This simply changes the default `SUCCESS` status of Jenkins from Blue to Green. Append the `plugins.txt` file with 
```txt
greenballs:1.15
``` 
![green-balls.png](../images/exercise1/green-balls.png)
Why does Jenkins have Blue Balls? More can be found [on reddit](https://www.reddit.com/r/programming/comments/4lu6q8/why_does_jenkins_have_blue_balls/) or the [jenkins blog](https://jenkins.io/blog/2012/03/13/why-does-jenkins-have-blue-balls/)

5. Before building and deploying Jenkins; add git credentials to the s2i by either adding them to the `template/jenkins.yml` and `params/jenkins` or for simplicity just replace the `<USERNAME>` && `<PASSWORD>` with your ldap credentials.
<p class="tip">
Note in a residency we would not use your GitCredentials for pushing and pulling from Git, A service user would be created for this.
</p>
```groovy
gitUsername = System.getenv("GIT_USERNAME") ?: "<USERNAME>"
gitPassword = System.getenv("GIT_PASSWORD") ?: "<PASSWORD>"
```

5. Add a new params file in the `params` folder called `jenkins-s2i`
```bash
$ touch params/jenkins-s2i
```

5. Open the `params/jenkins-s2i` file and add the following content; replacing variables as appropriate. 
```
SOURCE_REPOSITORY_URL=<YOUR_ENABLEMENT_REPO>
NAME=jenkins
SOURCE_REPOSITORY_CONTEXT_DIR=jenkins-s2i
IMAGE_STREAM_NAMESPACE=<YOUR_NAME>-ci-cd
SOURCE_REPOSITORY_USERNAME=<YOUR_LDAP_USERNAME>
SOURCE_REPOSITORY_PASSWORD=<YOUR_LDAP_PASSWORD>
```
where 
    * `<YOUR_ENABLEMENT_REPO>` is the full path clone path of the repo where this project is stored (including the https && .git)
    * `<YOUR_NAME>` is the prefix for your `-ci-cd` project.
    * Explore some of the other parameters in `templates/jenkins-s2i.yml`
    * `<YOUR_LDAP_USERNAME>` is the base64encoded username builder pod will use to login and clone the repo with
    * `<YOUR_LDAP_PASSWORD>` is the base64encoded password the builder pod will use to authenticate and clone the repo using
You can use `echo -n '<YOUR_LDAP_PASSWORD>' | openssl base64` to encode your username and password accordingly.
<p class="tip">
Note in a residency we would not use your GitCredentials for pushing and pulling from Git, A service user would be created for this.
</p>

5. Create a new object `ci-cd-builds` in the ansible `all.yml` to drive the s2i build configuration.
```yaml
  - object: ci-cd-builds
    content:
    - name: "jenkins-s2i"
      namespace: "<YOUR_NAME>-ci-cd"
      template: "{{ inventory_dir }}/../templates/jenkins-s2i.yml"
      params: "{{ inventory_dir }}/../params/jenkins-s2i"
      tags:
      - jenkins
```

5. Commit your code to your GitLab instance
```bash
$ git add .
$ git commit -m "Adding Jenkins and Jenkins s2i"
$ git push
```

5. When your code is commited; run the OpenShift Applier to add the config to the cluster
```bash
$ ansible-playbook roles/openshift-applier/playbooks/openshift-cluster-seed.yml \
     -i inventory/ \
     -e "filter_tags=jenkins"
```

5. This will trigger a build of the s2i and when it's complete it will add an imagestream of `<YOUR_NAME>-ci-cd/jenkins:latest` to the project. The Deployment config should kick in and deploy the image once it arrives. You can follow the build of the s2i by going to the OpenShift console's project
![jenkins-s2i-log](../images/exercise1/jenkins-s2i-log.png)

5. When the Jenkins deployment has completed; login (using your openshift credentials) and accept the role permissions. You should now see a fairly empty Jenkins with just the seed job

### Part 4 - Jenkins Hello World 
> _To test things are working end-to-end; create a hello world job that doesn't do much but proves we can pull code from git and that our balls are green._

6. Log in to Jenkins and hit `New Item` ![new-item](../images/exercise1/new-item.png).

6. Create a freesyle job called `hello-world` ![jenkins-new-hello-world](../images/exercise1/jenkins-new-hello-world.png).

6. On the Source Code Management tab; add your `enablement-ci-cd` git repo and hit the dropdown to add your credentials we baked into the s2i on previous steps`` ![jenkins-scm-git](../images/exercise1/jenkins-scm-git.png).

6. On the build tab add an Execute Shell step and fill it with `echo "Hello World"` ![jenkins-hello-world](../images/exercise1/jenkins-hello-world.png).

6. Run the build and we should see if pass succesfully and with Green Balls! ![jenkins-green-balls](../images/exercise1/jenkins-green-balls.png)

### Part 5 - Live, Die, Repeat
> _TOOD - improve & flesh out this section ...._

7. Commit your code to the new repo in GitLab

7. Burn your OCP content to the ground

7. Re-apply the inventory!

_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

 - Add more secure access for Nexus (ie not admin / admin123) using the automation to drive secret creation
 - Add a SonarQube persistent deployment to the `ci-cd-deployments` section.
 - Add `jenkins.plugins.slack.SlackNotifier.xml` to `jenkins-s2i/configuration` to include URL of Slack for team build notifications and rebuild Jenkins S2I

_____

## Additional Reading
 > List of links or other reading that might be of use / reference for the exercise
