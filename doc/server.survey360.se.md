Setup for server.survey360.se (46.16.234.176)
=============================================

The production environment for smartbars and skistar-reports is hosted with Oderland. It is a Ubuntu 12.04 x64 Linux server.

For ssh details ask Niklas Gustavsson, Onserver360.
For Skistar's MSSQL server configs, speak to Skistar's IT manager.

Create sudoer:
--------------

ssh in as root and create a deploy user:

    % adduser deploy
    % groupadd deployers
    % usermod -a -G deployers deploy
    
Add deploy to ```/etc/sudoers```:

    deploy ALL=(ALL:ALL) ALL
    
Fix for error "sudo: must be setuid root":

    % chmod u+s /usr/bin/sudo
    
Fix error "perl: warning: Setting locale failed.
           perl: warning: Please check that your locale settings:
           	LANGUAGE = (unset),
           	LC_ALL = (unset),
           	LC_CTYPE = "UTF-8",
           	LANG = (unset)
               are supported and installed on your system.
           perl: warning: Falling back to the standard locale ("C")."

    % locale-gen en_US en_US.UTF-8
    % dpkg-reconfigure locales

And add the following to ```/etc/bash.bashrc```:

    export LC_ALL=en_US.UTF-8
    
Update and install packages:
----------------------------

Logout as root and ssh in as deploy:

Update and install basic packages:

    $ sudo apt-get update
    $ sudo apt-get upgrade    
    $ sudo apt-get install build-essential bison checkinstall curl

Postgresql database:

    $ sudo apt-get install postgresql-9.1 libpgsql-ruby1.9.1 postgresql-server-dev-9.1

FreeTDS for skistar-reports to connect to MSSQL Server:

    $ sudo apt-get install freetds-dev freetds-common freetds-bin

Image packages for creating skistar report charts:

    $ sudo apt-get install imagemagick libmagickwand-dev git

Packages for rvm and ruby:

    $ sudo apt-get install libreadline6-dev git-core zlib1g-dev libssl-dev libyaml-dev ncurses-dev
    $ sudo apt-get install libsqlite3-dev sqlite3 libxslt1-dev autoconf libgdbm-dev automake subversion libffi-dev

Apache and passenger requirements:

    $ sudo apt-get install apache2-mpm-prefork libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev
    
Javascript runtime for asset pipeline:

    $ sudo apt-get install libv8-dev
    
Cleanup:

    $ sudo apt-get autoremove
    
rvm and Ruby
------------
    
Install rvm for the deploy user:

    $ curl -L https://get.rvm.io | bash -s stable
    
Added ```source ~/.profile``` to ```~/.bash_profile```

Also added an environment variable to ```~/.bash_profile``` for github password:

    export SAUY7_GITHUB_PASSWORD="secret"

Update and check requirements:

    $ source ~/.bash_profile
    $ rvm requirements
    
Install latest available ruby 1.9.3:

    $ rvm install ruby-1.9.3-p385
    $ rvm use 1.9.3 --default

Apache Passenger and Virtualhost for smartbars
----------------------------------------------

Install and configure passenger, including dependencies:

    $ gem install passenger
    $ passenger-install-apache2-module
    
Note: If this fails, install the missing dependencies and run again:

    $ passenger-install-apache2-module
    
Create ```/etc/apache2/mods-available/passenger.load``` with content:

    LoadModule passenger_module /home/deploy/.rvm/gems/ruby-1.9.3-p385/gems/passenger-3.0.19/ext/apache2/mod_passenger.so

Create ```/etc/apache2/mods-available/passenger.conf``` with content:

    PassengerRoot /home/deploy/.rvm/gems/ruby-1.9.3-p385/gems/passenger-3.0.19
    PassengerRuby /home/deploy/smartbars_ruby_wrapper

Create ```/home/deploy/smartbars_ruby_wrapper``` with the contents:

    #!/bin/sh
    export SENDGRID_USERNAME="niklasg73"
    export SENDGRID_PASSWORD="drottningholm23"
    export SMARTBARS_DB_NAME="smartbars_production"
    export SMARTBARS_DB_USERNAME="smartbars"
    export SMARTBARS_DB_PASSWORD="DTCSMUg/rhVe6BP"
    exec "/home/deploy/.rvm/wrappers/ruby-1.9.3-p385/ruby" "$@"
    
Fix permissions:

    $ chmod 775 /home/deploy/smartbars_ruby_wrapper

And enable passenger module:

    sudo a2enmod passenger_module

