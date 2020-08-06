<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Event Storming <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



### Event Storming
#### _What is It?_
A rapid, interactive approach to business process discovery and design that yields high quality models



### Event Storming
#### _What do I need?_
* **Who**: Key business stakeholders and techies
* A really, really large modeling surface
* Lots of stickies in a rainbow of colors with a legend to their usage



### Event Storming
#### _Are there rules?_
* There will be lots of talking, a fair bit of squabbling, and periodically
some **very** heated debate
* No chairs!
* Expect a tiring but fun day that achieves a great deal from the most basic of tools



### Event Storming
#### _Where Did It Come From?_
![Brandolini](images/eventstorming/brandolini.jpg) <!-- {_class="inline-image" width="350"} -->
Event Storming was developed by Alberto Brandolini
* Brandolini has a background in event-driven systems
* He is an active member of the Domain-Driven Design (DDD) community
* He started Event Storming as a guest slot in Vernon Vaughn's DDD workshop
* First blog post about event storming was in 2013



### Event Storming
#### _Why Do We Use It?_
* Very simple modeling that is accessible to all business people
* Engages all stakeholders and removes technical barriers:
  * Non-technical people can actively contribute
  * Builds a shared understanding
  * Fail fast to solve difficult problems
  * Deliver really useful design artifacts
* Provides a repeatable, teachable technique for modeling:
  * Event-driven systems
  * Large microservice-based systems



### Event Storming
#### _Artifacts_
* **Big Picture**: quickly build a shared understanding of a problem space
* **Process Diagram**: model business processes
* **Aggregate Modeling**: find the key microservices, operations, and a retrospective
event model
* **UI Modeling**: model the flow of pages in an application



### Event Storming
#### _Tips for Success_
* Hold a Big Picture Workshop
* Invite the right people: business stakeholders, IT, and User Experience (UX)
* Provide unlimited modeling space with a surface, markers, and stickies
* Model **a whole business line** with domain events



## Event Storming Diagram



![System](images/eventstorming/system.jpg)



### Event Storming: Events
![Events](images/eventstorming/digital/eventsticky.png) <!-- {_class="inline-image"} -->
Something that happened in the business process that people care about
* "**Subject** --> **Verb** (in past tense)"
* A meaningful result of another thing
* Where do events come from?
 * A system
 * Passing of time
 * Consequence of another event
* Examples:
  * _"Item Shipped"_
  * _"Account Locked"_



### Event Storming: Commands
![Command](images/eventstorming/digital/commandsticky.png) <!-- {_class="inline-image"} -->
An action started by an actor or a previous event
* "**Verb** (in infinitive) --> **Subject**"
* It is usually the reverse of the **event**
* Examples:
  * _"Buy Ticket" (Event -> Ticket bought)_
  * _"Cancel Reservation" (Event -> Reservation canceled)_



### Event Storming: View
![Actor](images/eventstorming/digital/viewsticky.png) <!-- {_class="inline-image"} -->
An interface that actors interact with to carry out a task in the system
* Normally Forms (Examples: _"Login Page"_ or _"Sing up Form"_)



### Event Storming: Actor
![Actor](images/eventstorming/digital/actorsticky.png) <!-- {_class="inline-image"} -->
A user of the system who executes a command through a view
* Keep it fuzzy (Examples: _"Joe"_)
* The actor makes the decision



### Event Storming: Questions
![Question](images/eventstorming/digital/questionsticky.png) <!-- {_class="inline-image"} -->
Any doubt about the process
* Pain Points  (Examples: _"It takes a long time!"_)
* How / What / Why?
* Hot Spots
* Assumptions



### Event Storming: External Systems
![System](images/eventstorming/digital/systemsticky.png) <!-- {_class="inline-image"} -->
A third-party service provider which is affected by
commands
* Examples:
 * _Payment gateway_
 * _Shipping company_



### Event Storming: Read Model
![ReadModel](images/eventstorming/digital/readmodelsticky.png) <!-- {_class="inline-image"} -->
The information needed in order to make a decision
* Represents an implementation
  * Stored Procedure
  * Query
  * Projection
* Ties to the page layout



### Event Storming: Policies and Procedures
![PolicyProcedure](images/eventstorming/digital/policysticky.png) <!-- {_class="inline-image"} -->
An automated process, automated rule or aggredment wich is always applied inmediately after an event
* Procedures include:
 * Automatic process
 * Process manager
 * Listener
 * "Don't forget to..."
 * Agreement
 * Rules
 * Habit
* Examples:
 * Refund Requested > Refund Policy > Issue Receipt



### Event Storming: Aggregate
![Aggregate](images/eventstorming/digital/aggsticky.png) <!-- {_class="inline-image"} -->
Part of the system that receives the command and decides to execute
the event
* Usually a noun (Examples: _animals, cities, cars, plants..._)
* The aggregate is the **state machine**
* Serve as a place to logically group commands once all event sources are identified



![System](images/eventstorming/digital/systemstickies.png) <!-- {_class="custom-image"} -->



### Event Storming
#### _Key Takeaways_
* Builds a shared understanding of a problem space
* Models business processes
* Aggregate modeling to find key microservices and event model
* Models the flow of pages in an application
* Aligns stakeholders and IT groups



### Exercise - Event Storm for To Do List Management
![Key](images/eventstorming/key.png) <!-- {_class="inline-image"} -->
In your teams, create example event storm for the Current state of the To Do List
Management application

1. Add the new Events<!-- {_class="fragment"  data-fragment-index="1"} -->
3. Add the new Commands, Users and Read Models<!-- {_class="fragment"  data-fragment-index="2"} -->
2. Are there new Systems or Aggregates?<!-- {_class="fragment"  data-fragment-index="3"} -->
4. Reflect on your Impact Map deliverables and enhance it with some new functionality (Examples: Sharing lists between users or Integration with other vendors or providers)<!-- {_class="fragment"  data-fragment-index="4"} -->



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Event Storming](https://openpracticelibrary.com/practice/event-storming/)
