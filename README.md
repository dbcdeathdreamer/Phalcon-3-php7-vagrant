What is Vagrant?

Vagrant is a "tool for building and distributing development environments". It works with virtualization software such as VirtualBox to provide a virtual machine that is sandboxed away from your local environment.




# What's included?
Vagrant provisioned with
* Ubuntu 14.04 (64bit)
* PHP7 
* Memcached
* Phalcon 3
* MySQL 5.x
* Apache 2.x (>= 2.4)
  
see voodoo.sh for details, plugins and modules


## Reach your app
```
http://192.168.33.92/

---

# Details & default configuration
DB Host: 127.0.0.1  
DB Port: 3306  
DB User: root  
DB Password: password  
DB Default Schema: main  


MySQL will be installed while provisioning the machine.  

# Appendix
This is just a simple and quick way to set up an running development environment,  
