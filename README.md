# What is Vagrant?

Vagrant is a "tool for building and distributing development environments". It works with virtualization software such as VirtualBox to provide a virtual machine that is sandboxed away from your local environment.

# The First Vagrant Up

1. Start with any operating system.
2. Install VirtualBox
3. Install Vagrant
vagrant will now be available as a command in your terminal, try it out.
Note: If Vagrant is already installed, use vagrant -v to check the version. You may want to consider upgrading if a much older version is in use.
4. Clone or extract the Phalcon-3-php7-vagrant project into a local directory
5. Change into the new directory with cd (path to your vagrant folder)
5. Start the Vagrant environment with vagrant up

What Did That Do?

The first time you run vagrant up, a packaged box containing a basic virtual machine is downloaded to your local machine and cached for future use. The file used by Varying Vagrant Vagrants contains an installation of Ubuntu 14.04


# What's included?
Vagrant provisioned with
* Ubuntu 14.04 (64bit)
* PHP7 
* Memcached
* Phalcon 3
* MySQL 5.x
* Apache 2.x (>= 2.4)
  
see voodoo.sh for details, plugins and modules

#Now What?

Now that you're up and running, start poking around and modifying things.

Access the server via the command line with vagrant ssh from your vagrant-local directory. You can do almost anything you would do with a standard Ubuntu installation on a full server.


## Reach your app
http://192.168.33.92/

#MySQL Root
User: vagrant
Pass: password

#Memcached
server: 127.0.0.1
port: 11211


# Appendix
This is just a simple and quick way to set up an running development environment,  
