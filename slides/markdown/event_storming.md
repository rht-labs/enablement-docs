<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Event Storming <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



### Event Storming
#### _What is It?_
* Provides a repeatable, teachable technique for modeling:
  * Event-driven systems
  * Large microservice-based systems
* Requires a really, really large modeling surface
* Requires lots of stickies in a rainbow of colors with a legend to their usage



### Event Storming
#### _What is It?_
* Who: key business stakeholders and techies
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
![Events](images/eventstorming/events.jpg) <!-- {_class="inline-image"} -->
Something that happened that people care about
* Subject --> Verb in past tense, e.g **Item Shipped**
* Could be timed, e.g. **Nightly Accounts Reconciled**
* A meaningful result of another thing, e.g. **Account Locked**



### Event Storming: Events
![Event](images/eventstorming/eventsticky.png) <!-- {_class="inline-image"} -->
Where do events come from?
* A system
* Passing of time
* Consequence of another event



### Event Storming: Commands
![Command](images/eventstorming/commandsticky.png) <!-- {_class="inline-image"} -->
* A **command** is an **action** started by an **actor**
* It represents the **decision**
* It is usually the reverse of the **event**, e.g:
  * Buy Ticket
  * Cancel Reservation



### Event Storming: Actors
![Actor](images/eventstorming/actorsticky.png) <!-- {_class="inline-image"} -->
An actor is the user of the system
* Keep it fuzzy, e.g. **Joe**
* The actor makes the decision



### Event Storming: Questions
![Question](images/eventstorming/questionsticky.png) <!-- {_class="inline-image"} -->
* Pain Points, e.g. **It takes a long time!**
* How / What / Why?
* Hot Spots
* Assumptions



### Event Storming: External Systems
![System](images/eventstorming/systemsticky.png) <!-- {_class="inline-image"} -->
* Third party services
* Existing systems



### Event Storming: Read Model
![ReadModel](images/eventstorming/readmodelsticky.png) <!-- {_class="inline-image"} -->
The **information** needed in order to make a **decision**
* Represents an implementation
  * Stored Procedure
  * Query
  * Projection
* Ties to the page layout



### Event Storming: Policies and Procedures
![PolicyProcedure](images/eventstorming/policysticky.png) <!-- {_class="inline-image"} -->
* Keywords to use are **always** and **immediately**
* Procedures include:
  * Automatic process
  * Process manager
  * Listener
  * "Don't forget to..."
  * Agreement
  * Rules
  * Habit
* For example:

  Refund Requested > Refund Policy > Issue Receipt



### Event Storming: Aggregate
![Aggregate](images/eventstorming/aggsticky.png) <!-- {_class="inline-image"} -->
Part of the system that **receives** the **command** and decides to **execute**
the **event**
* Usually a noun, e.g. **Item**
* The aggregate is the **state machine**
* Serve as a place to logically group commands once all event sources are identified



![System](images/eventstorming/system.jpg)



### Event Storming: Key Takeaways
* Builds a shared understanding of a problem space
* Models business processes
* Aggregate modeling to find key microservices and event model
* Models the flow of pages in an application
* Aligns stakeholders and IT groups



### Exercise
### Event Storm for To Do List Management
![Key](images/eventstorming/key.png) <!-- {_class="inline-image"} -->
* In your teams, create example event storm for the Current state of the To Do List
Management application. Cover the following things:
  1. Add the new Events
  * Add the new Commands, Users and Read Models
  * Are there new Systems or Aggregates?
* Reflect on your Impact Map deliverables and enhance it with some new functionality e.g
  1. Sharing lists between users
  2. Integration with other vendors or providers



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Event Storming](https://openpracticelibrary.com/practice/event-storming/)
