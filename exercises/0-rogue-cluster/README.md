# Rogue Cluster
> This section contains information needed when setting up the cluster for the learners. 

_____

<p class="tip">
NOTE - This section is a WIP and will evolve over time.
</p>

## Cluster Requirements
Learners will create 3 to 4 project namespaces running lightweight NodeJS app * 2  and a MongoDB in up to three of these namespace (dev, test, uat for example). The learners ci-cd namespace will house GitLab, Nexus and Jenkins as well as any slave pods used by jenkins.

 - Jenkins requires 5Gi of Persistent Storage and 4Gi of RAM
 - GitLab requires 2Gi of storage and 2Gi of RAM
 - PostgreSQL requires 1Gi of Storage and 512Mi of RAM 
 - Redis requires 512Mi of storage
 - Nexus requires


## Cluster Access 
 - Learners are in LDAP and can access cluster via `oc login`
 - Learners have access to LDAP bind credentials to be able to auth against gitlab 
 - 
 
## User privaleges 
 - Learners will require privaleges to run SCC containers ie GitLab
 - 
