<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Int&eacute;gration, livraison et d&eacute;ploiement continus  <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!-- .slide: id="continuous-integration" -->
## Int&eacute;gration Continue



### Int&eacute;gration Continue
L'int&eacute;gration continue (**CI**) est une pratique de d&eacute;veloppement o&ugrave; les d&eacute;veloppeurs int&egrave;grent le code dans un r&eacute;f&eacute;rentiel partag&eacute; fr&eacute;quemment, 
de pr&eacute;f&eacute;rence plusieurs fois par jour

Ces actions sont r&eacute;p&eacute;t&eacute;es fr&eacute;quemment, ce qui garantit que la base de code peut **s'int&eacute;grer en continu**.



### Int&eacute;gration Continue
#### _Qu'est-ce que c'est ?_
* Les d&eacute;veloppeurs soumettent de **petites et fr&eacute;quentes modifications** au code source.
* Des &eacute;tapes de construction et de test **automatis&eacute;es sont ex&eacute;cut&eacute;es** pour garantir que le code fonctionne comme pr&eacute;vu.
* Les d&eacute;veloppeurs sont inform&eacute;s si quelque chose &eacute;choue et peuvent r&eacute;agir rapidement pour r&eacute;parer.
* Les tests et les &eacute;tapes de construction sont g&eacute;n&eacute;ralement ex&eacute;cut&eacute;s dans un serveur d'automatisation (Tekton, Jenkins, GitLab CI/CD, Apache Airflow...).



### Int&eacute;gration Continue
#### _Pourquoi l'utiliser ?_
* Les tests automatis&eacute;s r&eacute;duisent la charge de travail et am&eacute;liorent la qualit&eacute; des logiciels.
* Les petites modifications r&eacute;guli&egrave;res du code r&eacute;duisent le nombre de probl&egrave;mes d'int&eacute;gration.
* Les boucles de feedback rapides facilitent le d&eacute;marrage des nouveaux contributeurs.
* La livraison de logiciels fonctionnels par petits incr&eacute;ments est plus agr&eacute;able que d'attendre que quelqu'un teste manuellement un &eacute;norme projet. 



### Jenkins Pipeline
![Jenkins](images/cicd/pipeline.png)



### Tekton Pipelines
![Tekton](images/cicd/tekton.png)



<!-- .slide: id="continuous-delivery"-->
## Int&eacute;gration Continue



### Livraison continue
La livraison continue (**CD**) est une extension de l'int&eacute;gration continue puisqu'elle d&eacute;ploiement automatiquement toutes les modifications du code dans un environnement de test et/ou de production apr&egrave;s la phase de construction. . 



### Livraison continue
#### _WQu'est-ce que c'est ?_
* Une pratique de g&eacute;nie logiciel
* Chaque changement peut &ecirc;tre **potentiellement** pr&ecirc;t pour la mise en production.
* Les builds s'appuient sur la pratique de l'int&eacute;gration continue.
* Envisage d'automatiser la mise en production dans une zone de "d&eacute;monstration".
* G&eacute;n&eacute;ralement mis en œuvre avec un serveur d'automatisation tel que Jenkins ou Tekton.



### Livraison continue
#### _Pourquoi l'utiliser ?_
* L'automatisation r&eacute;duit le travail manuel n&eacute;cessaire pour effectuer une mise en production.
* Les cycles de feedback des ing&eacute;nieurs qualit&eacute;, des propri&eacute;taires de produits et des parties prenantes sont plus rapides.
* L'&eacute;quipe d'exploitation est plus heureuse
* Pr&eacute;pare la voie aux d&eacute;ploiements par bouton poussoir.



<!--.slide: id="continuous-deploymen" -->
## D&eacute;ploiement continu




### D&eacute;ploiement continu
Le d&eacute;ploiement continu (**CD**) est une strat&eacute;gie de publication de logiciels dans laquelle tout code engag&eacute; qui passe la phase de test automatis&eacute; est automatiquement publi&eacute; dans l'environnement de production, apportant des changements visibles pour les utilisateurs du logiciel.



### D&eacute;ploiement continu
#### _Qu'est-ce que c'est ?_
* Pratique du d&eacute;veloppement de logiciels
* L'&eacute;quipe de d&eacute;veloppement maintient le logiciel afin qu'il puisse &ecirc;tre mis en production &agrave; tout moment.
* S'appuie sur les pratiques d' **int&eacute;gration continue** et de **livraison continue**.
* L'orchestration de la configuration et du d&eacute;ploiement du logiciel fait partie du devoir de l'&eacute;quipe de d&eacute;veloppement de maintenir le logiciel en production.
l'obligation de l'&eacute;quipe de d&eacute;veloppement de maintenir le logiciel



### D&eacute;ploiement continu
#### _Pourquoi l'utiliser ?_
* L'&eacute;quipe maintient un code et une configuration d&eacute;ployables pour les nouvelles fonctionnalit&eacute;s.
* Retour rapide des utilisateurs finaux
* Les fonctionnalit&eacute;s peuvent &ecirc;tre d&eacute;ploy&eacute;es une fois termin&eacute;es
* Application de la bonne pratique de ***eveything as code**.
* L'orchestration de la configuration et du d&eacute;ploiement doit faire partie de l'automatisation.
* Permet des retours en arri&egrave;re rapides et la r&eacute;cup&eacute;ration des &eacute;checs.



