<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Configuration as Code <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!--.slide: id="config-as-code" -->
## Configuration As Code



### Configuration logicielle traditionnelle
1. Installez manuellement le système d'exploitation.
2. Installez manuellement les paquets de logiciels nécessaires.
3. Modifier manuellement les fichiers de configuration des logiciels.
4. ...



### Configuration As Code
1. Select automated tools for provisioning and configuration.
   * Ansible, Chef, Puppet, etc.
   * OpenStack, AWS CLI, Terraform, etc.
2. Write installation and configuration sequences as code.
3. Design configuration options as templates.
4. Check source configuration code into a source control repository.
5. Use the automated tools to apply your configs.



### Configuration As Code
#### _Bénéfices__
* Autorité centrale pour la configuration
* Disponible via le système de contrôle des sources
  * Traçabilité
  * Historique et dérives
* Détection et correction des dérives de configuration
  * Empêche les changements de configuration non désirés
  * Plus de serveurs Snowflake
* Serveur Phoenix : brûlez tout et remettez tout exactement comme avant ! Exactement comme il était !



### Everything As Code
La pratique de **Everything as Code** va encore plus loin que la configuration en tant que code. Toutes les étapes manuelles doivent être scriptées, automatisées et vérifiées dans un système de gestion de source.



<!--.slide: id="manual-menace" -->
## La menace manuelle



### Lab Exercice 1: La menace manuelle
* This exercise is all about automation and **configuration-as-code**.
* This exercise is aimed at the creation of the supporting tooling that will be
used to support the rest of the exercises using code.
* The high level goal is to create a collection of project namespaces and
populate them with Git, Jenkins, and Nexus using code.
* As a learner, you will be able to:
  1. Run the [openshift-applier](https://github.com/redhat-cop/openshift-applier/)
  to automate creating cluster content.
  2. Create and administer project namespaces in OpenShift.
  3. Deploy commonly used applications to support the development process.

* Cet exercice porte sur l'automatisation et la **configuration-as-code**.
* Cet exercice est axé sur la création de l'outil d'aide qui sera utilisé pour faciliter le reste des exercices en utilisant du code.
* L'objectif final est de créer une collection de projets/namespaces et de les alimnenter avec Git, Jenkins et Nexus en utilisant du code.
* En tant qu'apprenant, vous serez en mesure de :
  1. Exécuter l'application [openshift-applier](https://github.com/redhat-cop/openshift-applier/)  pour automatiser la création de contenu de cluster.
  2. Créer et administrer des namespaces/projets dans OpenShift.
  3. Déployer des applications couramment utilisées pour soutenir le processus de développement.




![AnsibleEngine](images/PairAndMob/ansible.png)



![OpenShift](images/PairAndMob/openshift.png)



### Quels sont les nouveaux outils et frameworks que nous utiliserons ?
* **OpenShift Container Platform**: La plateforme de déploiement et d'hébergement d'applications cloud de Red Hat
* **GitLab**: Serveur Git géré par la communauté, désormais doté d'une chaîne d'outils DevOps intégrée.
* **Nexus**: Gestionnaire de référentiel pour le stockage de nombreux types d'applications.
  *  Peut héberger des dépôts de npm et de conteneurs
* **Jenkins**: Serveur d'automatisation de construction open source qui est hautement personnalisable avec des plugins.
* **Ansible**: Outil d'automatisation informatique de Red Hat utilisé pour provisionner et gérer l'état de l'infrastructure physique et du cloud.
* **openshift-applier**: Un ensemble de playbooks/rôles Ansible pour appliquer les objets OpenShift à un cluster OpenShift



## La vue d'ensemble
![BP1](images/bp-1-manual-menace.jpg)



## Vérifiez l'environnement de votre lab


### C'est parti ! !!
Lab Exercice 1: _La menace manuelle_



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### Pratiques DevOps utilisées dans cette section :
- [Everything As Code](https://openpracticelibrary.com/practice/everything-as-code/)
