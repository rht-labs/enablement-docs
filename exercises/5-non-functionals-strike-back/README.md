# The Non Functionals Strike back
> In this exercise we explore the non-functional side of testing. 
_____

## Learning Outcomes
As a learner you will be able to
- Create additional Jenkins stages to scan for security vulnerabilities in the Apps
- Assess test quiality by producing coveage reports as part of a build
- Improve code readability with linting
- Do some light performance testing to monitor throughput of APIs

## Tools and Frameworks
> Below is a collection of the frameworks that will be used in this lab

1. [eslint](https://eslint.org/) - ESLint is an open source JavaScript linting utility originally created by Nicholas C. Zakas in June 2013. Code linting is a type of static analysis that is frequently used to find problematic patterns or code that doesn’t adhere to certain style guidelines. There are code linters for most programming languages, and compilers sometimes incorporate linting into the compilation process.

## Big Picture
This exercise begins cluster containing blah blah

_____

## 10,000 Ft View
> This lesson will use the Exerisise 4's Zap Slave and Arachni scanner to improve the pipeline. Linting will be included in the build and code coverage too.

2. Add a parallel stage after the e2e tests on the front end to run OWASP Zap and Arachni against the deployed apps.

2. Add Code Coverage reporing to the build for gaining greater insight into test improvements.

2. Add `npm run lint:ci` to the Frontend and report the result using the Checkstyle Plugin in Jenkins.

2. Create a new Jenkins job to run some light performance testing against the API layer using the perf tests tasks.

## Step by Step Instructions
> This is a well structured guide with references to exact filenames and indications as to what should be done.

### Part 1 - Add Security scanning to the pipeline 
> _In this exercise the first of our non-functional testing is explored in the form of some security scanning_

2. Do thing using tool X.
2. Insert blah into `file1.txt`
```
export SOME_THING=biscuits
```
2. Open console and navigate to `New Item` and click it ![new-item](./images/new-item.png)

### Part 2 - Add Code Coverage & Linting to the pipeline
> _prefix of exercise and why we're doing it_

3. Do other things

_____

## Extension Tasks
> _Ideas for go-getters. Advanced topic for doers to get on with if they finish early. These will usually not have a solution and are provided for additional scope._

 - Add Black Duck or other package scanning tooling for our NodeJS app
 - Add Container Vulnerability scanning tooling to the pipeline

## Additional Reading
> List of links or other reading that might be of use / reference for the exercise

## Slide links
> link back to the deck for the supporting material