### D&eacute;ploiement continu
#### _Comment faire ?_
* Collaborer &eacute;troitement avec toutes les personnes impliqu&eacute;es dans le d&eacute;ploiement et la livraison de logiciels
&agrave; la production
* Automatiser tout autant que possible
* Construire des "fonctionnalit&eacute;s &agrave; bascule" ou des "dark launches" pour permettre un retour en arri&egrave;re rapide si n&eacute;cessaire.
* Fournir une surveillance automatis&eacute;e ad&eacute;quate de l'application



<!-- .slide: id="pre-attack-pipelines-summary"-->
## R&eacute;sum&eacute;



<!-- .slide: id="pre-attack-pipelines-summary"-->
## R&eacute;sum&eacute;
#### R&eacute;capitulation
* **Continuous Integration**: Int&eacute;grer plusieurs changements dans un repo partag&eacute; et s'appuyer fortement sur les tests pour s'assurer que les changements et les commits fonctionnent et ont tous r&eacute;ussi (tests unitaires / qualit&eacute; du code / conduite du code).
* **Continuous Delivery**:  L'objectif est d'avoir un artefact op&eacute;rationnel pr&ecirc;t &agrave; &ecirc;tre d&eacute;ploy&eacute; &agrave; tout moment. Il s'appuie sur les tests et l'automatisation pour s'assurer qu'il a pass&eacute; tous les tests fonctionnels et peut &ecirc;tre d&eacute;ploy&eacute; manuellement (bouton poussoir).
* **Continuous Deployment/Release**: OUne &eacute;tape suppl&eacute;mentaire : maintenant que nous sommes sûrs qu'il est pr&ecirc;t &agrave; &ecirc;tre d&eacute;ploy&eacute; en production, nous pouvons nous appuyer sur des features toggle, dark launches ou d'autres strat&eacute;gies de d&eacute;ploiement pour le promouvoir dans d'autres environnements critiques d&egrave;s que possible.



## R&eacute;sum&eacute;
![Pipeline](images/cicd/cdcd.png)



<!-- .slide: id="attack-pipelines"-->
## L'attaque des pipelines



### Lab Exercice 2: L'attaque des pipelines
* Cet exercice consiste &agrave; cr&eacute;er un chemin vers la production, depuis le code source &agrave; une application en production
* Nous explorons l'exemple de l'application TO DO List
* Nous cr&eacute;ons un pipeline Jenkins pour construire et d&eacute;ployer notre code.
* En tant qu'apprenant, vous serez capable de :
  1. Construire et ex&eacute;cuter la pile compl&egrave;te de l'application TO DO List localement.
  2.  Cr&eacute;er un pipeline sans barri&egrave;re en utilisant l'interface utilisateur de Jenkins pour
  le backend et le frontend de l'application
  3. Ajouter des branches au pipeline pour cibler un espace de noms OpenShift sp&eacute;cifique.





### Pourquoi les pipelines sont-ils importants et en quoi sont-ils utiles ?
* Un chemin vers la production :
  * Met le produit dans les mains du client plus rapidement
  * Permet des d&eacute;ploiements transparents et r&eacute;p&eacute;tables.
  * L'utilisation d'une infrastructure plus proche de la production augmente l'assurance de la qualit&eacute;.
  * Le comportement "Nous l'avons d&eacute;j&agrave; fait" r&eacute;duit le risque de mise en production.
* Assurance : augmente la qualit&eacute; du code et supprime le besoin d'&eacute;quipes d&eacute;di&eacute;es au d&eacute;ploiement et &agrave; la gestion des versions.
et de gestion des versions
* Libert&eacute; : permet aux d&eacute;veloppeurs de s'approprier comment et quand le code est construit et exp&eacute;di&eacute;.
* Fiabilit&eacute; : les pipelines s'ex&eacute;cutent de la m&ecirc;me mani&egrave;re &agrave; chaque fois qu'ils sont ex&eacute;cut&eacute;s.



### Quels nouveaux outils et cadres de travail utiliserons-nous ?
* **Jenkins** : Serveur d'automatisation de construction open source qui est hautement personnalisable
via des plugins.
**Node.js** : Node.js(R) est un moteur d'ex&eacute;cution JavaScript bas&eacute; sur le moteur JavaScript V8 de Chrome.
de Chrome. Il utilise un mod&egrave;le d'E/S non bloquant et pilot&eacute; par les &eacute;v&eacute;nements qui le rend l&eacute;ger et efficace.
**MongoDB** : Une base de donn&eacute;es NOSQL documents JSON offrant une flexibilit&eacute; aux structures de donn&eacute;es.
**VueJS** : Un framework progressif pour la construction d'interfaces utilisateur connues sous le nom d'applications single-page d'applications.


### La vue d'ensemble
![BP2](images/cicd/bp-2-attack-pipelines.jpg)



### C'est parti ! !!
Lab Exercice 2: _L'attaque des pipelines_



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### Les pratiques DevOps utilis&eacute;es dans cette section:
- [Continuous Integration](https://openpracticelibrary.com/practice/continuous-integration)
- [Continuous Delivery](https://openpracticelibrary.com/practice/continuous-delivery)
- [Continuous Deployment](https://openpracticelibrary.com/practice/continuous-deployment)
