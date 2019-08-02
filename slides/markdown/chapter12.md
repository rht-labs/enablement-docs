<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Automated Testing Part 1 <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!-- .slide: id="tdd" -->
## Test Driven Development



### Test Driven Development
#### _What Is It?_
Test Driven Development (TDD) is a software development process that relies on
the repetition of a very short development cycle.
Requirements are turned into test cases, where the software is developed to pass
the tests.

This practice is particularly powerful when combined with
**Continuous Integration**.



### Test Driven Development
#### _How Does It Help?_
* Creates a detailed specification for the code
* Gives fast feedback
* Indicates whether the last change has broken previously working code
* Allows the design to evolve and adapt as understanding of the problem evolves



![TDD](images/tdd/TDD_Lifecycle.png)



<!-- .slide: id="revenge-automated-testing" -->
## Revenge of the Automated Testing
### Part 1



### Lab Exercise 3: Revenge of the Automated Testing
This lab helps us:
* Understand the "why" behind Test Driven Development (TDD)
* Implement a feature using TDD for the front end and back end of the application
* Write end-to-end tests for a feature and run them through continuous integration



### What new Tools and Frameworks will we use?
* **Jest**: zero configuration testing platform to test JavaScript code
* **Vue Test Utils**: the official testing utility library for Vue.js
* **Nightwatch.js**: easy to use Node.js based end-to-end testing solution for
browser based apps. It uses the powerful W3C WebDriver API to perform commands
and assertions on DOM elements
* **Mocha**: feature-rich JavaScript test framework running on Node.js and in
the browser, making asynchronous testing simple and fun
* **Sinon**: standalone test spies, stubs, and mocks for JavaScript. Works with
any unit testing framework



### The Big Picture
![BP3](images/tdd/bp-3-revenge-automated-testing.jpg)



### Let's Go!!!
Lab Exercise 3: _Revenge of the Automated Testing_
Part 1



<!-- .slide: id="revenge-automated-testing-part-2" -->
## Revenge of the Automated Testing
### Part 2
Test Driven Development (TDD) in LEGO

