OpenShift-DIY-Perl
====================

Steps to support Perl 5.16 or newer version on OpenShift.com


Steps:
--------

Create new app using diy-0.1 cartridge:

	rhc app create diyapp diy
	rhc ssh -a diyapp


Download & Build new version of Perl from source:

	cd ~/app-root/data/
	mkdir download
	cd download
	wget -c -nd http://www.cpan.org/src/5.0/perl-5.24.0.tar.gz
	tar -xf perl-5.24.0.tar.gz
	cd perl-5.24.0
	./Configure -des -Dprefix=~/app-root/data/perl-new
	make 
	make install
	cd ~/app-root/data/perl-new/bin
	./perl -v

Then install additional Perl modules:

	cd ~/app-root/data/perl-new/bin
	HOME=~/app-root/data/ ./perl cpan
	> cpan[1]    notest install Dancer2 Plack
	> quit


Roll your own webserver
----------------------

Test if it works 

	cd ~/app-root/data/perl-new/bin
	DANCER_SERVER=$OPENSHIFT_DIY_IP DANCER_PORT=$OPENSHIFT_DIY_PORT ~/app-root/data/perl-5.24.0/bin/perl ~/app-root/runtime/repo/diy/app.pl


Please see this file to autostart and stop your webserver.

	.openshift/action_hooks/start
	.openshift/action_hooks/stop



Test on your browser:
----------------------

	http://[diyapp]-[yournamespace].rhcloud.com
	http://dancer2-imyaman.cloud.or.kr



Maintenance
------------

To stop/start/restart your app:

	rhc ssh -a diyapp 
	
	ctl_app stop
	ctl_app start
	ctl_app restart
	
	ctl_all stop
	ctl_all start
	ctl_all restart


Remember to always stop your webserver before running git push.
	
	rhc ssh -a diyapp
	ctl_app stop
	exit
	git push



