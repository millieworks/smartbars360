Initial Setup
=============
Create repository on Github. Rename folder.

    $ rails new smartbars --skip-bundle -d postgresql -G -T
    
Move ```.git``` folder from Github folder to project folder.

Rename ```README.rdoc``` to ```README.md``` (this file)

Add ```.rvmrc``` and cd into project directory to create gemset

    $ cd smartbars

Rename ```docs/README_FOR_APP``` to ```docs/README_FOR_APP.md```

    $ bundle install

Database setup
--------------
Create user, development and test databases using Navicat. Edit database.yml

    $ rake db:migrate

Development setup
-----------------
Add rails_best_practices, lol_dba and quiet_assets gems.
Edit ```config/environments/development.rb```

Test infrastructure setup (rspec-rails, capybara)
-------------------------------------------------
Add lines to Gemfile and bundle install.

    $ rails g rspec:install

Edit ```spec/spec_helper.rb``` by adding simplecov lines at the top

Edit ```config/application.rb``` for generator defaults, including Fabriation as a fixture replacement.

If phantomjs is not installed already (poltergeist):

    $ brew install phantomjs

Delayed_job setup
-----------------
Delayed job is used to fire requests to smartbar callback urls (TODO: and send registration emails to users).
See delayed job documentation for setup (added ```gem 'delayed_job_active_record'``` to ```Gemfile```:

    $ rails generate delayed_job:active_record
    $ rake db:migrate

Foreman setup
-------------
Foreman is setup locally to start rails and delayed job using the ```Procfile``` and ```.env``` files in the project root directory.

    $ foreman start

Home page setup
---------------
Remove ```public/index.html```.

    $ rails g controller administration index

Add ```adminstration#index``` as root to ```routes.rb```

Devise setup
------------
Add gem to Gemfile

    $ rails g devise:install

As per instructions in output:

Add flash messages to ```app/views/layout/application.html.erb```

  $ rails g devise User

Edit ```app/models/user.rb```, remove registable

Edit ```db/migrate/x_devise_create_user.rb```

Create one user seed in db/seeds.rb

    $ rake db:migrate
    $ rake db:seed

Edit ```config/application.rb``` to filter out password-related fields in logs.

Edit ```config/initializers/devise.rb``` to correct sender's email address.

Create views:

    $ rails g devise:views

Add before filter to administration controller and fire up the application.

    $ rails s

Remove views relating to unused features (registration, unlocking, confirmations), remove unused links from shared/links
template.

Twitter Bootstrap setup
-----------------------
Add bootstrap-sass and simple_form gems.

    $ rails generate simple_form:install --bootstrap

Add import and require rules to ```application.css.scss``` and ```application.js```.

Style sign in and password reset forms, centered in page using bootstrap grid.

Running specs and code coverage reports
=======================================
To run all specs under the spec folder, without code coverage run:

    $ rake spec

To get a merged code coverage report from all specs under the spec folder run:

    $ rake coverage

The report can be found in the ```coverage``` folder.

To run a group of particular specs, run:

    $ rake spec:controllers   # Run the code examples in spec/controllers
    $ rake spec:helpers       # Run the code examples in spec/helpers
    $ rake spec:lib           # Run the code examples in spec/lib
    $ rake spec:mailers       # Run the code examples in spec/mailers
    $ rake spec:models        # Run the code examples in spec/models
    $ rake spec:requests      # Run the code examples in spec/requests
    $ rake spec:routing       # Run the code examples in spec/routing
    $ rake spec:views         # Run the code examples in spec/views
