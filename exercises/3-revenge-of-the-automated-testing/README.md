# Exercise Title

> The purpose of this lab is to develop and validate a new feature; and to promote the assured feature to production. The user story for our new feature is as follows

---

## Learning Outcomes

As a learner you will be able to

* Do thing 1
* Do thing 2
* Do thing 3

## Tools and Frameworks

> Name of tool - short description and link to docs or website

1.  [Jenkins](https://jenkins.io/) - OpenSource build automation server; highly customisable through plugins
1.  [Ansible]() - blah blah ...

## Big Picture

This exercise begins cluster containing blah blah

---

## 10,000 Ft View

> This should contain the goal of the exercise; with enough information that advanced learners could use this to build the exercise without much guidance. The information here

| StoryID: DO421      | As a doer I want to mark todos as important so that I can keep track of and complete high prirority todos first |
| ------------------- | --------------------------------------------------------------------------------------------------------------- |
| Acceptance Criteria |

priority:
should be doable with a single click
should add a red flag against the todo when marked important
should remove the red colour flag on the flag when important removed
should not affect existing todos
On page load:
should display existing todos that are not marked important
should display existing todos that are marked important with an red flag

## Step by Step Instructions

> This is a fairly structured guide with references to exact filenames and sections of text to be added. Include pictures and code snippets where appropriate. Rule of thumb is learners are dumb.... so over describe _why_ we're doing things

### Part 1 - Tests in our Pipeline

> _In this exercise we will improve the pipeline created already by adding some unit tests for the frontend & backend along with some end to end tests (e2e) to validate the full solution_

#### Part 1a - Unit tests

2.  TODO - show tests running locally etc (fe and api)

3.  TODO - add tests to jenkins with screenshots etc.

#### Part 1b - End to End tests (e2e)

2.  Add new part to the dev pipeline (`dev-todolist-fe-e2e`)

3.  Add tests and reports to Jenkins

### Part 2 - Our App's new feature

> _In this exercise we will introduce a new feature to create an important flag on the todos. In order to be able to build and test our feature we will use TDD_

// TODO - OUR USER STORY SHOULD GO HERE !

#### Part 1a - Create todolist-api tests

> Using [Mocha](https://mochajs.org/) as our test runner; we will now write some tests for backend functionality to persist our important-flag

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
    * `describe` is used to group tests together into a collection asserting some feature; for example the get all todos api.
    * `it` is an individual test statement and should contain an `expect` or a `should` statement asserting behaviour of the API under test.
    * `request` is a library for making http calls to the api.
    * `.expect(200)` asserts the HTTP Return Code
    * `res.body.should.be.instanceof(Array);` is the actual test call
    * `done();` tells the test runner that `mocha` has finished execution. This is needed as the http calls are asynchronous.

4. With this knowledge; let's implement our test for the `important` flag. We expect the fronted to introduce a new property on each `todo` that gets passed to the backend called `important`. The API will need to handle this new property and pass it into the mongodb. Let's begin implementing this functionality by writing our test case. Navigate to the `PUT /api/todos` section of the test which should be at the bottom ![todo-api-tests](../images/exercise3/todo-api-tests.png).

4. Before writing our test; let's first make sure all the existing tests are passing. 
```bash 
$ npm run test
```

4. With all the tests passing; let's add our new one. For ease of completing this exercise a template of a new test has been written at the very end of the file. A PUT request responds in our API with the data that it just updated, so provided that MongoDB accepted the change, it will respond with an object that has the `important` property on it. To write our test; edit the `it("should ....", function(done) {` by completing the following:
    * Edit the `it("should ...")` to describe the imporant flag we're testing
    * Edit the `.send()` to include `important: true` property
    * Add a new test assertion to check that `res.body.important` is `true` below the `// YOUR TEST GO HERE` line.
```javascript
  it("should mark todo as important and persist it", function(done) {
    request(app)
      .put("/api/todos/" + todoId)
      .send({ title: "LOVE endpoint/server side testing!", completed: true, important: true })
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

4. Run your test. It should fail. 
```bash 
$ npm run test
```
![fail-mocha](../images/exercise3/fail-mocha.png)

4. With our test now failing; let's implement the feature. This is quite a simple change; all we need to do it update the `server/api/todo/todo.model.js` to allow an additional property on the schema called `important` of type Boolean. 
```javascript
const TodoSchema = new Schema({
    title: String,
    completed: Boolean,
    important: Boolean
});
```

4. With your changes to the Database schema updated; re-run your tests.
```bash 
$ npm run test
```

4. Commit your code to the `feature/important-flag` branch and then merge onto the `develop` branch as follows
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

3.  Create a new branch in your `todolist-fe` app for our feature and push it to the remote

```bash
$ git checkout -b feature/important-flag
$ git push -u origin feature/important-flag
```

#### Part 1c - Create todolist e2e tests

3.  TODO

---

## Extension Tasks

> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

* Add Auth to your application
* Do some other stuff

## Additional Reading

> List of links or other reading that might be of use / reference for the exercise

## Slide links

> link back to the deck for the supporting material
