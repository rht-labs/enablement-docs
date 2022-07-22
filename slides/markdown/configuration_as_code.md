<!-- .slide: data-background-image="images/RH_NewBrand_Background.png" -->
## DevOps Culture and Practice <!-- {_class="course-title"} -->
### Configuration as Code <!-- {_class="title-color"} -->
DO500 <!-- {_class="title-color"} -->



<!--.slide: id="config-as-code" -->
## Configuration As Code



### Configuration logicielle traditionnelle
1. Installez manuellement le syst&egrave;me d'exploitation.
2. Installez manuellement les paquets de logiciels n&eacute;cessaires.
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
#### _B&eacute;n&eacute;fices_
* Autorit&eacute; centrale pour la configuration
* Disponible via le syst&egrave;me de contr&ocirc;le des sources
  * Tra&ccedil;abilit&eacute;
  * Historique et d&eacute;rives
* D&eacute;tection et correction des d&eacute;rives de configuration
  * Emp&ecirc;che les changements de configuration non d&eacute;sir&eacute;s
  * Plus de serveurs Snowflake
* Serveur Phoenix : brulez tout et remettez tout exactement comme avant ! Exactement comme il &eacute;tait !



### Everything As Code
La pratique de **Everything as Code** va encore plus loin que la configuration en tant que code. Toutes les &eacute;tapes manuelles doivent &ecirc;tre script&eacute;es, automatis&eacute;es et v&eacute;rifi&eacute;es dans un syst&egrave;me de gestion de source.



<!--.slide: id="manual-menace" -->
## La menace manuelle



### Lab Exercice 1: La menace manuelle
* Cet exercice porte sur l'automatisation et la **configuration-as-code**.
* Cet exercice est ax&eacute; sur la cr&eacute;ation de l'outil d'aide qui sera utilis&eacute; pour faciliter le reste des exercices en utilisant du code.
* L'objectif final est de cr&eacute;er une collection de projets/namespaces et de les alimnenter avec Git, Jenkins et Nexus en utilisant du code.
* En tant qu'apprenant, vous serez en mesure de :
  1. Ex&eacute;cuter l'application [openshift-applier](https://github.com/redhat-cop/openshift-applier/)  pour automatiser la cr&eacute;ation de contenu de cluster.
  2. Cr&eacute;er et administrer des namespaces/projets dans OpenShift.
  3. D&eacute;ployer des applications couramment utilis&eacute;es pour soutenir le processus de d&eacute;veloppement.




![AnsibleEngine](images/PairAndMob/ansible.png)



![OpenShift](images/PairAndMob/openshift.png)



### Quels sont les nouveaux outils et frameworks que nous utiliserons ?
* **OpenShift Container Platform**: La plateforme de d&eacute;ploiement et d'h&eacute;bergement d'applications cloud de Red Hat
* **GitLab**: Serveur Git g&eacute;r&eacute; par la communaut&eacute;, d&eacute;sormais dot&eacute; d'une chaîne d'outils DevOps int&eacute;gr&eacute;e.
* **Nexus**: Gestionnaire de r&eacute;f&eacute;rentiel pour le stockage de nombreux types d'applications.
  *  Peut h&eacute;berger des d&eacute;p&ocirc;ts de npm et de conteneurs
* **Jenkins**: Serveur d'automatisation de construction open source qui est hautement personnalisable avec des plugins.
* **Ansible**: Outil d'automatisation informatique de Red Hat utilis&eacute; pour provisionner et g&eacute;rer l'&eacute;tat de l'infrastructure physique et du cloud.
* **openshift-applier**: Un ensemble de playbooks/r&ocirc;les Ansible pour appliquer les objets OpenShift &agrave; un cluster OpenShift



## La vue d'ensemble
![BP1](images/bp-1-manual-menace.jpg)



## V&eacute;rifiez l'environnement de votre lab


### C'est parti ! !!
Lab Exercice 1: _La menace manuelle_



<!-- .slide: data-background-image="images/chef-background.png", class="white-style" -->
### Pratiques DevOps utilis&eacute;es dans cette section :
- [Everything As Code](https://openpracticelibrary.com/practice/everything-as-code/)
