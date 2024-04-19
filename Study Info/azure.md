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

### MOD 8 - creating storage accounts  

**basics**  
belong to one subscription and a resource group, needs a name too that becomes part of the URL, also needs to be globally unique  
storage accounts are deployed to regions, pricing and governance can be different based on region and redundancy selections, best to closet to user  
when making the account need to select redundancy options, even the lowest copy makes 3 copies in the same region, zone redundant two copies in different locations in same zone, geo redundant two regions, geo and zone two different regions and zones 

**advanced tab**  
this is where secure access, allowing anonymous users, storage key access, tls version, datalink endpoints, and *blob storage access tiers* - are configured (hot or cool - this also affects pricing), hot is for frequently used data and cool for backups, logs, etc. hot is cheaper to write to and cool is more expensive to read from - this can be changed later

**networking**  
here can set where the storage account can be accessed from (publicly or locked down to certain accounts) and how the routing works either using MS internal networking or the public network  

**data protection**  
recovery and tracking control -- soft delete allows for recovery up to 7 days, point in time allows for versioning, tracking allows blobs to be tracked with version number (this does increase cost), or can just keep a log of the changes without keeping the blob file, access control prevents unwanted deletion of files - log files, auditing files etc.  

**encryption**  
data is encrypted by default, options are MS managing encryption keys or locally managing the keys - if locally managed need a key vault and a managed identity, there is also another layer of encryption at the hardware layer, infrastructure encryption  

**tags**  
assigning tags .. then validate  

containers on the storage dashboard is blob storage, it's a box to upload files into,  this can be done manually or through programs or something logically, how to access? with url AND access key
fileshares are more traditional, creating a fileshare like a W drive or something like that using SMB...when you create one few types of access tiers will popup, once created it's browsable like a regular file explorer, connect it to the pc with a script but 445 needs to be able to get through
queues -- like a messaging system between applications
tables -- are kind of like a loose database, like that ms access

**how to access files**  
*access keys* - how to access files in storage accounts - access keys, every account gets 2, you can rotate keys manually or with a rotation reminder, once a key is regenerated all previous access is revoked
another way to grant access is *shared access signatures* - under there you generate the key by selecting shared access signature, permissions you want to grant and then generate the token -- append to the end of the container string, there should be a question mark in the string but you have to append it, weird..the cleartext dates for access are in the string but also included is an encryption string based on the access key shown when generating the SAS -- these can also be created at the file level  
another way is stored access policies - a condition on a shared access signature - these can be revoked as well, can be made in powershell .. making it is kind of like an abbreviated SAS key -- once made and back in the SAS screen for the file there will be a Stored Access policy that can be applied that automatically sets the other features .. since you can't delete keys willy nilly, you can delete policies though -- if a policy is assigned and then deleted access is revoked while retaining keys
*entra id* - so keys are good, but what about enabling users internally? first it needs to be enabled in configuration, then the user needs to be added to a role in IAM - there can be conditions applied


**redundant storage**  
locally redundant = 3 additional copies in the same region  
configuration can be changed though - under redundancy can change to other options, some might not be available in the region the storage account has been created in 
geo redundant = files in another region  
if read only redundancy is created then multiple endpoints are created (some for read only)
once geo redundancy is configured then a failover can be done manually or automatically whenever access is lost - however some data may be lost, it also displays last sync time
-what's a premium storage account? -- faster drive, better read write access, less space though - only supports page blobs, block blobs and file shares  
back to access tiers - there are more than hot and cold, cool and archive are also available for files -- if tiers are moved there are some minimum charges based on days, 30, 120 for cool and cold. 180 for archiving takes the file offline completely, it's no longer accessible, just there - VERY CHEAP. hot files are expensive to store, cheap to write and read from. everything else is opposite to a degrees. 
*soft delete* for fileshares, allowing for recovery allows for up to 365 days to recover, once soft delete is enabled a lock is created by default to disable deletion, once you remove that  
*backups* - more fileshare stuff .. backups run regularly or can be done manually  
*snapshot* - for fileshare thing to do before a change - take a snapshot - go into the backup and can retrieve individual files instead of restoring the whole share, does not expire.  
**versioning**  
for blobs - this can be turned on initially, enabling it means everytime a file is added it adds a version backup of the blob. consider storage costs, MS recommends keeping less that 1000x copies of a file. this can be rotated too. does not protect against container deletion, that's for soft deletion only for blob files
deletion of backups, snapshots and versions can also be managed globally by lifecycle rules -- can move to different access tiers.  

**what I learned here** --- again many ways to the top of the mountain. easy to trip over your own toes here when creating management polices are storage accounts. there are many options when making a storage account - what kind of files it'll hold, how to access, where to put, how to back it up, who can access. these can be configured at a high level when creating the storage account but then fine tuned later. always consider how the data is going to be used when assigning storage policies. some keywords, hot, cold, cool, archive, blob, containers, fileshares, access keys, shared access keys, storage account  
