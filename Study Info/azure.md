# more azure notes

## Azure Basics

AZ info -- <AprAz2024AKA@hotmail.com>  

### The CLI

can run from the cli in the cloud  
if running from local need to install the AZ modules  
why run local - save scripts etc.  

```powershell
install-module -name az -allowclobber -respository psgallery  
update-module ...  
```  

### Identity management - MODULE 4 INTRODUCTION TO ENTRA ID  

Entra is the cloud version of identity management, same but different than AD -- does not use Kerberos or LDAP uses OAUTH and SAML  
there is a free tier, create users and groups but offers little else - no reporting, no SLA, no security features    
not all users need to be on paid plans, some can remain on the free tier, some can be p1, etc.  
**account** - a person or app service account (managed identity)  
**tenant**  - a business or corporation, a unique domain name, every account is part of a tenant  
 requires a paid sub to make a MS one  
 can create a B2C tenant and use other accounts to authenticate, google, facebook.. etc  
**subscription** - the billing arrangement, free, pay-as-you-go, enterprise agreements, etc.  tenants can have more than one subscription  
global admin can do anything, first user, built in role  
more roles are unlocked with the P2 tier  

**Learned in mod 4** - how to add a custom domain, what is a tenant, creating a user account, creating a new tenant, some view settings 
**homework -- check these settings locally**

---

### Mod 5 users,groups and identity  

can have member users or guests users, can create users from a csv template for bulk operations, can sync with on prem AD and import some or all users  

- dynamic groups requires extra licenses (examples followed assume azure first users)  

free tier supports up to 500k objects - users, groups, contacts = objects  
users can be deleted pretty easily  

can audit or review group through logs from the activity panel  

can't add licenses to a user until the location is set  

in order to refresh to view of licenses it's REPROCESS  

again licenses only add features that the user needs, saves money  

roles allow you to group users by function - i.e helpdesk role can reset passwords of a certain tier across the company  
administrative unit separates the roles even further, continuing with the helpdesk role you can set that helpdesk admins can only help the finance dept. etc. etc.  

in my example I added teachers to the helpdesk role, then to further lock it down added an administrative unit, named it Classroom 1 since that's teacher 1's room - then added the students. this allows teacher 1 to **only** reset the student passwords in classroom 1.  
administrative groups can contain groups and devices, possibly apps  

devices are physical objects that authenticate through azure  
managed devices allow a standard for access things like - encryption, malware protection, device OS, age can all be evaluated  
external users -- providing access to users, contractors, etc outside of the domain, invite an external user create as guest user - can set all policies the same against them as a noraml user  
self service password reset does require all users to have a license that includes it  

**learned in module 5** adding users, groups, dynamic groups require a p2 license, how to use and configure roles and administrative units, the idea behind self-service password reset, can be turned on or off, requires licenses.  
**homework -- check these settings locally**

---

### MOD 6 - RBAC

Role based helps treat all users 'the same' users are assigned to roles and that's that.  
there are **a lot** of built in roles 
storage accounts are normally secured by keys, CBAC (or claims based access control) this can be changed in the configuration pane, once that's changed any access using keys is immediately broken  
how to assign users to the storage account? IAM panel - three basic kinds of roles (reader, owner, contributer)
after getting access to data blobs through roles then when creating containers can add and view data  
roles and assignments can be set very granularly and at every level, subscription, container, resource, etc, also defined in json and have some special properties, action, notactions, assignable scope  
custom roles can be made using old roles as a template or creating a completely new role  
how to view all permissions to an object? -- under access controls there is role assignments, also in azure ad choose the user and view azure role assignments (for objects), assigned roles (for entra management)
to deny you have to do it through azure blueprints - allows you to create from scratch or based on existing templates  

**what I learned mod 6** - rbac management helps with security by assigning the same role to every person, helps with permission creep. this can be a trap though, there are a lot of clicks and it gets very granular, are you assigning permissions at the group or tenant level? or the subscription level? or even the file level? the highest permission still wins. denying users access is easier done by just not giving it to them, it's possible to create custom deny rules but not through the IAM panel

### MOD 7 - MANAGE SUBSCRIPTIONS AND GOVERNANCE

ACCOUNT - a user id, or an applications account, basis for authentication, roles security and access to resources, are assigned resources
SUBSCRIPTION - an agreement with MS to use Azure services, resource usage gets billed to the payment method of the sub. not every tenant has a subscription, but to use services you need to use a subscription, sometimes multiple
TENANT - a representation of an org, like a domain name, a dedicated instance of azure AD (entra) 'peabrain products', ms appends onmicrosoft.com to the end of all tenants automatically
RESOURCE - any entity managed by azure, VMs, web apps, storage account, IP addresses, NICs, network security groups  
RESOURCE GROUP - a collection of resources usually for logical management, resources can only belong to one resource group, can lock a resource group, read only or block delete, block even owners from making changes or deleting (of course an owner can remove a lock)
you create a user, they're a part of a tenant (or AD), but in order to create a VM or something like that a subscription is needed or some way to bill, sometimes multiples subscriptions are used - so some resources are charged to one account and others to another
**management groups** -  can contain subscriptions, another way to control permission levels at the subscription level, blueprints can contain a prototype subscription and then you can deploy from that level, can review activity done on the group in the activity logs section for that group  
the subscription page shows the details and costs of the subscription, can break the cost down in several ways, can set pricing alerts for different events  
Polices (written in json) allow for rules set - like minimum OS version, etc. polices can be assigned to subscriptions and resource groups, can also make exclusions, the exclusion can block or just report when the policy is violated, non-compliance message can also be set, the compliance tab allows you to see what does meet the policy and provide remediation, there are many templates and each template can be modified to fit specific use-cases
how would you test a policy - most policies take about 30 min to enable
tags allow you to logically manage resources and groups, a key/value pairing - SERVERS - production, 
US - network, etc, details on who manages the resources, another way to manage without assigning to resource groups, no templates since this is all self made, can set a policy that enforces tags  
resources can be moved from one resource group to another or even another subscription, or a region, once that's done things that depend on the resource need to be updated since the resource ID will change  
policies can be managed through powershell also - it's actually better to get away from the portal and develop script sets  
policies are pre-deployment security solutions and locks are post-deployment solutions  
