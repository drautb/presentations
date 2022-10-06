SWF Notes
=========

## What is SWF?

* A workflow engine. 
  - Well what does that mean? (Thoughts?)
* A framework for orchestrating a set of related tasks.
  - For example, the FamilySearch AWS platform is built on SWF.
  - We have a number of different services that our customers can use, and a different component of our system is responsible for standing up each type of service. We use SWF to orchestrate the work between the different components in order to create the overall system.

* Today we want to focus on SWF itself, so we're going to be working in the context of a pretty trivial example. 
  - Let's pretend that you work in an office with a virtual aquarium, and in this virtual aquarium, there is a solitary fish. At the moment, the fish happens to be blue, but anybody can make a request to change the color of the fish.
  - Right now, you have to file some paperwork, and then the keeper of the fish gets to decide whether or not to approve your request and change the color of the fish.
* How could you build a distributed system to automate this?
  - We could pretty easily put together a website that accepted requests, and then gave the keeper of the fish a list from which to approve or reject them. That wouldn't let us demo SWF though. :) 
  - Before we model an SWF solution for this, we need to learn a bit of vocab.

* Vocabulary.
  - Deciders and Activities are abstract concepts.
  - Decider and Activity Workers are threads that poll SWF for tasks, and then execute them.

* Going back to the fish example, what are the tasks?
  - Obtain Approval, and apply the change if it was approved.
  - Discuss architecture???

* Flow Framework for Java.
* Patterns for loops, branching, etc.
* 
