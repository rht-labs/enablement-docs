<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### DDD, BDD & TDD <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!-- .slide: id="ddd" -->
## Domain Driven Design



### Domain Driven Design
#### _Qu'est ce que le DDD ? _
Domain-driven design (DDD) est une approche de d&eacute;veloppement logiciels pour des besoins 
complexes en reliant profond&eacute;ment l'impl&eacute;mentation &agrave; un mod&egrave;le &eacute;volutif des principaux concepts 
fondamentaux de l'entreprise.


![DDD](images/tdd/ddd.png)



### Domain Driven Design
#### _Comment cela peut-il aider ? _
* En pla&ccedil;ant la priorit&eacute; du projet sur le coeur et la logique du domaine.
* Baser les conceptions complexes sur un mod&egrave;le du domaine.
* Initier une collaboration cr&eacute;ative entre les experts techniques et les experts du domaine pour affiner de mani&egrave;re it&eacute;rative un mod&egrave;le conceptuel qui r&eacute;pond aux besoins m&eacute;tier. 
* Combler le foss&eacute; entre les experts du domaine et les d&eacute;veloppeurs en utilisant le m&ecirc;me langage pour cr&eacute;er la m&ecirc;me compr&eacute;hension. 
pour cr&eacute;er la m&ecirc;me compr&eacute;hension



<!-- .slide: id="bdd" -->
## Behavior Driven Development



### Behavior Driven Development
#### _Qu'est ce que le BDD?_
Behavior-Driven Development (BDD) c'est d'abord tester. Cette pratique de test Agile fournit une qualit&eacute; int&eacute;gr&eacute;e en d&eacute;finissant (et potentiellement en automatisant) les tests  avant, ou dans le cadre de la sp&eacute;cification du comportement du syst&egrave;me. 



![BDD](images/tdd/bdd.jpg)



### Behavior Driven Development
####  _Comment cela peut-il aider ? _
* Cr&eacute;er une compr&eacute;hension partag&eacute;e des exigences entre le m&eacute;tier et les &eacute;quipes Agile
* Aide &agrave; guider le d&eacute;veloppement, &agrave; r&eacute;duire le retravail et &agrave; augmenter la v&eacute;locit&eacute;.
* Cr&eacute;e des sc&eacute;narios orient&eacute;s business qui tentent de d&eacute;crire le comportement d'une histoire, d'une fonctionnalit&eacute; ou d'une capacit&eacute; d'un point de vue de l'utilisateur. 




<!-- .slide: id="tdd" -->
## Test Driven Development



### Test Driven Development
#### _Qu'est ce que le TDD_
Test Driven Development (TDD) iest un processus de d&eacute;veloppement logiciel qui repose sur
la r&eacute;p&eacute;tition d'un cycle de d&eacute;veloppement tr&egrave;s court.
Les exigences sont transform&eacute;es en cas de test, et le logiciel est d&eacute;velopp&eacute; pour passer les tests.
les tests.

Cette pratique est particuli&egrave;rement puissante lorsqu'elle est combin&eacute;e avec **Int&eacute;gration continue**.



![TDD](images/tdd/tdd.jpg)



### Test Driven Development
####  _Comment cela peut-il aider ? _
* Cr&eacute;e une sp&eacute;cification d&eacute;taill&eacute;e pour le code
* Donne un retour rapide
* Indique si la derni&egrave;re modification a cass&eacute; le code qui fonctionnait auparavant.
* Permet &agrave; la conception d'&eacute;voluer et de s'adapter &agrave; mesure que la compr&eacute;hension du probl&egrave;me &eacute;volue.



![TDD](images/tdd/TDD_Lifecycle.png)



### DDD & BDD & TDD
![TDD](images/tdd/ddd-bdd-tdd.jpg)



<!-- .slide: id="revenge-automated-testing" -->
## La revanche des tests automatis&eacute;s
### Partie 1



### Lab Exercice 3: La revanche des tests automatis&eacute;s
Ce lab nous aide &agrave; :
* Comprendre le "pourquoi" du d&eacute;veloppement pilot&eacute; par les tests (TDD).
* Impl&eacute;menter une fonctionnalit&eacute; en utilisant TDD pour le front-end et le back-end de l'application.
* &eacute;crire des tests de bout en bout pour une fonctionnalit&eacute; et les ex&eacute;cuter par int&eacute;gration continue.