Credit to [Gargoyle Software](http://www.gargoylesoftware.com/ex/lego_tdd)



### Intent
Demonstrate the concepts behind TDD.

How we write the test before we write code and how that forces our design to emerge.



### TDD Lifecylce
![TDD-Simplified](https://i0.wp.com/s3.amazonaws.com/production-wordpress-assets/blog/wp-content/uploads/2017/04/11100523/TDD.jpg?zoom=2&fit=400%2C237&ssl=1)

Red - Write a small test that fails <!-- {_class="fragment"  data-fragment-index="1"} -->

Green - Do the minimum to make the test pass <!-- {_class="fragment"  data-fragment-index="2"} -->

Refactor - Eliminate duplication & make it beautiful <!-- {_class="fragment"  data-fragment-index="3"} -->



### Prepare your environment
Our program is made of Lego. Get your equipment ready for coding
![lego-space](https://media.gizmodo.co.uk/wp-content/uploads/2018/09/lego-620x349.jpg)



### 2 Simple Rules for Lego TDD
KISS - Keep It Simple Stupid  <!-- {_class="fragment"  data-fragment-index="1"} -->

YAGNI - You Ain't Gonna Need It!  <!-- {_class="fragment"  data-fragment-index="2"} -->

![simple-house](http://hometimes.co.za/wp-content/uploads/2017/06/Simple-Lego-home.jpg)  <!-- {_class="fragment"  data-fragment-index="1" style="height:250px"} -->
![complex-house](http://www.abc.net.au/news/image/7370406-3x2-940x627.jpg)  <!-- {_class="fragment" style="height:250px"  data-fragment-index="2"} -->



### Pair Builds
![pairs](https://i.ebayimg.com/images/g/pfgAAOSw3NtbJ57f/s-l1600.jpg) <!-- {_class="" style="height:450px"} -->



### The Steps
1. One person in the pair will write a test, in the form of a question, on a sticky note and place it on the table. For example "Is there a person?" <!-- {_class="fragment"  data-fragment-index="1"} -->
2. The other person will then implement something in LEGO that passes that test<!-- {_class="fragment"  data-fragment-index="2"} -->
3. When the first person is satisfied that the test is passing, they switch positions.<!-- {_class="fragment"  data-fragment-index="3"} -->
4. Now the second person writes a test and puts it on the table and the first person implements in LEGO. <!-- {_class="fragment"  data-fragment-index="4"} -->



### Some example tests

![TDD](images/tdd/lego-tdd-1.jpg) <!-- {_class="inline-image"} -->
- Is there a person in the program?
- Is there a house in the program? <!-- {_class="fragment"  data-fragment-index="1"} -->
- Is there a window on a wall of the house?<!-- {_class="fragment"  data-fragment-index="2"} -->
- Is it true that the house is taller than the person? <!-- {_class="fragment"  data-fragment-index="3"} -->
- The house is wider than the person? <!-- {_class="fragment"  data-fragment-index="3"} -->
- Is it true that the house has 2 connected walls <!-- {_class="fragment"  data-fragment-index="4"} -->
- Can the person enter the house? <!-- {_class="fragment"  data-fragment-index="5"} -->



### The Game Begins!

 - The business requirement is to include the following in our program:
       1. a person
       2. an animal
       3. a plant
       4. a vehicle
       5. a building.
 - There may only be one "broken" test at a time. All previous tests must continue to pass.  <!-- {_class="fragment"  data-fragment-index="1"} -->
 - Nothing must be built in LEGO if there wasn't a failing test that forced that to exist. <!-- {_class="fragment"  data-fragment-index="2"} -->
 - After each test is passing, the people switch roles. <!-- {_class="fragment"  data-fragment-index="4"} -->



### Debrief
<!-- speaker info
Sometimes people will build something new that breaks an existing test and they either won't have noticed or won't have cared. If this is the case then discuss why tests must always be passing.

Generally not everyone will have done this. They'll be so busy creating interesting requirements that they don't have time to build the five things that the customer actually asked for. Discuss this.

Have each pair demo two or three of their features. Have them read out the test first and then point out how that was implemented in their model. Stress the fact that if there isn't a test for a given feature, we don't care about it.
Many times people will have built cool things that they didn't have tests for. We stress again that in TDD, we don't build anything until the test has forced us to do that.

 -->
 - What did you observe? How did that feel?
 - Did everyone complete the five base requirements listed above?
 - Are all tests currently passing?



### Team Builds
![teams-at-work](https://www.businessdevelopmentcompany.co.nz/wp-content/uploads/2017/07/Being-a-team-member-768x510.jpg)



### The Game Begins Again!

![TDD](images/tdd/lego-tdd-2.png) <!-- {_class="inline-image" style="height:500px"} -->
 - As a table; Pick a project to build. Projects should be something complex that has lots of different kinds of things in it. Some examples if you're stuck could include _A Zoo_, _Shopping Center_, _a spaceship_ or _a city_.
 - All tests at the table must continue to pass at all times, regardless of which pair wrote them.  <!-- {_class="fragment"  data-fragment-index="1"} -->
 - This time is that the implementation has to be integrated with the main project in the center of the table. <!-- {_class="fragment"  data-fragment-index="2"} -->



### Debrief

<!-- Speaker notes

What did you observe?
A wide open question like this will often bring out observations we didn't anticipate.
Look around your table. Are all the tests still passing? If not, discuss.
Often people will now realize that something is broken and they hadn't noticed. This can lead into a discussion of continuous integration servers.
Are there tests that you should have that are missing?
Once a team built a zoo and then didn't complete the fencing around the lion enclosure. Perhaps they'd needed a test to ensure the lions couldn't get out to eat all the other animals.
Did you have any conflicts where a new feature from one pair broke a test from another? What did you do about that?
Was your final design different than you expected? Discuss.
 -->
 - What did you observe?
 - Look around your table. Are all the tests still passing?
 - Are there tests that you should have that are missing?
 - Did you have any conflicts where a new feature from one pair broke a test from another? What did you do about that?
 - Was your final design different than you expected?



## A Little Competition



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Test Driven Development](https://openpracticelibrary.com/practice/test-driven-development/)



<!-- .slide: data-background-image="css/images/RH_Chapter_Title_Background2.png", class="white-style" -->
[Chapter 13, Automated Testing Part 2](chapter13.html)
