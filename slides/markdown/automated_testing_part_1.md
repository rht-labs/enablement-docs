<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### DDD, BDD & TDD <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!-- .slide: id="ddd" -->
## Domain Driven Design



### Domain Driven Design
#### _Qu'est ce que le DDD ? _
Domain-driven design (DDD) est une approche de développement logiciels pour des besoins 
complexes en reliant profondément l'implémentation à un modèle évolutif des principaux concepts 
fondamentaux de l'entreprise.


![DDD](images/tdd/ddd.png)



### Domain Driven Design
#### _Comment cela peut-il aider ? _
* En plaçant la priorité du projet sur le coeur et la logique du domaine.
* Baser les conceptions complexes sur un modèle du domaine.
* Initier une collaboration créative entre les experts techniques et les experts du domaine pour affiner de manière itérative un modèle conceptuel qui répond aux besoins métier. 
* Combler le fossé entre les experts du domaine et les développeurs en utilisant le même langage pour créer la même compréhension. 
pour créer la même compréhension



<!-- .slide: id="bdd" -->
## Behavior Driven Development



### Behavior Driven Development
#### _Qu'est ce que le BDD_
Behavior-Driven Development (BDD) c'est d'abord tester. Cette pratique de test Agile fournit une qualité intégrée en définissant (et potentiellement en automatisant) les tests  avant, ou dans le cadre de la spécification du comportement du système. 



![BDD](images/tdd/bdd.jpg)



### Behavior Driven Development
####  _Comment cela peut-il aider ? _
* Créer une compréhension partagée des exigences entre le métier et les équipes Agile
* Aide à guider le développement, à réduire le retravail et à augmenter la vélocité.
* Crée des scénarios orientés business qui tentent de décrire le comportement d'une histoire, d'une fonctionnalité ou d'une capacité d'un point de vue de l'utilisateur. 




<!-- .slide: id="tdd" -->
## Test Driven Development



### Test Driven Development
#### _Qu'est ce que le TDD_
Test Driven Development (TDD) iest un processus de développement logiciel qui repose sur
la répétition d'un cycle de développement très court.
Les exigences sont transformées en cas de test, et le logiciel est développé pour passer les tests.
les tests.

Cette pratique est particulièrement puissante lorsqu'elle est combinée avec
**Intégration continue**.



![TDD](images/tdd/tdd.jpg)



### Test Driven Development
####  _Comment cela peut-il aider ? _
* Crée une spécification détaillée pour le code
* Donne un retour rapide
* Indique si la dernière modification a cassé le code qui fonctionnait auparavant.
* Permet à la conception d'évoluer et de s'adapter à mesure que la compréhension du problème évolue.



![TDD](images/tdd/TDD_Lifecycle.png)



### DDD & BDD & TDD
![TDD](images/tdd/ddd-bdd-tdd.jpg)



<!-- .slide: id="revenge-automated-testing" -->
## La revanche des tests automatisés
### Partie 1



### Lab Exercice 3: La revanche des tests automatisés
Ce lab nous aide à :
* Comprendre le "pourquoi" du développement piloté par les tests (TDD).
* Implémenter une fonctionnalité en utilisant TDD pour le front-end et le back-end de l'application.
* Écrire des tests de bout en bout pour une fonctionnalité et les exécuter par intégration continue.



### Quels sont les nouveaux outils et Frameworks que nous utiliserons ?
* **Jest** : plateforme de test sans configuration pour tester le code JavaScript.
* **Vue Test Utils** : la bibliothèque officielle d'utilitaires de test pour Vue.js.
* **Nightwatch.js** : solution de test de bout en bout basée sur Node.js et facile à utiliser pour les applications web. Utilise la puissante API W3C WebDriver pour exécuter des commandes et des assertions sur les éléments DOM.
**Mocha** : Framework de test JavaScript riche en fonctionnalités fonctionnant sur Node.js et dans le navigateur  rendant les tests asynchrones simples et amusants.
* **Sinon**: outil standlone de spies, stubs, and mocks test pour JavaScript. Fonctionne avec beaucoup de Frameworks de test.


### La vue d'ensemble
![BP3](images/tdd/bp-3-revenge-automated-testing.jpg)



### C'est parti!!!
Lab Exercice 3: _La revanche des tests automatisés_
Part 1



<!-- .slide: id="revenge-automated-testing-part-2" -->
## La revanche des tests automatisés
### Part 2
Test Driven Development (TDD) en LEGO