### Quels sont les nouveaux outils et Frameworks que nous utiliserons ?
* **Jest** : plateforme de test sans configuration pour tester le code JavaScript.
* **Vue Test Utils** : la biblioth&egrave;que officielle d'utilitaires de test pour Vue.js.
* **Nightwatch.js** : solution de test de bout en bout bas&eacute;e sur Node.js et facile &agrave; utiliser pour les applications web. Utilise la puissante API W3C WebDriver pour ex&eacute;cuter des commandes et des assertions sur les &eacute;l&eacute;ments DOM.
**Mocha** : Framework de test JavaScript riche en fonctionnalit&eacute;s fonctionnant sur Node.js et dans le navigateur  rendant les tests asynchrones simples et amusants.
* **Sinon**: outil standlone de spies, stubs, and mocks test pour JavaScript. Fonctionne avec beaucoup de Frameworks de test.



### La vue d'ensemble
![BP3](images/tdd/bp-3-revenge-automated-testing.jpg)



### C'est parti!!!
Lab Exercice 3: _La revanche des tests automatis&eacute;s_
Part 1



<!-- .slide: id="revenge-automated-testing-part-2" -->
## La revanche des tests automatis&eacute;s
### Part 2
Test Driven Development (TDD) en LEGO

De [Gargoyle Software](http://www.gargoylesoftware.com/ex/lego_tdd)



### Enjeux
D&eacute;montrer les concepts derri&egrave;re TDD.

Comment nous &eacute;crivons le test avant d'&eacute;crire le code et comment cela force notre conception &agrave; &eacute;merger.



### TDD cycle de vie
![TDD-Simplifi&eacute;](https://i0.wp.com/s3.amazonaws.com/production-wordpress-assets/blog/wp-content/uploads/2017/04/11100523/TDD.jpg?zoom=2&fit=400%2C237&ssl=1)

Rouge - Ecrire un petit test qui &eacute;choue s <!-- {_class="fragment" style="color: red" data-fragment-index="1"} -->

Vert - Faire le minimum pour que le test soit r&eacute;ussi.  <!-- {_class="fragment" style="color: green" data-fragment-index="2"} -->

Refactor - &eacute;liminez les duplications et embellissez le tout.  <!-- {_class="fragment" data-fragment-index="3"} -->



### TDD cycle de vie
![Le cercle de la vie](https://media.giphy.com/media/DvMHwFYLVHlZe/giphy.gif)  <!-- {_class="" style="height:450px"} -->



### Pr&eacute;parez votre environnement
Notre programme est fait de Lego. Pr&eacute;parez votre &eacute;quipement pour le codage
![lego-space](images/tdd/lego-tdd-2.jpg)



### 2 R&egrave;gles simples pour le TDD en Lego
KISS - Keep It Simple Stupid  <!-- {_class="fragment"  data-fragment-index="1"} -->

YAGNI - You Ain't Gonna Need It!  <!-- {_class="fragment"  data-fragment-index="2"} -->

![simple-house](images/Simple-Lego-home.jpg)  <!-- {_class="fragment"  data-fragment-index="1" style="height:250px"} -->
![complex-house](http://www.abc.net.au/news/image/7370406-3x2-940x627.jpg)  <!-- {_class="fragment" style="height:250px"  data-fragment-index="2"} -->



### Constructions des bin&ocirc;mes
![paires](https://i.ebayimg.com/images/g/pfgAAOSw3NtbJ57f/s-l1600.jpg) <!-- {_class="" style="height:450px"} -->



### Les &eacute;tapes
1. Une personne du bin&ocirc;me &eacute;crit un test, sous forme de question, sur une note autocollante et la place sur la table. Par exemple : "Y a-t-il une personne ?". <!-- {_class="fragment"  data-fragment-index="1"} -->
2. L'autre personne impl&eacute;mentera ensuite quelque chose en LEGO qui passe ce test. <!-- {_class="fragment" data-fragment-index="2"} -->
3. Lorsque la premi&egrave;re personne est satisfaite et de la r&eacute;ussite du test, elle change de position. <!-- {_class="fragment" data-fragment-index="3"} -->
4. Maintenant, la deuxi&egrave;me personne &eacute;crit un test et le pose sur la table et la premi&egrave;re personne le met en oeuvre en LEGO. <!-- {_class="fragment" data-fragment-index="4"} -->



### Quelques exemples de tests

![TDD](images/tdd/lego-tdd-1.jpg) <!-- {_class="inline-image"} -->
- Y a-t-il une personne dans le programme ?  <!-- {_class="fragment" data-fragment-index="1"} -->
- Y a-t-il une maison dans le programme ? <!-- {_class="fragment" data-fragment-index="2"} -->
- Y a-t-il une fen&ecirc;tre sur un mur de la maison ? <!-- {_class="fragment" data-fragment-index="3"} -->
- Est-il vrai que la maison est plus grande que la personne ?  <!-- {_class="fragment" data-fragment-index="4"} -->
- La maison est plus large que la personne ?  <!-- {_class="fragment" data-fragment-index="5"} -->
- Est-il vrai que la maison a 2 murs reli&eacute;s<!-- {_class="fragment" data-fragment-index="6"} -->
- la Personne peut-elle entrer dans la maison ? <!-- {_class="fragment" data-fragment-index="7"} -->



### Le jeu commence !

 - Le besoin m&eacute;tier est d'inclure les &eacute;l&eacute;ments suivants dans notre programme :

   1. une personne
   2. un animal
   3. une plante
   4. un v&eacute;hicule
   5. un b&agrave;timent.
 
-  Il ne peut y avoir qu'un seul test "cass&eacute;" &agrave; la fois. Tous les tests pr&eacute;c&eacute;dents doivent continuer &agrave; passer. <!-- {_class="fragment" data-fragment-index="1"} -->
- Rien ne doit &ecirc;tre construit en LEGO s'il n'y avait pas un test d&eacute;faillant qui a forc&eacute; cela &agrave; exister. <!-- {_class="fragment" data-fragment-index="2"} -->
- Apr&egrave;s que chaque test soit pass&eacute;, les gens changent de r&ocirc;le. <!-- {_class="fragment" data-fragment-index="4"} -->



### D&eacute;briefing
<!-- speaker info
Sometimes people will build something new that breaks an existing test and they either won't have noticed or won't have cared. If this is the case then discuss why tests must always be passing.

Generally not everyone will have done this. They'll be so busy creating interesting requirements that they don't have time to build the five things that the customer actually asked for. Discuss this.

Have each pair demo two or three of their features. Have them read out the test first and then point out how that was implemented in their model. Stress the fact that if there isn't a test for a given feature, we don't care about it.
Many times people will have built cool things that they didn't have tests for. We stress again that in TDD, we don't build anything until the test has forced us to do that.
 -->
- Qu'avez-vous observ&eacute; ? Qu'avez-vous ressenti ?
- Tout le monde a-t-il rempli les cinq exigences de base &eacute;num&eacute;r&eacute;es ci-dessus ?
- Tous les tests sont-ils actuellement r&eacute;ussis ?


### Constructions d'&eacute;quipes
![teams-at-work](https://www.businessdevelopmentcompany.co.nz/wp-content/uploads/2017/07/Being-a-team-member-768x510.jpg)



### Le jeu recommence !

![TDD](images/tdd/lego-tdd-2.png) <!-- {_class="inline-image" style="height:500px"} -->
- Toute une table ; Choisissez un projet &agrave; construire. Les projets doivent &ecirc;tre complexes et contenir plusieurs types de choses diff&eacute;rentes. Si vous &ecirc;tes bloqu&eacute;s, vous pouvez par exemple choisir _un zoo_, _un centre commercial_, _un vaisseau spatial_ ou _une ville_.
- Tous les tests de la table doivent continuer &agrave; r&eacute;ussir &agrave; tout moment, quelle que soit la paire qui les a &eacute;crits. <!-- {_class="fragment" data-fragment-index="1"} -->
- Cette fois, c'est la mise en œuvre qui doit &ecirc;tre int&eacute;gr&eacute;e au projet principal, au centre de la table.<!-- {_class="fragment" data-fragment-index="2"} -->



### D&eacute;briefing

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
 - Qu'avez-vous observ&eacute; ?
 - Regardez autour de votre table. Tous les tests passent-ils encore ?
 - Y a-t-il des tests que vous devriez avoir et qui sont manquants ?
 - Avez-vous eu des conflits o&ugrave; une nouvelle fonctionnalit&eacute; d'une bin&ocirc;me a cass&eacute; un test d'une autre bin&ocirc;me ? Qu'avez-vous fait &agrave; ce sujet ?
 - Votre conception finale &eacute;tait-elle diff&eacute;rente de ce que vous aviez pr&eacute;vu ?



## Un peu de comp&eacute;tition



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### Pratiques DevOps utilis&eacute;es dans cette section :
- [Test Driven Development](https://openpracticelibrary.com/practice/test-driven-development/)
- [Continuous Integration](https://openpracticelibrary.com/practice/continuous-integration/)