Configure a virtual host ```/etc/apache2/sites-available/smartbars.onserver360.se```:

    <VirtualHost *:80>
      ServerName smartbars.onserver360.se
      ServerAdmin webmaster@onserver360.se
      DocumentRoot /var/www/smartbars/current/public
      <Directory /var/www/smartbars/current/public>
         AllowOverride all
         Options -MultiViews
      </Directory>
    </VirtualHost>

    $ sudo a2ensite smartbars.onserver360.se
    
Database users for applications
-------------------------------

    $ sudo -u postgres createuser --createdb --pwprompt skistar-reports
    Enter password for new role:
    Enter it again:
    Shall the new role be a superuser? (y/n) n
    Shall the new role be allowed to create more new roles? (y/n) n

    $ sudo -u postgres createuser --createdb --pwprompt smartbars
    Enter password for new role:
    Enter it again:
    Shall the new role be a superuser? (y/n) n
    Shall the new role be allowed to create more new roles? (y/n) n

Edit ```/etc/postgresql/9.1/main/pg_hba.conf```:

    #local   all         all                               peer
    local   all         all                               md5

    $ sudo /etc/init.d/postgresql stop
    $ sudo /etc/init.d/postgresql start

Note: The conf file may be overwritten if Postgresql is updated.

Environment variables for skistar-reports
-----------------------------------------

Create the file ```/home/deploy/.skistarenv``` with the contents:

    #export LC_ALL=en_US.UTF-8
    #export LC_CTYPE=UTF-8
    #export MAIL=/var/mail/deploy
    #export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

    export SQL_SERVER_SERVER=195.67.11.144:14330
    export SQL_SERVER_DATABASE=Maltavlan
    export SQL_SERVER_USERNAME=Maltavlan-Reports
    export SQL_SERVER_PASSWORD=nos!481RET

    export SKISTAR_DB_NAME=skistar-reports_production
    export SKISTAR_DB_USERNAME=skistar-reports
    export SKISTAR_DB_PASSWORD=Sk1st4r!

    export SENDGRID_USERNAME=niklasg73
    export SENDGRID_PASSWORD=drottningholm23

    export EMAIL_SENDER=noreply@survey360.se
    export BCC_EMAIL_RECIPIENTS=tim@onegiantleap.se
    export EXCEPTION_RECIPIENTS=tim@onegiantleap.se

    export RAILS_ENV=production

Then protect it:

    $ chmod 660 .skistarenv 

Added ```source ~/.skistarenv``` to ```~/.bash_profile``` and refreshed:

    $ source .bash_profile

Application directory setup - skistar-reports
---------------------------------------------

Initial application directory setup:

    $ cd /var/www
    $ sudo mkdir skistar-reports
    $ sudo chown root:deployers skistar-reports
    $ sudo chmod 775 skistar-reports

From local machine:

    $ cd skistar-reports
    $ cap deploy:setup

Back on server:

    $ sudo chown root:deployers /var/www/skistar-reports/releases
    $ sudo chown root:deployers /var/www/skistar-reports/shared

From local machine:

    $ cd skistar-reports
    $ cap deploy:check
    You appear to have all necessary dependencies installed
    $ cap deploy

Back on server:

    $ cd /var/www/skistar-reports/current/log
    $ sudo touch production.log cron.log
    $ sudo chown root:deployers production.log cron.log
    $ sudo chmod 0666 production.log cron.log
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake sql_server:test
    Should output all the surveys in the database
    $ bundle exec rake db:seed

Exception notifications (skistar-reports)
-----------------------------------------
Test by trying to send a non existent report:

    $ bundle exec rake scheduler:send_report[2,2010,25]

If this works, the Sendgrid configuration is correct.

Application directory setup - smartbars
---------------------------------------

Initial application directory setup:

    $ cd /var/www
    $ sudo mkdir smartbars
    $ sudo chown root:deployers smartbars
    $ sudo chmod 775 smartbars
    
From local machine:

    $ cd smartbars
    $ cap deploy:setup

On remote server:

    $ sudo chown root:deployers /var/www/smartbars/releases
    $ sudo chown root:deployers /var/www/smartbars/shared
    $ cd /var/www/skistar-reports/current/log
    $ sudo touch production.log cron.log
    $ sudo chown root:deployers production.log cron.log
    $ sudo chmod 0666 production.log cron.log
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate

From local machine:
     
    $ cap deploy:check
    
If all clear:

    $ cap deploy

On remote server:
    
    $ cd /var/www/smartbars/current/log
    $ sudo touch production.log
    $ sudo chown root:deployers production.log
    $ sudo chmod 0666 production.log
    $ cd /var/www/smartbars/shared
    $ sudo chgrp -R deployers log pids system
    
    $ cd /var/www/smartbars/current
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    
And enable virtual host:

    $ sudo service apache2 restart

