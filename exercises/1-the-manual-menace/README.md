# The Manual Menace

> In this exercise learners will use Ansible to drive automated provisioning of Projects in OpenShift, Git, Jenkins and Nexus.

![automation-xkcd](https://imgs.xkcd.com/comics/automation.png)
[image-ref](https://xkcd.com/)

## Exercise Intro

In this exercise we will use automation tooling to create Project namespaces for our `CI/CD` tooling along with the `dev` and `test` namespaces for our deployments to live. We do this manually using the OpenShift CLI; but as we go from cluster to cluster or project to project Dev and Ops teams often find themselves having to redo these tasks again and again. Configuring our cluster using code; we can easily store this in Git and repeat the process again and again. By minimising the time taken to do these repetitive tasks we can accelerate our ability to deliver value to our customers; working on the hard problems they face.

This exercise uses Ansible to drive the creation of the cluster content. In particular; we'll use an implementation called the [OpenShift Applier](https://github.com/redhat-cop/openshift-applier). Once the project namespace have been created; we will add some tools to support CI/CD such as Jenkins, Git and Nexus. These tools will be needed by later lessons to automate the build and deploy of our apps. Again; we will use OpenShift Templates and drive their creation in the cluster using Ansible. To prove things are working, finally we'll delete all our content and re-apply the inventory to re-create our cluster's content.

#### Why is config-as-code important?

- Assurance - Prevents unwanted config changes from people making arbitrary changes to environments. No more Snowflake servers!
- Traceability - Committing config as code means a user has approved and changes can be tracked.
- Phoenix Server - Burn it all to the ground and bring it back; exactly the way it was!

---

## Learning Outcomes

As a learner you will be able to

1. Run the [openshift-applier](https://github.com/redhat-cop/openshift-applier) to automate creating cluster content
2. Create and admin project namespaces in OpenShift
3. Deploy commonly used applications to support the development process

## Tools and Frameworks

- [GitLab](https://about.gitlab.com/) - Community driven Git server now with integrated DevOps Toolchain.
- [Nexus](https://www.sonatype.com/nexus-repository-sonatype) - Repository manager for storing lots of application types. Can also host `npm` and `Docker` registries.
- [Jenkins](https://jenkins.io/) - OpenSource Build automation server. Highly customisable with plugins.
- [Ansible](https://www.ansible.com/) - IT Automation tool used to provision and manage state of cloud and physical infrastructure.
- [OpenShift Applier](https://github.com/redhat-cop/openshift-applier) - Used to apply OpenShift objects to an OpenShift Cluster.
- [Eclipse Che](https://www.eclipse.org/che/) - A cloud ide accessible from your browser, we use a version called [`CodeReady Workspaces`](https://developers.redhat.com/products/codeready-workspaces/overview)

## Big Picture

> The Big Picture is our emerging architecture; starting with an empty cluster we populate it with projects and some ci/cd tooling.

![big-picture](../images/big-picture/big-picture-1.jpg)

---

<!-- ## 10,000 Ft View
> This exercise is aimed at the creation of the tooling that will be used to support the rest of the Exercises. The high-level goal is to create a collection of project namespaces and populate them with Git, Jenkins & Nexus.

If you're feeling confident and don't want to follow the step-by-step guide these high-level instructions should provide a challenge for you:

1. Clone the repo `https://github.com/rht-labs/enablement-ci-cd` which contains the scaffold of the project. Ensure you get all remote branches.

2. Create `<your-name>-ci-cd`, `<your-name>-dev` and `<your-name>-test` project namespaces using the inventory and run them with the [OpenShift Applier](https://github.com/redhat-cop/openshift-applier) to populate the cluster

3. Use the templates provided to create build of the jenkins-s2i. The templates are in `exercise1/jenkins-s2i`

4. Use the templates provided to create build and deployment configs in `<your-name>-ci-cd` for. Templates are on a branch called `exercise1/git-nexus` && `exercise1/jenkins`:
    * Nexus
    * GitLab
    * Jenkins (using an s2i to pre-configure Jenkins)

5. Commit your `enablement-ci-cd` repository to your GitLab repository.

6. Burn it all down and re-apply your inventory proving config-as-code works.
-->

## Step by Step Instructions

<!-- > This is a structured guide with references to exact filenames and explanations.  -->

### Part 1 - Workspace Setup

1. By now, you should have received an email with credentials to access the environment that we will be using throughout this course. Navigate to the IdM server link included in that email, and use the provided username and password to log in. Since the password that we generated is temporary, you will be prompted to reset your password to something that only you know. The IdM server may have a box for you to enter a "one-time password" on the reset page, but you should **leave that blank**. Only your current password and new password are required. Once your password is reset and you're brought to a profile page, you can close the IdM server tab. There is nothing else that you will need to do in that system.

<p class="tip">
⚡ <b>NOTE</b> ⚡ - What you have just set is your <b>LDAP credentials</b>. Going forward, anywhere you are asked to choose to log in via <code>htpasswd</code> or LDAP, you should <b>log in with LDAP</b>.
</p>

> _Create your cloud ide environment using Che_

2. Your instructor _may_ have created your cloud IDE for you - if so, login directly to the url provided and move on to Part 2. If not, you will need to create your cloud ide environment now. Open a web and navigate to the following URL, replacing `<CODEREADY-LINK>` with the URL provided by your instructor:

```
https://<CODEREADY-LINK>/f?url=https://raw.githubusercontent.com/rht-labs/enablement-framework/main/do500-devfile.yml
```

<p class="tip">
⚡ <b>NOTE</b> ⚡ - Once you navigate to this URL to create your environment once, you must <b>not do it again</b>, or you will create a second workspace without your saved work in it. To return to your workspace after leaving it, simply navigate to the CodeReady link provided by your instructors without anything else in the URL.
</p>

3. Login using the `OpenShift/Keycloak/LDAP` button using your credentials. The first time you do this, CodeReady Workspaces will ask you to fill in some profile information before continuing.

<p class="tip">
⚡ <b>NOTE</b> ⚡ - CodeReady Workspaces does not allow special characters in usernames, including periods. If your prefilled username contains a period, like <code>firstname.lastname</code>, remove it before submitting the form. This <b>does not</b> change the username that you use to login.
</p>

![code-ready-workspaces](../images/exercise1/code-ready-workspaces.png)

4. You should see your workspace creating

![che-workspace-create](../images/exercise1/che-workspace-create.png)

5. And finally, your cloud IDE should be ready. If you do not see `EXPLORER: PROJECTS` as pictured below, click the icon that looks like two sheets of paper to open the project pane.

![che-workspace-done](../images/exercise1/che-workspace-done.png)

### Part 2 - Create OpenShift Projects

> _Using the OpenShift Applier, we will add new project namespaces to the cluster which will be used throughout the exercise._

<p class="tip">
⛷️ <b>NOTE</b> ⛷️ - If you do not plan on using the cloud ide you can clone the repository locally from here https://github.com/rht-labs/enablement-ci-cd
</p>

1. The following projects should be available in your IDE

![projects-initial](../images/exercise1/projects-initial.png)

2. Open the `enablement-ci-cd` folder in your cloud ide (or your favourite editor if using a local machine). The project is laid out as follows

```
.
├── README.md
├── apply.yml
├── docker
├── inventory
│   ├── group_vars
│   │   ├── all.yml
│   ├── host_vars
│   │   ├── ci-cd-tooling.yml
│   │   └── projects-and-policies.yml
│   └── hosts
├── jenkins-s2i
├── requirements.yml
└── templates
    └── project-requests.yml
    └── mongodb-ephemeral.yml
    └── jenkins-s2i-build-template-with-secret.yml
```

- `docker` folder contains sample Dockerfiles for our jenkins-agent images that will be used by the builds.
- `jenkins-s2i` contains the configuration and plugins we want to bring jenkins to life with
- `params` houses the variables we will load the templates with
- `templates` is a collection of OpenShift Container Platform templates
- `inventory/*.yml` is the ansible inventory used to manage the objects and content for the OpenShift cluster
- `requirements.yml` is a manifest which contains the ansible roles needed to run the playbook
- `apply.yml` is a playbook that sets up some variables and runs the OpenShift Applier role.

3. Open the `inventory/groups_vars/all.yml` file. Update the `namespace_prefix` variables by replacing the `<YOUR_NAME>` (including the `<` and `>`) with your name or initials. **Don't use uppercase or special characters**. For example; if your name is Tim Smith you would replace `<YOUR_NAME>` and set `namespace_prefix` to something like `tim` or `tsmith`.

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/groups_vars/all.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
namespace_prefix: "<YOUR_NAME>"
```

#### ** Entire File **

```yaml
---
# Please change '<YOUR_NAME>' below to be unique for your deployment
# Note:
#  - keep it lowercase
#  - do NOT use special characters
#  - make sure to replace the entire string between the double quotes - including the '<' and '>'

namespace_prefix: "<YOUR_NAME>"   # ⬅️ We care about this part!

openshift_templates_raw: "https://raw.githubusercontent.com/rht-labs/openshift-templates"
openshift_templates_raw_version_tag: "v1.4.17"
cop_quickstarts: "https://github.com/redhat-cop/containers-quickstarts.git"
cop_quickstarts_raw: "https://raw.githubusercontent.com/redhat-cop/containers-quickstarts"
cop_quickstarts_raw_version_tag: "v1.29"
```

<!-- tabs:end -->

4. Open the `inventory/host_vars/projects-and-policies.yml` file; you should see some variables setup already to create the `<YOUR_NAME>-ci-cd` namespace. This object is passed to the OpenShift Applier to call the `templates/project-requests.yml` template with the parameters composed from the inventory and the `ci_cd` vars in the `apply.yml` playbook. We will add some additional content here but first let's explore the parameters and the template

5. Inside of the `inventory/host_vars/projects-and-policies.yml` you'll see the following

<kbd><span style="color: #28b463; font-size: 12pt;">👀 enablement-ci-cd/inventory/host_vars/projects-and-policies.yml</span></kbd>

```yaml
ci_cd:
  NAMESPACE: "{{ namespace_prefix }}-ci-cd"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} CI/CD"
```

- This will define the variables that we'll soon be using to deploy our CI/CD project. It relies on the `namespace_prefix` that we updated earlier. Pulling these two sets of variables together will now allow us to pass the newly created variables to our template that will create our project appropriately. You'll notice that the name of the variable above (`ci_cd`) is then assigned to `params_from_vars` in our inventory.

<kbd><span style="color: #28b463; font-size: 12pt;">👀 enablement-ci-cd/inventory/host_vars/projects-and-policies.yml</span></kbd>

```yaml
ansible_connection: local
openshift_cluster_content:
  - object: projectrequest
    content:
      - name: "{{ ci_cd_namespace }}"
        template: "{{ playbook_dir }}/templates/project-requests.yml"
        action: create
        params_from_vars: "{{ ci_cd }}"
        tags:
          - projects
```

6. Let's add two more params dicts to pass to our template to be able to create a `dev` and `test` project. At the top of `enablement-ci-cd/inventory/host_vars/projects-and-policies.yml` create a dictionary called `dev` and `test` similar to how you see `ci_cd` defined.

- In your editor, open `enablement-ci-cd/inventory/host_vars/projects-and-policies.yml` and add the following lines before `openshift_cluster_content`:

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/projects-and-policies.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
dev:
  NAMESPACE: "{{ namespace_prefix }}-dev"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Dev"

test:
  NAMESPACE: "{{ namespace_prefix }}-test"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Test"
```

#### ** Entire File **

```yaml
---
ci_cd:
  NAMESPACE: "{{ namespace_prefix }}-ci-cd"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title}}s CI/CD"

dev:
  NAMESPACE: "{{ namespace_prefix }}-dev"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Dev"

test:
  NAMESPACE: "{{ namespace_prefix }}-test"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Test"

ansible_connection: local
openshift_cluster_content:
- object: projectrequest
  content:
  - name: "{{ ci_cd_namespace }}"
    template: "{{ playbook_dir }}/templates/project-requests.yml"
    action: create
    params_from_vars: "{{ ci_cd }}" 
    tags:
    - projects
```

<!-- tabs:end -->

7. In the `enablement-ci-cd/inventory/host_vars/projects-and-policies.yml` file, add the new objects for the projects you want to create (dev & test) by adding another object to the `content` array (previously defined) for each. You can copy and paste them from the `ci_cd_namespace` example and update them accordingly. If you do this, remember to set the names to `{{ dev_namespace }}` and `{{ test_namespace }}` and change the `params_from_vars` variable accordingly. The values for these variables used for the names (`ci_cd_namespace`, `dev_namespace` etc.) are defined in `apply.yml` file in the root of the project.

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/projects-and-policies.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
- name: "{{ dev_namespace }}"
  template: "{{ playbook_dir }}/templates/project-requests.yml"
  action: create
  params_from_vars: "{{ dev }}"
  tags:
    - projects
- name: "{{ test_namespace }}"
  template: "{{ playbook_dir }}/templates/project-requests.yml"
  action: create
  params_from_vars: "{{ test }}"
  tags:
    - projects
```

#### ** Entire File **

```yaml
---
ci_cd:
  NAMESPACE: "{{ namespace_prefix }}-ci-cd"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title}}s CI/CD"

dev:
  NAMESPACE: "{{ namespace_prefix }}-dev"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Dev"

test:
  NAMESPACE: "{{ namespace_prefix }}-test"
  NAMESPACE_DISPLAY_NAME: "{{ namespace_prefix | title }} Test"

ansible_connection: local
openshift_cluster_content:
- object: projectrequest
  content:
  - name: "{{ ci_cd_namespace }}"
    template: "{{ playbook_dir }}/templates/project-requests.yml"
    action: create
    params_from_vars: "{{ ci_cd }}" 
    tags:
    - projects
  - name: "{{ dev_namespace }}"
    template: "{{ playbook_dir }}/templates/project-requests.yml"
    action: create
    params_from_vars: "{{ dev }}"
    tags:
      - projects
  - name: "{{ test_namespace }}"
    template: "{{ playbook_dir }}/templates/project-requests.yml"
    action: create
    params_from_vars: "{{ test }}"
    tags:
      - projects
```

<!-- tabs:end -->

8. Use the `Terminal > Open Terminal in specific container` menu item to open a terminal in the `node-rhel7-ansible` container

![open-terminal](../images/exercise1/open-terminal.png)

And make sure that your default terminal is set to `zsh`:

```bash
echo "zsh" >> ~/.bashrc
```

9.  Change to the `enablement-ci-cd` directory

```bash
cd enablement-ci-cd
```

10. With the configuration in place, install the OpenShift Applier dependency

```bash
ansible-galaxy install -r requirements.yml --roles-path=roles
```

11. Apply the inventory by logging into OpenShift on the terminal. You will need to retrieve a token first, by browsing to the token request page. This is also available from the `Copy Login Command` once you have logged into the OpenShift Web UI ([more information on the FAQ page here](../faq-page/README.md)). (`<CLUSTER_URL>` should be replaced with the one you've been provided by the instructor). Accept any insecure connection warning(s) from the cli 👍.

You should see a screen like this
![api-login-token](../images/exercise1/api-login-token.png)

Copy this command and run it in your cloud ide terminal to login:

```
oc login --token=<Your Token> --server=<CLUSTER_URL>
```

12. Then run the ansible playbook as follows.

```bash
ansible-playbook apply.yml -i inventory/ -e target=bootstrap
```
where the `-e target=bootstrap` is passing an additional variable specifying that we run the `bootstrap` group of the inventory.

<p class="tip">
⛷️ <b>NOTE</b> ⛷️ - Both here and going forward, Ansible requires you to be logged in to OpenShift! Run <code>oc whoami</code> to check your login status. If it returns your username, you are logged in. If it returns some longer string with <code>serviceaccount</code> in it, you are not logged in, and you should run <i>Copy Login Command</i> again. OpenShift logs you out periodically, most likely once every 24 hours.
</p>

13. Once successful you should see an output similar to this: ![playbook-success](../images/exercise1/play-book-success.png)

14. You can check to see the projects have been created successfully by running

```bash
oc projects
```

![project-success](../images/exercise1/project-success.png)

### Part 3 - Nexus

> _Now that we have our Projects setup; we can start to populate them with Apps to be used in our dev lifecycle_

For this part, we will use an OpenShift Container Platform **template** to install and configure Nexus. This template contains all the things needed to set up a persistent Nexus server, exposing a service and route while also creating the persistent volume needed. Have a read through the template; at the bottom you'll see a collection of parameters we will pass to the template.

<p class="tip">
<b>NOTE</b> - Below how we are utilizing an OpenShift Container Platform template from a different repository by accessing it by its RAW GitHub URL (from the redhat-cop repo in this case)
</p>

1. In your cloud ide terminal add some parameters for running the template by creating a new file in the `params` directory.

```bash
touch params/nexus
```

2. The essential params to include in this file are:

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/params/nexus</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```
VOLUME_CAPACITY=5Gi
MEMORY_LIMIT=1Gi
```

#### ** Entire File **

```
VOLUME_CAPACITY=5Gi
MEMORY_LIMIT=1Gi
```

<!-- tabs: end -->

- You'll notice that this is different from how we defined our params for our projects. This is because there are multiple ways to do this. In cases like this, there may be a need to change some of these variables more frequently than others (i.e. giving the app more memory,etc.). In this case, it's easier to maintain them within their own separate params files.

3. Create a new object in the inventory variables `inventory/host_vars/ci-cd-tooling.yml` called `ci-cd-tooling` and populate its `content` as follows

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/ci-cd-tooling.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
---
ansible_connection: local
openshift_cluster_content:
  - galaxy_requirements:
      - "{{ inventory_dir }}/../exercise-requirements.yml"
  - object: ci-cd-tooling
    content:
      - name: "nexus"
        namespace: "{{ ci_cd_namespace }}"
        template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
        params: "{{ playbook_dir }}/params/nexus"
        tags:
          - nexus
```

#### ** Entire File **

```yaml
---
ansible_connection: local
openshift_cluster_content:
  - galaxy_requirements:
      - "{{ inventory_dir }}/../exercise-requirements.yml"
  - object: ci-cd-tooling
    content:
      - name: "nexus"
        namespace: "{{ ci_cd_namespace }}"
        template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
        params: "{{ playbook_dir }}/params/nexus"
        tags:
          - nexus
```

<!-- tabs: end -->

![ci-cd-deployments-yml](../images/exercise1/ci-cd-deployments-yml.png)

<p class="tip">
<b>NOTE</b> The <i>galaxy_requirements</i> above is necessary to pull in the pre/post steps dependencies as explained under the Jenkins section below.
</p>

4. Run the OpenShift applier, specifying the tag `nexus` to speed up its execution (`-e target=tools` is to run the other inventory).

```bash
ansible-playbook apply.yml -e target=tools \
     -i inventory/ \
     -e "filter_tags=nexus"
```

5. Once successful, login to the cluster through the browser (using cluster URL) and navigate to the `<YOUR_NAME>-ci-cd`. You should see Nexus up and running. You can login with default credentials (admin / admin123) ![nexus-up-and-running](../images/exercise1/nexus-up-and-running.png)

### Part 4 - Commit CI/CD

1. Navigate to GitLab login page. You can login using your cluster credentials using the LDAP tab
   ![gitlab-ui](../images/exercise1/gitlab-ui.png)

2. Once logged in create a new project called `enablement-ci-cd` and mark it as internal. Once created, copy out the `git url` for use on the next step. You can find the url by clicking on `Clone` and then copying the link under `Clone with HTTPS`.
   ![gitlab-new-project](../images/exercise1/gitlab-new-project.png)

3. Commit your local project to this new remote by first removing the existing origin (github) where the Ansible project was cloned from in the first steps. Remember to substitute `<GIT_URL>` accordingly with the one created for your `enablement-ci-cd` repository a moment ago.

```bash
git remote set-url origin <GIT_URL>
```

```bash
git add .
```

```bash
git commit -m "Adding git and nexus config"
```

```bash
git push -u origin --all
```

4. On browsing to the first project - you will need to set a local password in gitlab so you can push code.

![gitlab-new-project](../images/exercise1/gitlab-passwd-set.png)

### Part 5 - MongoDB for CI tests

> _In order to run our API tests in CI in later labs; we need there to be a MongoDB available for executing our tests. As this is part of our CI/CD Lifecycle; we will add it now._

1. Open `enablement-ci-cd` in your favourite editor. Edit the `inventory/host_vars/ci-cd-tooling.yml` to include a new object for our mongodb as shown below. This item can be added below Nexus in the `ci-cd-tooling` section.

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/ci-cd-tooling.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
- name: "jenkins-mongodb"
  namespace: "{{ ci_cd_namespace }}"
  template: "{{ playbook_dir }}/templates/mongodb-ephemeral.yml"
  params: "{{ playbook_dir }}/params/mongodb"
  tags:
    - mongodb
```

#### ** Entire File **

```yaml
---
ansible_connection: local

openshift_cluster_content:
- galaxy_requirements:
  - "{{ inventory_dir }}/../exercise-requirements.yml"
- object: ci-cd-tooling
  content:
    - name: "nexus"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
      params: "{{ playbook_dir }}/params/nexus"
      tags:
        - nexus
    - name: "jenkins-mongodb"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/mongodb-ephemeral.yml"
      params: "{{ playbook_dir }}/params/mongodb"
      tags:
        - mongodb
```

<!-- tabs: end -->

![jenkins-mongo](../images/exercise1/jenkins-mongo.png)

2. Git commit your updates to the inventory to git for traceability.

```bash
git add .
```

```bash
git commit -m "ADD - mongodb for use in the pipeline"
```

```bash
git push
```

3. Apply this change as done previously using Ansible. The deployment can be validated by going to your `<YOUR_NAME>-ci-cd` namespace and checking if it is there!

```bash
ansible-playbook apply.yml -e target=tools \
  -i inventory/ \
  -e "filter_tags=mongodb"
```

![ocp-mongo](../images/exercise3/ocp-mongo.png)

<p class="tip">
<b>NOTE</b> - When making changes to the "enablement-ci-cd" repo, you should frequently commit and push the changes to git.
</p>

### Part 6 - Jenkins & S2I

> _Create a build and deployment config for Jenkins. Add new configuration and plugins to the OpenShift default Jenkins image using s2i_

1. As before; create a new set of params by creating a `params/jenkins` file and adding some overrides to the template and updating the `<YOUR_NAME>` value accordingly.

```bash
touch params/jenkins
```

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/params/jenkins</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```
MEMORY_LIMIT=3Gi
VOLUME_CAPACITY=15Gi
JVM_ARCH=x86_64
NAMESPACE=<YOUR_NAME>-ci-cd
JENKINS_OPTS=--sessionTimeout=720
```

#### ** Entire File **

```
MEMORY_LIMIT=3Gi
VOLUME_CAPACITY=15Gi
JVM_ARCH=x86_64
NAMESPACE=<YOUR_NAME>-ci-cd
JENKINS_OPTS=--sessionTimeout=720
```

<!-- tabs:end -->

- You might be wondering why we have to replace <YOUR_NAME> here and can't just rely on the `namespace_prefix` variable that we've been using previously. This is because the replacement is handled by two different engines (one being ansible -- which knows about `namespace_prefix` and the other being the oc client, which does not). Because the params files are processed by the oc client, we need to update this here.

2. Add a `jenkins` variable to the Ansible inventory underneath the jenkins-mongo in `inventory/host_vars/ci-cd-tooling.yml` as shown below to create a DeploymentConfig for Jenkins. In order for Jenkins to be able to run `npm` commands we must configure a jenkins build agent for it to use. This agent will be dynamically provisioned when we run a build. It needs to have Node.js and npm and a C compiler installed in it.

<p class="tip">
<b>NOTE</b> These agents can take a time to build themselves so to speed up we have placed the agent with a corresponding ImageStream within OpenShift. To leverage this existing agent image, we are using a feature of the openshift-applier to process a couple of post-steps part of the inventory. These steps are utilized to perform pre and post tasks necessary to make our inventory work correctly. In this case, we use the post steps to tag and label the jenkins-agent-npm ImageStream within our CI/CD project so Jenkins knows how to find and use it.
</p>

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/ci-cd-tooling.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
- name: "jenkins"
  namespace: "{{ ci_cd_namespace }}"
  template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/jenkins/jenkins-persistent-template.yml"
  params: "{{ playbook_dir }}/params/jenkins"
  post_steps:
    - role: casl-ansible/roles/openshift-imagetag
      vars:
        source_img: "quay.io/rht-labs/enablement-npm:latest"
        img_tag: "jenkins-agent-npm:latest"
    - role: casl-ansible/roles/openshift-labels
      vars:
        label: "role=jenkins-slave"
        target_object: "imagestream"
        target_name: "jenkins-agent-npm"
  tags:
    - jenkins
```

#### ** Entire File **

```yaml
---
ansible_connection: local

openshift_cluster_content:
- galaxy_requirements:
  - "{{ inventory_dir }}/../exercise-requirements.yml"
- object: ci-cd-tooling
  content:
    - name: "nexus"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
      params: "{{ playbook_dir }}/params/nexus"
      tags:
        - nexus
    - name: "jenkins-mongodb"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/mongodb-ephemeral.yml"
      params: "{{ playbook_dir }}/params/mongodb"
      tags:
        - mongodb
    - name: "jenkins"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/jenkins/jenkins-persistent-template.yml"
      params: "{{ playbook_dir }}/params/jenkins"
      post_steps:
        - role: casl-ansible/roles/openshift-imagetag
          vars:
            source_img: "quay.io/rht-labs/enablement-npm:latest"
            img_tag: "jenkins-agent-npm:latest"
        - role: casl-ansible/roles/openshift-labels
          vars:
            label: "role=jenkins-slave"
            target_object: "imagestream"
            target_name: "jenkins-agent-npm"
      tags:
        - jenkins
```

<!-- tabs:end -->

This configuration, if applied now, will create the deployment configuration needed for Jenkins but the `${NAMESPACE}:${JENKINS_IMAGE_STREAM_TAG}` in the template won't exist yet.

3. To create this image we will take the supported OpenShift Container Platform Jenkins Image and bake in some extra configuration using an [s2i](https://github.com/openshift/source-to-image) builder image. More information on Jenkins s2i is found on the [openshift/jenkins](https://github.com/openshift/jenkins#installing-using-s2i-build) GitHub page. To create an s2i configuration for Jenkins, start with the pre-canned configuration source in the `enablement-ci-cd` repo (in the jenkins-s2i directory).

The structure of the Jenkins s2i config is

```
jenkins-s2i
├── README.md
├── configuration
│   ├── build-failure-analyzer.xml
│   ├── init.groovy
│   ├── jenkins.plugins.slack.SlackNotifier.xml
│   ├── scriptApproval.xml
└── plugins.txt
```

- `plugins.txt` is a list of `pluginId:version` for Jenkins to pre-install when starting
- `./configuration` contains content that is placed in `${JENKINS_HOME}`. A `config.xml` could be placed in here to control the bulk of Jenkins configuration.
- `build-failure-analyzer.xml` is config for the plugin to read the logs and look for key items based on a Regex. More on this in later lessons.
- `init.groovy` contains a collection of settings jenkins configures itself with when launching

4. Let's add a plugin for Jenkins to be started with, [Slack](https://plugins.jenkins.io/slack/). This plugin adds support to integrate Jenkins with Slack (we may not actually use this plugin in the lab, but we've added it as an extension task if time permits). Append the `jenkins-s2i/plugins.txt` file with

```txt
slack:2.37
```

![slack.png](../images/exercise1/slack.png)

5. Create `params/jenkins-s2i` and add the following content; replacing variables as appropriate. These parameters will be applied to the `templates/jenkins-s2i-build-template-with-secret.yml` below in step 8, which will create the imagestream and buildconfig needed for our Jenkins image. Additionally, it will also create the `git-auth` secret in Openshift that will have your username and password crendentials for GitLab. There is an annotation on the secret which binds the credential in Jenkins (`credential.sync.jenkins.openshift.io: "true"`).

```bash
touch params/jenkins-s2i
```

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/params/jenkins-s2i</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```
SOURCE_REPOSITORY_URL=<GIT_URL>
NAME=jenkins
SOURCE_REPOSITORY_CONTEXT_DIR=jenkins-s2i
SOURCE_REPOSITORY_PASSWORD=<YOUR_LDAP_PASSWORD>
SOURCE_REPOSITORY_USERNAME=<YOUR_LDAP_USERNAME>
```

#### ** Entire File **

```
SOURCE_REPOSITORY_URL=<GIT_URL>
NAME=jenkins
SOURCE_REPOSITORY_CONTEXT_DIR=jenkins-s2i
SOURCE_REPOSITORY_PASSWORD=<YOUR_LDAP_PASSWORD>
SOURCE_REPOSITORY_USERNAME=<YOUR_LDAP_USERNAME>
```

<!-- tabs:end -->

where
_ `<GIT_URL>` is the full clone path of the repo where this project is stored (including the https && .git)
_ `<YOUR_LDAP_USERNAME>` is the username builder pod will use to login and clone the repo with \* `<YOUR_LDAP_PASSWORD>` is the password the builder pod will use to authenticate and clone the repo using

6. At the top of `inventory/host_vars/ci-cd-tooling.yml` file underneath the `---`, add the following:

<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/ci-cd-tooling.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
ci_cd:
  IMAGE_STREAM_NAMESPACE: "{{ ci_cd_namespace }}"
```

#### ** Entire File **

```yaml
---
ci_cd:
  IMAGE_STREAM_NAMESPACE: "{{ ci_cd_namespace }}"

ansible_connection: local

openshift_cluster_content:
- galaxy_requirements:
  - "{{ inventory_dir }}/../exercise-requirements.yml"
- object: ci-cd-tooling
  content:
    - name: "nexus"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
      params: "{{ playbook_dir }}/params/nexus"
      tags:
        - nexus
    - name: "jenkins-mongodb"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/mongodb-ephemeral.yml"
      params: "{{ playbook_dir }}/params/mongodb"
      tags:
        - mongodb
    - name: "jenkins"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/jenkins/jenkins-persistent-template.yml"
      params: "{{ playbook_dir }}/params/jenkins"
      post_steps:
        - role: casl-ansible/roles/openshift-imagetag
          vars:
            source_img: "quay.io/rht-labs/enablement-npm:latest"
            img_tag: "jenkins-agent-npm:latest"
        - role: casl-ansible/roles/openshift-labels
          vars:
            label: "role=jenkins-slave"
            target_object: "imagestream"
            target_name: "jenkins-agent-npm"
      tags:
        - jenkins
```

<!-- tabs:end -->

7. Create a new object `ci-cd-builds` in the Ansible `inventory/host_vars/ci-cd-tooling.yml` to drive the s2i build configuration.

<p class="tip">
⚡ <b>NOTE</b> ⚡ - We are using a custom jenkins template that works with latest version of OpenShift until the changes can be merged upstream.
</p>


<kbd><span style="color: #e74c3c; font-size: 12pt;">📝 enablement-ci-cd/inventory/host_vars/ci-cd-tooling.yml</span></kbd>

<!-- tabs:start -->

#### ** Important Part **

```yaml
- object: ci-cd-builds
  content:
    - name: "jenkins-s2i"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/jenkins-s2i-build-template-with-secret.yml"
      params: "{{ playbook_dir }}/params/jenkins-s2i"
      params_from_vars: "{{ ci_cd }}"
      tags:
        - jenkins
```

#### ** Entire File **

```yaml
---
ci_cd:
  IMAGE_STREAM_NAMESPACE: "{{ ci_cd_namespace }}"

ansible_connection: local

openshift_cluster_content:
- galaxy_requirements:
  - "{{ inventory_dir }}/../exercise-requirements.yml"
- object: ci-cd-tooling
  content:
    - name: "nexus"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/nexus/nexus-deployment-template.yml"
      params: "{{ playbook_dir }}/params/nexus"
      tags:
        - nexus
    - name: "jenkins-mongodb"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/mongodb-ephemeral.yml"
      params: "{{ playbook_dir }}/params/mongodb"
      tags:
        - mongodb
    - name: "jenkins"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ openshift_templates_raw }}/{{ openshift_templates_raw_version_tag }}/jenkins/jenkins-persistent-template.yml"
      params: "{{ playbook_dir }}/params/jenkins"
      post_steps:
        - role: casl-ansible/roles/openshift-imagetag
          vars:
            source_img: "quay.io/rht-labs/enablement-npm:latest"
            img_tag: "jenkins-agent-npm:latest"
        - role: casl-ansible/roles/openshift-labels
          vars:
            label: "role=jenkins-slave"
            target_object: "imagestream"
            target_name: "jenkins-agent-npm"
      tags:
        - jenkins
- object: ci-cd-builds
  content:
    - name: "jenkins-s2i"
      namespace: "{{ ci_cd_namespace }}"
      template: "{{ playbook_dir }}/templates/jenkins-s2i-build-template-with-secret.yml"
      params: "{{ playbook_dir }}/params/jenkins-s2i"
      params_from_vars: "{{ ci_cd }}"
      tags:
        - jenkins
```

<!-- tabs:end -->

8. Commit your code to your GitLab instance

```bash
git add .
```

```bash
git commit -m "Adding Jenkins and Jenkins s2i"
```

```bash
git push
```

9. Now your code is commited; run the OpenShift Applier to add the config to the cluster

```bash
ansible-playbook apply.yml -e target=tools \
     -i inventory/ \
     -e "filter_tags=jenkins"
```

10. This will trigger a build of the s2i and when it's complete it will add an imagestream of `<YOUR_NAME>-ci-cd/jenkins:latest` to the project. The Deployment config should kick in and deploy the image once it arrives. You can follow the build of the s2i by going to the OpenShift console's project
    ![jenkins-s2i-log](../images/exercise1/jenkins-s2i-log.png)

11. When the Jenkins deployment has completed; login (using your OpenShift credentials) and accept the role permissions. You should now see a fairly empty Jenkins with just the seed job

### Part 7 - Jenkins Hello World

> _To test things are working end-to-end; create a hello world job that doesn't do much but proves we can pull code from git and that our builds are green._

1. Log in to Jenkins and hit `New Item`<br>![new-item](../images/exercise1/new-item.png).

2. Create an item called `hello-world` with type `Freestyle project` ![jenkins-new-hello-world](../images/exercise1/jenkins-new-hello-world.png).

3. Click on the `hello-world` project and then click on `configuration`.
   On the Source Code Management tab, add your `enablement-ci-cd` git repo and hit the dropdown to add your credentials we baked into the s2i on previous steps ![jenkins-scm-git](../images/exercise1/jenkins-scm-git.png)

4. On the build tab add an Execute Shell step and fill it with `echo "Hello World"` ![jenkins-hello-world](../images/exercise1/jenkins-hello-world.png).

5. Run the build and we should see it pass successfully! ![jenkins-green-balls](../images/exercise1/jenkins-green-balls.png)

### Part 8 - Live, Die, Repeat

> _In this section you will prove the infra as code is working by deleting your Cluster Content and recreating it all_

1. Commit your code to the new repo in GitLab

```bash
git add .
```

```bash
git commit -m "ADD - all ci/cd contents"
```

```bash
git push
```

2. Burn your OpenShift project resources to the ground

```bash
oc delete project <YOUR_NAME>-ci-cd <YOUR_NAME>-dev <YOUR_NAME>-test
```

3. Check to see the projects that were marked for deletion are removed.

```bash
oc get projects | egrep '<YOUR_NAME>-ci-cd|<YOUR_NAME>-dev|<YOUR_NAME>-test'
```

4. Re-apply the inventory to re-create it all!

```bash
oc login --token=<Your Token> --server=<CLUSTER_URL>
```

```bash
ansible-playbook apply.yml -i inventory/ -e target=bootstrap
```

```bash
ansible-playbook apply.yml -i inventory/ -e target=tools
```

---

## Extension Tasks

> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

- Add more secure access for Nexus (ie not admin / admin123) using the automation to drive secret creation
- Add a SonarQube persistent deployment to the `ci-cd-deployments` section.
- Add `jenkins.plugins.slack.SlackNotifier.xml` to `jenkins-s2i/configuration` to include URL of Slack for team build notifications and rebuild Jenkins S2I

---

<!-- ## Additional Reading
> List of links and other reading material that might be of use for the exercise

## Slide links

- TBD
- TBD
- TBD -->

<!-- - [Intro](https://docs.google.com/presentation/d/1LsfAkH8GfIhulEoy_yd-usWBfDHnZEyQdNvYeTmAg4A/)
- [Wrap-up](https://docs.google.com/presentation/d/1cfyJ6SHddZNbM61oz67r870rLYVKY335zGclXN2uLMY/)
- [All Material](https://drive.google.com/drive/folders/13Bt4BXf9P2OB8VI4YQNcNONF1786dqOx) -->
