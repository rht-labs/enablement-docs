# Exercise Title

> The purpose of this lab is to develop and validate a new feature using TDD; and to promote the assured feature through the pipeline.

---

## Learning Outcomes

As a learner you will be able to

* Understand the why behind TDD
* Implement a feature using TDD for frontend and backend
* Write end to end tests for the feature and run them in CI

## Tools and Frameworks

> Name of tool - short description and link to docs or website

1.  [Jest](https://facebook.github.io/jest/) - Zero configuration testing platform
Jest is used by Facebook to test all JavaScript code including React applications. One of Jest's philosophies is to provide an integrated "zero-configuration" experience. We observed that when engineers are provided with ready-to-use tools, they end up writing more tests, which in turn results in more stable and healthy code bases.
1.  [Vue Test Utils](https://vue-test-utils.vuejs.org/en/) - Vue Test Utils is the official unit testing utility library for Vue.js.
1.  [Nightwatch.js](http://nightwatchjs.org/) - Nightwatch.js is an easy to use Node.js based End-to-End (E2E) testing solution for browser based apps and websites. It uses the powerful W3C WebDriver API to perform commands and assertions on DOM elements.
1.  [Mocha](https://mochajs.org/) - Mocha is a feature-rich JavaScript test framework running on Node.js and in the browser, making asynchronous testing simple and fun. Mocha tests run serially, allowing for flexible and accurate reporting, while mapping uncaught exceptions to the correct test cases. Hosted on GitHub.
1.  [Sinon](http://sinonjs.org/) - Standalone test spies, stubs and mocks for JavaScript. 
Works with any unit testing framework.

## Big Picture

This exercise begins cluster containing blah blah

---

## 10,000 Ft View

> The goal of this exercise is to add a new component to the application using TDD to create and validate it's behaviour. The User story we have been given is as follows:

*As a doer I want to mark todos as important so that I can keep track of and complete high prirority todos first*

_Acceptance Criteria_
- [ ] should be doable with a single click
- [ ] should add a red flag against the todo when marked important
- [ ] should remove the red colour flag on the flag when important removed
- [ ] should not affect existing todos

_On page load:_
- [ ] should display existing todos that are not marked important
- [ ] should display existing todos that are marked important with an red flag

## Step by Step Instructions

> This is a fairly structured guide with references to exact filenames and sections of text to be added.

### Part 1 - Tests in our Pipeline

> _In this exercise we will improve the pipeline created already by adding some unit tests for the frontend & backend along with some end to end tests (e2e) to validate the full solution_

#### Part 1a - Unit tests

2.  TODO - show tests running locally etc (fe and api)

3.  TODO - add tests to jenkins with screenshots etc.

#### Part 1b - End to End tests (e2e)

2.  Add new part to the dev pipeline (`dev-todolist-fe-e2e`)

3.  Add tests and reports to Jenkins

### Part 2 - TodoList new feature

> _In this exercise we will introduce a new feature to create an important flag on the todos. In order to be able to build and test our feature we will use TDD_

*As a doer I want to mark todos as important so that I can keep track of and complete high prirority todos first*

_Acceptance Criteria_
- [ ] should be doable with a single click
- [ ] should add a red flag against the todo when marked important
- [ ] should remove the red colour flag on the flag when important removed
- [ ] should not affect existing todos

_On page load:_
- [ ] should display existing todos that are not marked important
- [ ] should display existing todos that are marked important with an red flag

#### Part 1a - Create todolist-api tests

> Using [Mocha](https://mochajs.org/) as our test runner; we will now write some tests for backend functionality to persist our important-flag. The changes required to the backend are minimal but we will use TDD to create our test first, then implement the functionality.

3.  Create a new branch in your `todolist-api` app for our feature and push it to the remote
```bash
$ git checkout -b feature/important-flag
$ git push -u origin feature/important-flag
```

3.  Navigate to the `server/api/todo/todo.spec.js` file. This contains all of the existing todo list api tests. These are broken down into simple `describe("api definition", function(){})` blocks which is BDD speak for how the component being tested should behave. Inside of each `it("should do something ", function(){})` statements we use some snappy language to illustrate the expected behaviour of the test. For example a `GET` request of the api is described and tested for the return to be of type Array as follows.
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
_ `describe` is used to group tests together into a collection asserting some feature; for example the get all todos api.
_ `it` is an individual test statement and should contain an `expect` or a `should` statement asserting behaviour of the API under test.
_ `request` is a library for making http calls to the api.
_ `.expect(200)` asserts the HTTP Return Code
_ `res.body.should.be.instanceof(Array);` is the actual test call
_ `done();` tells the test runner that `mocha` has finished execution. This is needed as the http calls are asynchronous.

3.  With this knowledge; let's implement our test for the `important` flag. We expect the fronted to introduce a new property on each `todo` that gets passed to the backend called `important`. The API will need to handle this new property and pass it into the mongodb. Let's begin implementing this functionality by writing our test case. Navigate to the `PUT /api/todos` section of the test which should be at the bottom ![todo-api-tests](../images/exercise3/todo-api-tests.png).

3.  Before writing our test; let's first make sure all the existing tests are passing.
```bash
$ npm run test
```

3.  With all the tests passing; let's add our new one. For ease of completing this exercise a template of a new test has been written at the very end of the file. A PUT request responds in our API with the data that it just updated, so provided that MongoDB accepted the change, it will respond with an object that has the `important` property on it. To write our test; edit the `it("should ....", function(done) {` by completing the following:
    * Edit the `it("should ...")` to describe the imporant flag we're testing
    * Edit the `.send()` to include `important: true` property
    * Add a new test assertion to check that `res.body.important` is `true` below the `// YOUR TEST GO HERE` line.
```javascript
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

3.  Run your test. It should fail.
```bash
$ npm run test
```
![fail-mocha](../images/exercise3/fail-mocha.png)

3.  With our test now failing; let's implement the feature. This is quite a simple change; all we need to do it update the `server/api/todo/todo.model.js` to allow an additional property on the schema called `important` of type Boolean.
```javascript
const TodoSchema = new Schema({
  title: String,
  completed: Boolean,
  important: Boolean
});
```

3.  With your changes to the Database schema updated; re-run your tests.
```bash
$ npm run test
```

3.  Commit your code to the `feature/important-flag` branch and then merge onto the `develop` branch as follows
<p class="tip">
NOTE - At this point in a residency we would peer review the code before pushing it to develop or master branch!
</p>
```bash
$ git add .
$ git commit -m "ADD backend schema updates"
$ git checkout develop
$ git merge feature/important-flag
$ git push --all
```

#### Part 1b - Create todolist-fe tests
> Using [Jest](https://facebook.github.io/jest/) as our test runner and the `vue-test-utils` library for managing our vue components; we will now write some tests for fronted functionality to persist our important-flag. The changes required to the front end are quite large but we will use TDD to create our test first, then implement the functionality. 

Our TodoList App uses `vuex` to manage the state of the apps' todos and `axios` HTTP library to connect to the backend. `Vuex` is an opinionated framework for managing application state and has some key design features you will need to know to continue with the exercise. 

In `vuex` the application state is managed by a `store`. The `store` houses all the todos we have retrieved from the backend as well as the `getter` methods for our array of `todos`. In order to make changes to the store, we could call the store directly and update each todo item but as earlier said; vuex is an opinionated module with it's own way of updating the store. It is bad practice to call the store directly. 

There are two parts of the lifecycle to updating the store, the `actions` & `mutations`. When the user clicks a todo to mark it as complete; the `actions` are called. An action could involve a call to the backend or some pre-processing of the data. Once this is done, the change is committed to the store by calling the `mutation` function. A store should only ever be manipulated through a mutation function. Calling the mutation will then update the todo object in the apps local store for rendering in the view.

For example; when marking a todo as done in the UI, the following flow occurs
    * The `TodoItem.vue` calls the `markTodoDone()` function which dispatches an event to the store.
    * This calls the `updateTodo()` function in the `actions.js` file
    * The action will update the backend db (calling our `todolist-api`) with our updated todo object.
    * The action will commit the change to the store by calling the mutation method `MARK_TODO_COMPLETED`
    * The `MARK_TODO_COMPLETED` will directly access the store object and update it with the new state value
    * The `ListOfTodos.vue` component is watching the store for changes and when something gets updated it re-renders the `TodoItem.vue`.

3. Let's implement our feature by first creating a branch. Our new feature, important flag will behave in the same way as the `MARK_TODO_COMPLETED`. Create a new branch in your `todolist-fe` app for our feature and push it to the remote
```bash
$ git checkout -b feature/important-flag
$ git push -u origin feature/important-flag
```

3. Let's get our tests running by executing a `--watch` on our tests. This will keep re-running our tests everytime there is a file change. All the tests should be passing when we begin
```bash
$ npm run test -- --watch
```

3. There are three places we will add new tests to validate our function behaves as expected against the acceptance criteria from Feature Story supplied to us. We will need to write tests for our `TodoItem.vue` to handle having a red flag and that it is clickable. Our app is going to need to persist the changes in the backend so we'll want to make changes to our `actions.js` and `mutations.js` to keep the api and local copy of the store in sync. Let's start with our `TodoItem.vue` component. Open the `tests/unit/vue-components/TodoItem.spec.js` file. This has been templated with some example test to correspond with our A/Cs for speed of doing the lab. Find the describe block for our important flag tests. It is setup already with a `beforeEach()` hook for test setup.
![important-flag-before](../images/exercise3/important-flag-before.png)

3. Each of our test cases has it's skeleton in place already for example the `TodoItem.vue` component takes a property of `todos` when rendering. This setup is already done for each of our tests so all we have to do is fill in our assertions.
![todoitem-skeleton-tests](../images/exercise3/todoitem-skeleton-tests.png)

3. Let's implement the first test `it("should render a button with important flag"`. This test will assert if the button is present on the page and it contains the `.important-flag` CSS class. To implement this; add the expect statement as follows.  
```javascript
  it("should render a button with important flag", () => {
    const wrapper = mount(TodoItem, {
      propsData: { todoItem: importantTodo }
    });
    // TODO - test goes here!
    expect(wrapper.find(".important-flag").exists()).toBe(true);
  });
```

3. Save the file and we should see in our test watch the test case has started failing because we have not yet implemented the feature!
![todoitem-fail-test](../images/exercise3/todoitem-fail-test.png)

3. With a basic assertion in place, let's continue on to the next few tests. We want the important flag to be red when an item in the todolist is marked accordingly. Conversely we want it to be not red when false. Let's create a check for `.red-flag` CSS property to be present when imporant is true and not when false.
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

3. Finally, we want to make the flag clickable and for it to call a function to update the state. The final test in the `TodoItem.spec.js` we want to create should simulate this behaviour. Implement the `it("call makImportant when clicked", () ` test by first simulating the click of our important-flag and asserting the function `markImportant()` to write is executed.
```javascript
  it("call makImportant when clicked", () => {
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

3. With our tests written for the feature's UI component, let's implement our code to pass the tests. Open up the `src/components/TodoItem.vue`. Each vue file is broken down into 3 sections
    * The `<template></template>` contains the HTML of our component. This could include references to other Components also
    * The `<script></script>` contains the JavaScript of our component and is essentially the logic for our component. It defines things like `properties`, `methods` and other `components`
    * The `<style></style>` contains the encapsulated CSS of our component
Underneath the `</md-list-item>` tag, let's add a new md-button. Add a `.important-flag` class on the `md-button` and put the svg of the flag provided inside it.
```html
    </md-list-item>
    <!-- TODO - SVG for use in Lab3 -->
    <md-button class="important-flag">
        <svg height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
    </md-button>
```

3. We should now see the first of our failing tests has started to pass. Running the app locally (using `npm run serve`) should show the flag appear in the UI. It is clickable but won't fire any events and the colour is not red as per our requirement. Let's continue to implement the colour change for the flag. On our `<svg/>` tag, add some logic to bind the css to the property of a `todo.important` by adding ` :class="{'red-flag': todoItem.important}"  `. This logic will apply the CSS class when `todo.important`  is true.
```html
<md-button class="important-flag">
    <svg :class="{'red-flag': todoItem.important}"  height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
</md-button>
```

3. More tests should now be passing. Let's wire the click of the flag to an event in Javascript. In the methods section of the `<script></script>` tags in the Vue file, implement the `markImportant()`. We want to wire this to the action to updateTodo, just like we have in the `markCompleted()` call above it. We also need to pass and additional property to this method call `imporant`
```javascript
    markImportant() {
      // TODO - FILL THIS OUT IN THE LAB EXERCISE
      this.$store.dispatch("updateTodo", {id: this.todoItem._id, important: true});
      console.info("INFO - Mark todo as important ", this.todoItem.important);
    },
```

3. Finally - let's connect the click button in the DOM to the Javascript function we've just created. In the template, add a click handler to the md-button to call the function `markImportant()` by adding ` @click="markImportant()"` to the `<md-button> tag 
```html
    <!-- TODO - SVG for use in Lab3 -->
    <md-button class="important-flag" @click="markImportant()">
        <svg :class="{'red-flag': todoItem.important}"  height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" ><path d="M0 0h24v24H0z" fill="none"/><path d="M14.4 6L14 4H5v17h2v-7h5.6l.4 2h7V6z"/></svg>
    </md-button>
```

3. The previously failing tests should have started to pass now. With this work done, let's commit our code. On the terminal, run 
```bash
$ git add .
$ git commit -m "Implementing the todoitem flag"
$ git push
```

3. If we try to use our important flag, we should see it's still not behaving as expected; this is because we're not updating the state of the app in response to the click event. We need to implement the `actions` and `mutations` for our feature. Let's start with the tests. Open the `tests/unit/javascript/actions.spec.js` and navigate to the bottom of the file. Our action should should commit the `MARK_TODO_IMPORTANT` to the mutations. Scroll to the end of the test file and implement the skeleton test by adding `expect(commit.firstCall.args[0]).toBe("MARK_TODO_IMPORTANT");` as the assertion.
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

3. We should now have more failing tests, let's fix this by adding the call from our action to the mutation method. Open the `src/store/actions.js` file and scroll to the bottom to the `updateTodo()` method. Complete the if block by adding `commit("MARK_TODO_IMPORTANT", i);` as shown below.
```javascript
updateTodo({ commit, state }, { id, important }) {
    let i = state.todos.findIndex(todo => todo._id === id);
    if (important) {
        // TODO - add commit imporant here!
        commit("MARK_TODO_IMPORTANT", i);
    } else {
        commit("MARK_TODO_COMPLETED", i);
    }
```

3. Finally, let's implement the `mutation` for our feature. Again, starting with the tests..... Open the `tests/unit/javascript/mutations.spec.js`. Our mutation method is responsible to toggling the todo's `important` property between true and 
false. Let's implement the tests for this functionality by setting imporant to be true and calling the method expecting the inverse and setting it to false and calling the method expecting the inverse. 
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

3. With our tests running and failing, let's implement the feature to their spec. Open the `src/store/mutations.js` and add another function called `MARK_TODO_IMPORTANT` below the `MARK_TODO_COMPLETED` to toggle `todo.important` between true and false.
```javascript
  MARK_TODO_IMPORTANT(state, index) {
    console.log("INFO - MARK_TODO_IMPORTANT");
    state.todos[index].important = !state.todos[index].important;
  }
```

3. All our tests should now be passing. On the watch tab where they are running, hit `u` to re-run all tests and update any snapshots.

3. With all our tests now passing, let's commit our code. On the terminal, run
```bash
$ git add .
$ git commit -m "Implementing the store and actions"
$ git push
```

3. Before running a build in Jenkins, let's add our tests and code to the develop branch
<p class="tip">
NOTE - At this point in a residency we would peer review the code before pushing it to develop or master branch!
</p>
```bash
$ git checkout develop
$ git merge feature/important-flag
$ git push --all
```

3. Run a build in Jenkins. We should see the test trend increase as we've added more tests. Validate the flag is working as expected.

#### Part 1c - Create todolist e2e tests

3.  TODO !!

---

## Extension Tasks

> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

* Add Auth to your application
* Do some other stuff

## Additional Reading

> List of links or other reading that might be of use / reference for the exercise

## Slide links

> link back to the deck for the supporting material
