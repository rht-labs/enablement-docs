# Revenge Of The Automated Testing

> The purpose of this exercise is to develop and validate a new feature using Test Driven Development (TDD); and to promote the assured feature through the pipeline.

![comic-header](../images/exercise3/comic-header.png)

[image-ref](https://cdn-images-1.medium.com/max/1600/1*wF_fSCH-gLYfMbkwb3gR2w.png)

## Introduction to TDD.

**Test Driven Development (TDD)** is a software development process that relies on the repetition of a very short development cycle. Requirements are turned into test cases, where the software is developed to pass the tests. In other words, it creates a safety net that serves to keep the developer's problems/bugs at bay while enabling the developer to refactor efficiently. This is opposed to software development that allows software to be added that is not proven to meet requirements.

The TDD cycle can be illustrated with the following diagram:

![TDD-diagram](../images/exercise3/TDD_Lifecycle.png)

### The TDD Cycle

1. `Write a test` -
In TDD a new feature begins by writing a test. Write a test that clearly defines a function or one that provides an improvement to an existing function. It's important the developer clearly understands the feature's specification and requirements, or the feature could be wrong from the get-go.

2. `Test Fails` -
When a test is first implemented it is expected to fail. This failure validates the test is working correctly as the feature is yet to be implemented.

3. `Write code to make test pass` -
This step involves implementing the feature to pass the failed test. Code written at this stage may be inelegant and still pass the test, however this is acceptable as TDD is a recursive cycle which includes code refactoring.

4. `Code Passes tests` -
If all tests pass, the developer can be confident that the new code meets the test requirements.

5. `Refactor` -
The refactoring step will allow the developer to clean up their code without changing its behaviour. Not changing the behaviour should ensure the tests still pass. The process of refactoring can include; removal of duplication, renaming of object, class, module, variable and method names to clearly represent their current purpose and use, decoupling of functionality and increasing code cohesion.

6. `Repeat` -
Starting with another new test, the cycle is then repeated to push forward the functionality. The size of the steps should always be small, with as few as 1 to 10 edits between each test run. If new code does not rapidly satisfy a new test, or other tests fail unexpectedly, the programmer should undo or revert in preference to excessive debugging.

### Testing Bananalogy
Explanation of Mocha and JS test syntax through Bananalogy! Imagine for a moment; we're not building software but creating a bowl of fruit. To create a `Bunch of Bananas` component for our fruit bowl we could start with our tests as shown below.

![bdd-bananas](../images/exercise3/bdd-bananas.png)

  * `describe` is used to group tests together. The string `"a bunch of ripe bananas"` is for human reading and allows you to identify tests.
  * `it` is a statement that contains a test. It should contain an assertion such as `expect` or `should`. It follows the syntax of `describe` where the string passed in identifies the statement.

---

## Learning Outcomes

As a learner you will be able to

* Understand the why behind TDD
* Implement a feature using TDD for front end and backend
* Write end to end tests for the feature and run them in CI

## Tools and Frameworks

1.  [Jest](https://facebook.github.io/jest/) - Zero configuration testing platform
Jest is used by Facebook to test all JavaScript code including React applications. One of Jest's philosophies is to provide an integrated "zero-configuration" experience. We observed that when engineers are provided with ready-to-use tools, they end up writing more tests, which in turn results in more stable and healthy code bases.
1.  [Vue Test Utils](https://vue-test-utils.vuejs.org/en/) - Vue Test Utils is the official unit testing utility library for Vue.js.
1.  [Nightwatch.js](http://nightwatchjs.org/) - Nightwatch.js is an easy to use Node.js based End-to-End (E2E) testing solution for browser based apps and websites. It uses the powerful W3C WebDriver API to perform commands and assertions on DOM elements.
1.  [Mocha](https://mochajs.org/) - Mocha is a feature-rich JavaScript test framework running on Node.js and in the browser, making asynchronous testing simple and fun. Mocha tests run serially, allowing for flexible and accurate reporting, while mapping uncaught exceptions to the correct test cases. Hosted on GitHub.
1.  [Sinon](http://sinonjs.org/) - Standalone test spies, stubs and mocks for JavaScript.
Works with any unit testing framework.

## Big Picture
> From the previous exercise; we created a simple pipeline. We will now flesh it out with some testing to add gates to our pathway to production.

![big-picture](../images/big-picture/big-picture-3.jpg)

---

<!-- ## 10,000 Ft View

> The goal of this exercise is to add a new component to the application using TDD to create and validate its behaviour. The User story we have been given is as follows:

*As a doer I want to mark todos as important so that I can keep track of and complete high priority todos first*

_Acceptance Criteria_
- [ ] should be doable with a single click
- [ ] should add a red flag against the todo when marked important
- [ ] should remove the red colour flag on the flag when important removed
- [ ] should not affect existing todos

_On page load:_
- [ ] should display existing todos that are not marked important
- [ ] should display existing todos that are marked important with an red flag -->

## Step by Step Instructions

### Part 1 - Tests in our Pipeline
> _In this part we will get familiar with the layout of our tests. We will also improve the pipeline created already by adding some unit tests for the front end & backend along with some end to end tests (e2e) to validate the full solution_

#### 1a - Unit tests
> In this exercise we will execute our test for the front end locally. Once verified we will add them to Jenkins.

1. Before linking our automated testing to the pipeline we'll first ensure the tests run locally. Change to the `todolist` directory and run `test`.
```bash
cd /projects/todolist
```
```bash
npm run test:client
```
<p class="tip" >
<b>NOTE</b> - <i>test:client</i> is an alias used that runs <i>vue-cli-service test</i> from the scripts object in <i>package.json</i>
</p>

2. This command will run all `*spec.js` files. Our test files are stored in the following places. There are 12 front end test files stored in these directories: `todolist/tests/unit/vue-components/*` & `todolist/tests/unit/javascript/*`

3. You should see an output similar to the following. The above command has run a test suite for every `*.spec.js` file. The table generated in the terminal shows the code coverage. We're going to be focusing on the unit tests for now.

![test-run-locally](../images/exercise3/test-run-locally.png)

4. Let's now try and get our Server tests running locally. Ensure your Database is running by opening a new terminal session and run the following command. This will start our mongodb locally. 
```bash
npm run mongo:start-ide
```
<p class="tip" >
<b>NOTE</b> - you can skip this step if you have your DB running from previous exercise
</p>

5. Run your server side test with the following command. This will fire some requests against the API, validating that CRUD is working. 
```bash
npm run test:server
```
![test-server-run-locally](../images/exercise3/test-server-run-locally.png)

<p class="tip" >
<b>NOTE</b> - If you see the error <i>Uncaught Error: listen EADDRINUSE 0.0.0.0:9000</i> you may need to stop your running todolist app (or type <i>killall node</i> to stop all node processes).
</p>

6. With our tests all passing in the cloud ide, let's add them to our pipeline. Open the `Jenkinsfile` in your editor and add the command to run all the tests in the `steps{}` part of the `node-build` stage.

<kbd>📝 todolist/Jenkinsfile</kbd>
```Jenksfile
steps {
    sh 'printenv'

    echo '### Install deps ###'
    sh 'npm install'

    echo '### Running tests ###'
    sh 'npm run test:all:ci'
```

7. Running the tests is important, but so is reporting the results. In the `post{}` `always{}` section of the `Jenkinsfile` add the location for Jenkins for find the test reports

<kbd>📝 todolist/Jenkinsfile</kbd>
```Jenksfile
post {
    always {
        archive "**"
        // ADD TESTS REPORTS HERE
        junit 'test-report.xml'
        junit 'reports/server/mocha/test-results.xml'
    }
```

8. With this in place, commit the changes which should trigger a build.
```bash
git add Jenkinsfile
git commit -m "Adding unit tests to the pipeline"
git push
```

9.  Navigate to your instance of Jenkins at `https://jenkins-<YOUR_NAME>-ci-cd.<APPS_URL>` and you should see the tests are now running in your pipeline. You should see a test trend graph only after two runs of the build


#### 1b - End to End Tests (e2e)
> _Unit tests are a great way to get immediate feedback as part of testing an application. End to end tests that drive user behaviour are another amazing way to ensure an application is behaving as expected._

In this part of the exercise, we will add a new stage to our pipeline called `todolist-e2e` that will run after the deploy has been completed. End to end tests will use `Nightwatch.js` to orchestrate a Selenium WebDriver instance that controls the web browser; in this case Google Chrome!

1. Ensure the `todolist` app is running in a separate terminal shell.
```
npm run serve:all
```

2. Let's start by checking that our tests execute in the cloud ide. Our end to end tests are stored in `tests/e2e/specs/`. The VueJS cli uses `Nightwatch.js` and comes pre-configured to run tests against Google Chrome. The tests run headlessly in our CodeReady workspace. To get them executing, open a new Terminal and fire up the Selenium service and leave it running.
```bash
cd /projects/todolist
npm run selenium
```

3. On a new terminal move to the `todolist` folder. Run the tests locally by executing the following command. This should start the dev server and run the test.
```bash
cd /projects/todolist
npm run e2e:ide
```

![local-e2e](../images/exercise3/local-e2e.png)

4. With tests executing successfully locally; let's add them to our Jenkins pipeline. To do this; we'll create a new stage in our `Jenkinsfile`. Create a new `stage` called `e2e test` to run after the `node-deploy stage`

<kbd>📝 todolist/Jenkinsfile</kbd>
```Jenksfile
stage("e2e test") {
      
}
```
![e2e-stage-new](../images/exercise3/e2e-stage-new.png)

5. Set the agent that this stage should execute on. In this case it will use the same `jenkins-slave-npm` that was used in the build stage. Set the steps needed to execute the tests and add the reporting location

<kbd>📝 todolist/Jenkinsfile</kbd>
```Jenksfile
stage("e2e test") {
            agent {
                node {
                    label "jenkins-slave-npm"
                }
            }
            when {
                expression { GIT_BRANCH ==~ /(.*master|.*develop)/ }
            }
            steps {
              unstash 'source'

              echo '### Install deps ###'
              sh 'npm install'

              echo '### Running end to end tests ###'
              sh 'npm run e2e:jenkins'
            }
            post {
                always {
                    junit 'reports/e2e/specs/*.xml'
                }
            }
        }
```

6. With this in place, commit the changes to trigger a build and enhance our pipeline 
```bash
git add Jenkinsfile
git commit -m "Adding e2e tests to the pipeline"
git push
```

7. Jenkins should now show the additional stage in the pipeline view for the branch
![e2e-pipeline](../images/exercise3/e2e-pipeline.png)

### Part 2 - TodoList new feature
> _In this exercise we will introduce a new feature to create an important flag on the todos. In order to be able to build and test our feature we will use TDD_

*As a doer I want to mark todos as important so that I can keep track of and complete high priority todos first*

_Acceptance Criteria_
- [ ] should be doable with a single click
- [ ] should add a red flag against the todo when marked important
- [ ] should remove the red colour flag on the flag when important removed
- [ ] should not affect existing todos

_On page load:_
- [ ] should display existing todos that are not marked important
- [ ] should display existing todos that are marked important with an red flag

#### 2a - Create todolist api tests
> Using [Mocha](https://mochajs.org/) as our test runner; we will now write some tests for backend functionality to persist our important-flag. The changes required to the backend are minimal but we will use TDD to create our test first, then implement the functionality.

1.  Create a new branch in your `todolist` app for our feature and push it to the remote

```bash
cd todolist
```
```bash
git checkout -b feature/important-flag
```
```bash
git push -u origin feature/important-flag
```

2.  Navigate to the `server/api/todo/todo.spec.js` file. This contains all of the existing todo list api tests. These are broken down into simple `describe("api definition", function(){})` blocks which is BDD speak for how the component being tested should behave. Inside of each `it("should do something ", function(){})` statements we use some snappy language to illustrate the expected behaviour of the test. For example a `GET` request of the api is described and tested for the return to be of type Array as follows.

<kbd>📝 todolist/server/api/todo/todo.spec.js</kbd>
```javascript
describe("GET /api/todos", function() {
    it("should respond with JSON array", function(done) {
        request(app)
        .get("/api/todos")
        .expect(200)
        .expect("Content-Type", /json/)
        .end(function(err, res) {
            if (err) return done(err);
            // Test goes here
            res.body.should.be.instanceof(Array);
            done();
        });
      });
});
```
where:
  - `describe` is used to group tests together into a collection asserting some feature; for example the get all todos api.
  - `it` is an individual test statement and should contain an `expect` or a `should` statement asserting behaviour of the API under test.
  - `request` is a library for making http calls to the api.
  - `.expect(200)` asserts the HTTP Return Code
  - `res.body.should.be.instanceof(Array);` is the actual test call
  - `done();` tells the test runner that `mocha` has finished execution. This is needed as the http calls are asynchronous.

3.  With this knowledge; let's implement our test for the `important` flag. We expect the front end to introduce a new property on each `todo` that gets passed to the backend called `important`. The API will need to handle this new property and pass it into the mongodb. Let's begin implementing this functionality by writing our test case. Navigate to the `PUT /api/todos` section of the `server/api/todo/todo.spec.js` test file (which should be at the bottom)

![todo-api-tests](../images/exercise3/todo-api-tests.png)

4. Before writing our test; let's first make sure all the existing tests are passing. Ensure that your MongoDB container is running before running the tests (using the `npm run mongo:*` scripts)

```bash
npm run test:server
```

5. With all the tests passing; let's add our new one. For ease of completing this exercise a template of a new test has been written at the very end of the file (just below the `  // Exercise 3 test case!` comment). A PUT request responds in our API with the data that it has just updated. So provided that MongoDB accepted the change, the API will respond with an object that has the `important` property on it. To write our test; edit the template test by completing the following:
    * Edit the `it("should ...")` to describe the important flag we're testing
    * Edit the `.send()` to include `important: true` property
    * Check the `.expect()` clause is set to `.expect(200)`
    * Add a new test assertion to check that `res.body.important` is `true` below the `// YOUR TEST GO HERE` line.

<kbd>📝 todolist/server/api/todo/todo.spec.js</kbd>
```javascript
// Exercise 3 test case!
it("should mark todo as important and persist it", function(done) {
    request(app)
      .put("/api/todos/" + todoId)
      .send({
        title: "LOVE endpoint/server side testing!",
        completed: true,
        important: true
      })
      .expect(200)
      .expect("Content-Type", /json/)
      .end(function(err, res) {
          if (err) return done(err);
          res.body.should.have.property("_id");
          res.body.title.should.equal("LOVE endpoint/server side testing!");
          // YOUR TEST GO HERE
          res.body.important.should.equal(true);
          done();
      });
});
```

6.  Run your test. It should fail.
```bash
npm run test:server
```

![fail-mocha](../images/exercise3/fail-mocha.png)

7.  With our test now failing; let's implement the feature. This is quite a simple change - we first need to update the `server/api/todo/todo.model.js`. Add an additional property on the schema called `important` and make its type Boolean.

<kbd>📝 todolist/server/api/todo/todo.model.js</kbd>
```javascript
const TodoSchema = new Schema({
  title: String,
  completed: Boolean,  
  important: Boolean
});
```

8. Next we need to update the `server/config/seed.js` file so that the pre-generated todos have an important property. Add `important: false` below `completed: *` for each object. Don't forget to add a comma at the end of the `completed: *` line.

![api-add-seed-important](../images/exercise3/api-add-seed-important.png)

9.  With your changes to the Database schema updated; re-run your tests. The tests should pass.
```bash
npm run test:server
```

10.  Commit your code to the `feature/important-flag` branch and then merge onto the `develop` branch as follows

```bash
git add .
```
```bash
git commit -m "ADD backend schema updates"
```
```bash
git push
```
```bash
git checkout develop
```
```bash
git merge feature/important-flag
```
```bash
git push
```

#### 2b - Create todolist front-end tests
> Using [Jest](https://facebook.github.io/jest/) as our test runner and the `vue-test-utils` library for managing our vue components; we will now write some tests for front end functionality to persist our important-flag. The changes required to the front end are quite large but we will use TDD to create our test first, then implement the functionality.

Our TodoList App uses `vuex` to manage the state of the app's todos and `axios` HTTP library to connect to the backend. `Vuex` is an opinionated framework for managing application state and has some key design features you will need to know to continue with the exercise.

In `vuex` the application state is managed by a `store`. The `store` houses all the todos we have retrieved from the backend as well as the `getter` methods for our array of `todos`. In order to make changes to the store, we could call the store directly and update each todo item but as earlier said; vuex is an opinionated module with its own way of updating the store. It is bad practice to call the store directly.

There are two parts of the lifecycle to updating the store, the `actions` & `mutations`. When the user clicks a todo to mark it as complete; the `actions` are called. An action could involve a call to the backend or some pre-processing of the data. Once this is done, the change is committed to the store by calling the `mutation` function. A store should only ever be manipulated through a mutation function. Calling the mutation will then update the todo object in the app's local store for rendering in the view.

For example; when marking a todo as done in the UI, the following flow occurs
  * The `TodoItem.vue` calls the `markTodoDone()` function which dispatches an event to the store.
  * This calls the `updateTodo()` function in the `actions.js` file
  * The action will update the backend db (calling our `todolist api`) with our updated todo object.
  * The action will commit the change to the store by calling the mutation method `MARK_TODO_COMPLETED`
  * The `MARK_TODO_COMPLETED` will directly access the store object and update it with the new state value
  * The `ListOfTodos.vue` component is watching the store for changes and when something gets updated it re-renders the `TodoItem.vue`.

The implementation of our `important` flag will follow this same flow.

1. Let's implement our feature by first creating a branch. Our new feature, important flag will behave in the same way as the `MARK_TODO_COMPLETED`. Create a new branch in your `todolist` app for our feature and push it to the remote

```bash
cd todolist
```
```bash
git checkout -b feature/important-flag
```
```bash
git push -u origin feature/important-flag
```

2. Let's get our tests running by executing a `--watch` on our tests. This will keep re-running our tests everytime there is a file change. It is handy to have this running in a new terminal session.
```bash
npm run test:client -- --watch
```

3. All the tests should be passing when we begin. If `No tests found related to files changed since last commit` is on show; hit `a` on the terminal to re-run `all` tests.

![rerun-all](../images/exercise3/rerun-all.png)

4. We will add new tests in three places to validate our function behaves as expected against the acceptance criteria from the Feature Story supplied to us. We will need to write tests for our `TodoItem.vue` to verify having a red flag and that it is clickable. Our app is going to need to persist the changes in the backend so we'll want to make changes to our `actions.js` and `mutations.js` to keep the API and local copy of the store in sync. Let's start with our `TodoItem.vue` component. Open the `tests/unit/vue-components/TodoItem.spec.js` file. This has been templated with some example test to correspond with our A/Cs for speed of doing the exercise. Find the describe block for our important flag tests. It is set up already with a `beforeEach()` hook for test setup.

![important-flag-before](../images/exercise3/important-flag-before.png)

5. Each of our test cases has its skeleton in place already for example the `TodoItem.vue` component takes a property of `todos` when rendering. This setup is already done for each of our tests so all we have to do is fill in our assertions.

![todoitem-skeleton-tests](../images/exercise3/todoitem-skeleton-tests.png)

6. Let's implement the first test `it("should render a button with important flag"`. This test will assert if the button is present on the page and it contains the `.important-flag` CSS class. To implement this; add the `expect` statement as follows below the `// TODO - test goes here!` comment.  

<kbd>📝 todolist/tests/unit/vue-components/TodoItem.spec.js</kbd>
```javascript
  it("should render a button with important flag", () => {
    const wrapper = mount(TodoItem, {
      propsData: { todoItem: importantTodo }
    });
    // TODO - test goes here!
    expect(wrapper.find(".important-flag").exists()).toBe(true);
  });
```

7. Save the file. Observe that the test case has started failing because we have not yet implemented the feature!

![todoitem-fail-test](../images/exercise3/todoitem-fail-test.png)

8. With a basic assertion in place, let's continue on to the next few tests. We want the important flag to be red when an item in the todolist is marked accordingly. Conversely we want it to be not red when false. Let's create a check for `.red-flag` CSS property to be present when important is true and not when false. Complete the `expect` statements in your test file as shown below for both tests.

<kbd>📝 todolist/tests/unit/vue-components/TodoItem.spec.js</kbd>
```javascript
  it("should set the colour to red when true", () => {
    const wrapper = mount(TodoItem, {
      propsData: { todoItem: importantTodo }
    });
    // TODO - test goes here!
    expect(wrapper.find(".red-flag").exists()).toBe(true);
  });
  it("should set the colour to not red when false", () => {
    importantTodo.important = false;
    const wrapper = mount(TodoItem, {
      propsData: { todoItem: importantTodo }
    });
    // TODO - test goes here!
    expect(wrapper.find(".red-flag").exists()).toBe(false);
  });
```

9. Finally, we want to make the flag clickable and for it to call a function to update the state. The final test in the `TodoItem.spec.js` we want to create should simulate this behaviour. Implement the `it("call markImportant when clicked", () ` test by first simulating the click of our important-flag and asserting the function `markImportant()` to write is executed.

<kbd>📝 todolist/tests/unit/vue-components/TodoItem.spec.js</kbd>
```javascript
  it("call markImportant when clicked", () => {
    const wrapper = mount(TodoItem, {
      methods,
      propsData: { todoItem: importantTodo }
    });
    // TODO - test goes here!
    const input = wrapper.find(".important-flag");
    input.trigger("click");
    expect(methods.markImportant).toHaveBeenCalled();
  });
```

10. With our tests written for the feature's UI component, let's implement our code to pass the tests. Explore the `src/components/TodoItem.vue`. Each vue file is broken down into 3 sections

    * The `<template></template>` contains the HTML of our component. This could include references to other Components also
    * The `<script></script>` contains the JavaScript of our component and is essentially the logic for our component. It defines things like `properties`, `methods` and other `components`
    * The `<style></style>` contains the encapsulated CSS of our component

11. Underneath the `</md-list-item>` tag, let's add a new md-button. Add an `.important-flag` class on the `md-button` and put the svg of the flag provided inside it.

<kbd>📝 todolist/src/components/TodoItem.vue</kbd>
```html
    </md-list-item>
    <!-- TODO - SVG for use in Exercise3 -->
    <md-button class="important-flag">
        <svg height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
    </md-button>
```

12. We should now see the first of our failing tests has started to pass. Running the app locally (using `npm run serve`) should show the flag appear in the UI. It is clickable but won't fire any events and the colour is not red as per our requirement. 

<p class="tip" >
<b>NOTE</b> - If you don't see the important flag in the CRW UI preview window, an old UI version might be cached. Try to use the external link provided by CRW.
</p>

Let's continue to implement the colour change for the flag. On our `<svg/>` tag, add some logic to bind the css to the property of a `todo.important` by adding ` :class="{'red-flag': todoItem.important}"  `. This logic will apply the CSS class when `todo.important`  is true.

<kbd>📝 todolist/src/components/TodoItem.vue</kbd>
```html
<md-button class="important-flag">
    <svg :class="{'red-flag': todoItem.important}"  height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
</md-button>
```

13. More tests should now be passing. Let's wire the click of the flag to an event in Javascript. In the methods section of the `<script></script>` tags in the Vue file, implement the `markImportant()`. We want to wire this to the action to updateTodo, just like we have in the `markCompleted()` call above it. We also need to pass an additional property to this method called `important`

<kbd>📝 todolist/src/components/TodoItem.vue</kbd>
```javascript
    markImportant() {
      // TODO - FILL THIS OUT IN THE EXERCISE
      this.$store.dispatch("updateTodo", {id: this.todoItem._id, important: true});
      console.info("INFO - Mark todo as important ", this.todoItem.important);
    }
```

14. Let's connect the click button in the DOM to the Javascript function we've just created. In the template, add a click handler to the md-button to call the function `markImportant()` by adding ` @click="markImportant()"` to the `<md-button>` tag

<kbd>📝 todolist/src/components/TodoItem.vue</kbd>
```html
    <!-- TODO - SVG for use in Exercise3 -->
    <md-button class="important-flag" @click="markImportant()">
        <svg :class="{'red-flag': todoItem.important}"  height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
    </md-button>
```

15. Finally - we need to make it so that when a new todo item is created it will have an important property. Head to `src/store/actions.js` and add `important: false`  below `completed: false` in the `addTodo(){}` action.

![fe-add-actions-important](../images/exercise3/fe-add-actions-important.jpg)


16. The previously failing tests should have started to pass now. With this work done, let's commit our code. On the terminal, run
```bash
git add .
```
```bash
git commit -m "Implementing the todoitem flag"
```
```bash
git push
```

17. Start our local development server (if not already running) to manually verify the changes 

```bash
npm run serve:all
```

18. Open our local todolist app (http://localhost:8080/#/todo). If we try to use our important flag, we should see it's still not behaving as expected; this is because we're not updating the state of the app in response to the click event.

19. We need to implement the `actions` and `mutations` for our feature. Let's start with the tests. Open the `tests/unit/javascript/actions.spec.js` and navigate to the bottom of the file. Our action should should commit the `MARK_TODO_IMPORTANT` to the mutations. Scroll to the end of the test file and implement the skeleton test by adding `expect(commit.firstCall.args[0]).toBe("MARK_TODO_IMPORTANT");` as the assertion.

<kbd>📝 todolist/tests/unit/javascript/actions.spec.js</kbd>
```javascript
  it("should call MARK_TODO_IMPORTANT", done => {
    const commit = sinon.spy();
    state.todos = todos;
    actions.updateTodo({ commit, state }, { id: 1, important: true }).then(() => {
        // TODO - test goes here!
        expect(commit.firstCall.args[0]).toBe("MARK_TODO_IMPORTANT");
        done();
    });
  });
```

20.  We should now have more failing tests, let's fix this by adding the call from our action to the mutation method. Open the `src/store/actions.js` file and scroll to the bottom to the `updateTodo()` method. Complete the if block by adding `commit("MARK_TODO_IMPORTANT", i);` as shown below.

<kbd>📝 todolist/src/store/actions.js</kbd>
```javascript
updateTodo({ commit, state }, { id, important }) {
    let i = state.todos.findIndex(todo => todo._id === id);
    if (important) {
        // TODO - add commit important here!
        commit("MARK_TODO_IMPORTANT", i);
    } else {
        commit("MARK_TODO_COMPLETED", i);
    }
```

21.  Finally, let's implement the `mutation` for our feature. Again, starting with the tests... Open the `tests/unit/javascript/mutations.spec.js` to find our skeleton tests at the bottom of the file. Our mutation method is responsible for toggling the todo's `important` property between `true` and `false`. Let's implement the tests for this functionality by setting important to be true and calling the method expecting the inverse. Then let's set it to false and call the method expecting the inverse. Add the expectations below the `// TODO - test goes here!` comment as done previously.

<kbd>📝 todolist/tests/unit/javascript/mutations.spec.js</kbd>
```javascript
  it("it should MARK_TODO_IMPORTANT as false", () => {
    state.todos = importantTodos;
    // TODO - test goes here!
    mutations.MARK_TODO_IMPORTANT(state, 0);
    expect(state.todos[0].important).toBe(false);
  });

  it("it should MARK_TODO_IMPORTANT as true", () => {
    state.todos = importantTodos;
    // TODO - test goes here!
    state.todos[0].important = false;
    mutations.MARK_TODO_IMPORTANT(state, 0);
    expect(state.todos[0].important).toBe(true);
  });
```

22. With our tests running and failing, let's implement the feature to their spec. Open the `src/store/mutations.js` and add another function called `MARK_TODO_IMPORTANT` below the `MARK_TODO_COMPLETED` to toggle `todo.important` between true and false. NOTE - add a `,` at the end of the `MARK_TODO_COMPLETED(){}` function call.

<kbd>📝 todolist/src/store/mutations.js</kbd>
```javascript
  MARK_TODO_IMPORTANT(state, index) {
    console.log("INFO - MARK_TODO_IMPORTANT");
    state.todos[index].important = !state.todos[index].important;
  }
```

![mark-todo-important](../images/exercise3/mark-todo-important.png)

23. All our tests should now be passing. On the watch tab where they are running, hit `a` to re-run all tests and update any snapshots with `u` if needed.

24. With all our tests now passing, let's commit our code. On the terminal, run

```bash
git add .
```
```bash
git commit -m "Implementing the store and actions"
```
```bash
git push
```

25. Before running a build in Jenkins, let's add our tests and code to the develop branch. Ask your neighbour to review your code changes and if they approve; merge them to Develop! (If you're feeling adventurous - raise a PR through GitLab and have someone on your desk peer review it!)

```bash
git checkout develop
```
```bash
git merge feature/important-flag
```
```bash
git push --all
```

#### 2c - Create todolist e2e tests

> _Using [Nightwatch.js](http://nightwatchjs.org/) We will write a reasonably simple e2e test to test the functionality of the feature we just implemented._

1.  Firstly we need to create an e2e spec test file in the correct place.

```bash
touch tests/e2e/specs/importantFlag.js
```

2.  Open this new file in your code editor and set out the initial blank template for an e2e test as below:

<kbd>📝 todolist/tests/e2e/specs/importantFlag.js</kbd>
```javascript
  module.exports = {
    "Testing important flag setting": browser => {

    }
  };
```
![if-e2e-step1](../images/exercise3/if-e2e-step1.png)

3.  Now get the test to access the todos page and wait for it to load. The url can be taken from `process.env.VUE_DEV_SERVER_URL`

    ![if-e2e-step2](../images/exercise3/if-e2e-step2.png)

4.  Write code to do the following:
    * Click the clear all button and then enter a value in the textbox to create a new item. 
    * Assert that an 'important flag' exists (the button to set important)
    * Assert that a red flag does not exist. 
    * Click the important flag and check whether the flag has turned red.

5. You will need to reference the clear all button from the test code. We will therefore have to go to `src/components/XofYItems.vue` and add `id="clear-all"` to the clear all button.

    <!-- ![if-e2e-step3](../images/exercise3/if-e2e-step3.png) -->
    ![if-e2e-step3a](../images/exercise3/if-e2e-step3a.png)

<kbd>📝 src/components/XofYItems.vue</kbd>
```html
  <template>
    <div>
        <div class="xofyDone">
            <span> {{sumDoneTodoItems(todos)}} out of {{this.todos.length}} done. </span>
            <md-button class="md-raised" v-on:click="clearDoneTodos()">Clear Done</md-button>
            <md-button id="clear-all" class="md-raised" v-on:click="clearTodos()">Clear all</md-button>
        </div>
    </div>
  </template>
```

6.  Write the following test code. The pauses allow for the body of the page to render the todo list before exercising the test code:

<kbd>📝 todolist/tests/e2e/specs/importantFlag.js</kbd>
```javascript
  module.exports = {
    "Testing important flag setting": browser => {
      browser
        .url(process.env.VUE_DEV_SERVER_URL + '/#/todo')
        .waitForElementVisible("body", 5000)
        .pause(5000)
        .click('#clear-all')
        .pause(2000)
        .setValue('input',['set a todo',browser.Keys.ENTER])
        .pause(2000)
        .assert.elementPresent(".important-flag")
        .assert.elementNotPresent(".red-flag")
        .click('.important-flag')
        .end();
    }
  };
```

7. Your final E2E test should look like the following:

    ![if-e2e-step4](../images/exercise3/e2e-code-listing-full.jpg)

8.  At this point we should have a working e2e test. We can run this by using `npm run e2e`. When all tests pass, we can push up these changes.

```bash
git add .
```

```bash
git commit -m "Implementing e2e tests"
```

```bash
git push
```

---

## Extension Tasks

> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

* Add Config maps to inject DB creds to the app
* Create a blue/green deploy based on the success of running e2e tests against either blue or green and flopping load over to new endpoint when successful.
Advanced
* Add Auth0 support to your FE app.

<!-- 
## Additional Reading

> List of links or other reading that might be of use / reference for the exercise

## Slide links

- [Intro](https://docs.google.com/presentation/d/18W0GoBTwRGpgbOyHf2ZnL_OIWU_DvsoR14H0_t5jisA)
- [Wrap-up](https://docs.google.com/presentation/d/1uIYHC57POSaVD6XNZGhdetABiSnlP1TztYTgglMP-DA)
- [All Material](https://drive.google.com/drive/folders/1xVaQukmwwmyJSDN0zOkghZX7yb-0freT) -->