De [Gargoyle Software](http://www.gargoylesoftware.com/ex/lego_tdd)



### Enjeux
Démontrer les concepts derrière TDD.

Comment nous écrivons le test avant d'écrire le code et comment cela force notre conception à émerger.



### TDD cycle de vie
![TDD-Simplifié](https://i0.wp.com/s3.amazonaws.com/production-wordpress-assets/blog/wp-content/uploads/2017/04/11100523/TDD.jpg?zoom=2&fit=400%2C237&ssl=1)

Rouge - Ecrire un petit test qui échoue s <!-- {_class="fragment" style="color: red" data-fragment-index="1"} -->

Vert - Faire le minimum pour que le test soit réussi.  <!-- {_class="fragment" style="color: green" data-fragment-index="2"} -->

Refactor - Éliminez les duplications et embellissez le tout.  <!-- {_class="fragment" data-fragment-index="3"} -->



### TDD cycle de vie
![Le cercle de la vie](https://media.giphy.com/media/DvMHwFYLVHlZe/giphy.gif)  <!-- {_class="" style="height:450px"} -->



### Préparez votre environnement
Notre programme est fait de Lego. Préparez votre équipement pour le codage
![lego-space](images/tdd/lego-620x349.jpg)



### 2 Règles simples pour le TDD en Lego
KISS - Keep It Simple Stupid  <!-- {_class="fragment"  data-fragment-index="1"} -->

YAGNI - You Ain't Gonna Need It!  <!-- {_class="fragment"  data-fragment-index="2"} -->

![simple-house](images/Simple-Lego-home.jpg)  <!-- {_class="fragment"  data-fragment-index="1" style="height:250px"} -->
![complex-house](http://www.abc.net.au/news/image/7370406-3x2-940x627.jpg)  <!-- {_class="fragment" style="height:250px"  data-fragment-index="2"} -->



### Constructions des binômes
![paires](https://i.ebayimg.com/images/g/pfgAAOSw3NtbJ57f/s-l1600.jpg) <!-- {_class="" style="height:450px"} -->



### Les étapes
1. Une personne du binôme écrit un test, sous forme de question, sur une note autocollante et la place sur la table. Par exemple : "Y a-t-il une personne ?". <!-- {_class="fragment"  data-fragment-index="1"} -->
2. L'autre personne implémentera ensuite quelque chose en LEGO qui passe ce test. <!-- {_class="fragment" data-fragment-index="2"} -->
3. Lorsque la première personne est satisfaite et de la réussite du test, elle change de position. <!-- {_class="fragment" data-fragment-index="3"} -->
4. Maintenant, la deuxième personne écrit un test et le pose sur la table et la première personne le met en œuvre en LEGO. <!-- {_class="fragment" data-fragment-index="4"} -->



### Quelques exemples de tests

![TDD](images/tdd/lego-tdd-1.jpg) <!-- {_class="inline-image"} -->
- Y a-t-il une personne dans le programme ?  <!-- {_class="fragment" data-fragment-index="1"} -->
- Y a-t-il une maison dans le programme ? <!-- {_class="fragment" data-fragment-index="2"} -->
- Y a-t-il une fenêtre sur un mur de la maison ? <!-- {_class="fragment" data-fragment-index="3"} -->
- Est-il vrai que la maison est plus grande que la personne ?  <!-- {_class="fragment" data-fragment-index="4"} -->
- La maison est plus large que la personne ?  <!-- {_class="fragment" data-fragment-index="5"} -->
- Est-il vrai que la maison a 2 murs reliés<!-- {_class="fragment" data-fragment-index="6"} -->
- la Personne peut-elle entrer dans la maison ? <!-- {_class="fragment" data-fragment-index="7"} -->



### Le jeu commence !

 - Le besoin métier est d'inclure les éléments suivants dans notre programme :
       1. une personne
       2. un animal
       3. une plante
       4. un véhicule
       5. un bâtiment.
-  Il ne peut y avoir qu'un seul test "cassé" à la fois. Tous les tests précédents doivent continuer à passer. <!-- {_class="fragment" data-fragment-index="1"} -->
- Rien ne doit être construit en LEGO s'il n'y avait pas un test défaillant qui a forcé cela à exister. <!-- {_class="fragment" data-fragment-index="2"} -->
- Après que chaque test soit passé, les gens changent de rôle. <!-- {_class="fragment" data-fragment-index="4"} -->



### Débriefing
<!-- speaker info
Sometimes people will build something new that breaks an existing test and they either won't have noticed or won't have cared. If this is the case then discuss why tests must always be passing.

Generally not everyone will have done this. They'll be so busy creating interesting requirements that they don't have time to build the five things that the customer actually asked for. Discuss this.

Have each pair demo two or three of their features. Have them read out the test first and then point out how that was implemented in their model. Stress the fact that if there isn't a test for a given feature, we don't care about it.
Many times people will have built cool things that they didn't have tests for. We stress again that in TDD, we don't build anything until the test has forced us to do that.
 -->
- Qu'avez-vous observé ? Qu'avez-vous ressenti ?
- Tout le monde a-t-il rempli les cinq exigences de base énumérées ci-dessus ?
- Tous les tests sont-ils actuellement réussis ?


### Constructions d'équipes
![teams-at-work](https://www.businessdevelopmentcompany.co.nz/wp-content/uploads/2017/07/Being-a-team-member-768x510.jpg)



### Le jeu recommence !

![TDD](images/tdd/lego-tdd-2.png) <!-- {_class="inline-image" style="height:500px"} -->
- Toute une table ; Choisissez un projet à construire. Les projets doivent être complexes et contenir plusieurs types de choses différentes. Si vous êtes bloqués, vous pouvez par exemple choisir _un zoo_, _un centre commercial_, _un vaisseau spatial_ ou _une ville_._.
- Tous les tests de la table doivent continuer à réussir à tout moment, quelle que soit la paire qui les a écrits. <!-- {_class="fragment" data-fragment-index="1"} -->
- Cette fois, c'est la mise en œuvre qui doit être intégrée au projet principal, au centre de la table.<!-- {_class="fragment" data-fragment-index="2"} -->



### Débriefing

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
 - Qu'avez-vous observé ?
 - Regardez autour de votre table. Tous les tests passent-ils encore ?
 - Y a-t-il des tests que vous devriez avoir et qui sont manquants ?
 - Avez-vous eu des conflits où une nouvelle fonctionnalité d'une binôme a cassé un test d'une autre binôme ? Qu'avez-vous fait à ce sujet ?
 - Votre conception finale était-elle différente de ce que vous aviez prévu ?



## Un peu de compétition



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### Pratiques DevOps utilisées dans cette section :
- [Test Driven Development](https://openpracticelibrary.com/practice/test-driven-development/)
- [Continuous Integration](https://openpracticelibrary.com/practice/continuous-integration/)
