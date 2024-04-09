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
