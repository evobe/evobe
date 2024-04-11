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

