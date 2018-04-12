# Exercise Title

> The purpose of this lab is to develop and validate a new feature; and to promote the assured feature to production. The user story for our new feature is as follows
_____

## Learning Outcomes
As a learner you will be able to
- Do thing 1
- Do thing 2
- Do thing 3

## Tools and Frameworks
> Name of tool - short description and link to docs or website

1. [Jenkins](https://jenkins.io/) - OpenSource build automation server; highly customisable through plugins
1. [Ansible]() - blah blah ...

## Big Picture
This exercise begins cluster containing blah blah

_____

## 10,000 Ft View
> This should contain the goal of the exercise; with enough information that advanced learners could use this to build the exercise without much guidance. The information here

StoryID: DO421 | As a doer I want to mark todos as high priority so that I can keep track of and complete important todos first  On changing a todos
-------------  | -------------
Acceptance Criteria | 
priority: 
    should be doable with a single click
    should add a red flag against the todo when marked high-priority
    should remove the red colour flag on the flag when high-priority removed
    should not affect existing todos
On page load: 
    should display existing todos that are not marked high-priority 
    should display existing todos that are marked high-priority with an red flag

## Step by Step Instructions
> This is a fairly structured guide with references to exact filenames and sections of text to be added. Include pictures and code snippets where appropriate. Rule of thumb is learners are dumb.... so over describe _why_ we're doing things

### Part 1 - Tests in our Pipeline 
> _In this exercise we will improve the pipeline created already by adding some unit tests for the frontend & backend along with some end to end tests (e2e) to validate the full solution_

#### Part 1a - Unit tests

2. TODO - show tests running locally etc (fe and api)

2. TODO - add tests to jenkins with screenshots etc.

#### Part 1b - End to End tests (e2e)

2. Add new part to the dev pipeline (`dev-todolist-fe-e2e`)

2. Add tests and reports to Jenkins

### Part 2 - Our App's new feature
> _In this exercise we will introduce a new feature to create an important flag on the todos. In order to be able to build and test our feature we will use TDD_

// TODO - OUR USER STORY SHOULD GO HERE !

#### Part 1a - Create todolist-fe tests

3. Create a new branch in your `todolist-fe` app for our feature and push it to the remote
```bash
$ git checkout -b feature/important-flag
$ git push -u origin feature/important-flag
```

#### Part 1b - Create todolist-api tests

3. TODO

#### Part 1c - Create todolist e2e tests

3. TODO

_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

 - Add Auth to your application
 - Do some other stuff

## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

## Slide links
> link back to the deck for the supporting material