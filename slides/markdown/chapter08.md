<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Metric-Based Process Mapping <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



### Metric-Based Process Mapping
#### _What is It?_
* Heavily influenced by Karen Martin's work in this area
* Designed to view the detailed, micro picture and make tactical improvements with front line workers.
* The first generation comes from Toyota's "information and material flow"
as documented in [Lean Thinking](https://rht-labs.github.io/practice-library/practices/vsm-and-mbpm/#footnote-1)
and the second generation from [Learning to See](https://rht-labs.github.io/practice-library/practices/vsm-and-mbpm/#footnote-2).



### MBPM
#### _Why Use It?_
* Holistically analyze and optimize "brownfield" delivery processes, including everything from requirements definition, infrastructure provisioning and application development.
* Visually represent the way work flows through an organization
* Building a shared understanding throughout the various levels of an organization
how the work is actually done.
* Formulating specific, data driven improvement plans.



### Metric-Based Process Mapping: How To
#### Label the map
![Map Label](images/vsm/mbpmstep1.png)



### Metric-Based Process Mapping: How To
#### List functions involved in the process
![Swimlanes](images/vsm/mbpmstep2.png)



### Metric-Based Process Mapping: How To
#### Document all activities (steps)
![Steps](images/vsm/mbpmstep3.png) <!-- {_class="inline-image"} -->
* Fast iteration, clean up later
* Use 4 x 6 sticky notes
* Place sequentially in appropriate swimlane
* No branching logic
* Use verb/noun format
* Be clear and concise



### Metric-Based Process Mapping: How To
#### Number the activities (steps)
![Number the Steps](images/vsm/mbpmstep4.png)



### Metric-Based Process Mapping: How To
#### Metrics
![Metrics](images/vsm/mbpmstep5.png)



### Metric-Based Process Mapping
#### Step-Specific Lead Time vs. Process Time
![LeadTime](images/vsm/leadtime.png)



### Metric-Based Process Mapping
#### Metrics: Time
* Process Time (PT)
  * The time to actually do the work, if one is able to do it uninterrupted
  * Includes when specific to the task at hand:

    Touch, talk, read, and think time
* Lead Time (LT)
  * Elapsed time from the time work is made available until it is completed
  and passed on to the next person or department in the chain
  * Includes process



### Metric-Based Process Mapping
#### Metrics: Quality
* Percent complete and accurate
* Percent of time downstream customer can perform task without having to:
  * **Correct** information or material supplied
  * **Add** information that should have been supplied
  * **Clarify** information that should or could have been clearer



### Metric-Based Process Mapping: How To
#### Define the _Timeline Critical Path_
![Critical Path](images/vsm/mbpmstep6.png)



### Metric-Based Process Mapping: What Else To Do?
* Create the timeline
* Create summary metrics
* Identify improvement areas



### Suggested Metrics to Assess Before and After
* Frequency of deployments (more frequent is better)
* Lead time for new features: from ideation through delivery (shorter is better)
* Frequency of change failures (fewer changes are better)
* Mean-time-to-repair, MTTR (shorter recovery times are better)



### Exercise - TODO List MBPM (Assumptions)

* Guardrails are:
  * Start - Feature Complete and ready to commit
  * End - Feature deployed to Test env
* Manual handoff and jobs



### Exercise - TODO List MBPM (Setup)

![Swimlanes](images/vsm/mbpmstep2.png) <!-- {_class="inline-image"} -->
* What will you call your MBPM diagram?
* Who/What are your typical functions that do work in your process?



### Exercise - TODO List MBPM

![Metrics](images/vsm/mbpmstep5.png) <!-- {_class="inline-image"} -->
* PT = The time to actually do the work
* LT = Time from when the work is available until it reaches the next step
* % C&A = Percent of time downstream steps can complete without returning



### Exercise - Batch Processing
1. Break out into teams and experiment with batch processing using poker chips.
2. Follow the facilitator's instructions.

[The Penny Game](https://www.leanagiletraining.com/better-agile/agile-penny-game-rules/)



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### DevOps practices used in this section:
- [Metric-Based Processing Mapping](https://openpracticelibrary.com/practice/vsm-and-mbpm/)
