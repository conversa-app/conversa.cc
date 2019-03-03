# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

rails db:create
rails db:migrate

* Database initialization

Before seeding the database the polis_server must be seeded with api keys. Sadly this cannot be done easily through scripts so best practice will be to log into the psql and do so directly.

psql -d $POLIS_DATABASE

insert into users (uid, hname, email) values  (402281, 'ds', ' team+ds@compositescollective.com');
insert into users (uid, hname, email) values  (402282, 'os', ' team+os@compositescollective.com');
insert into apikeysndvweifu (uid, apikey) values (402281, 'pkey_DSdDhue76HwR4y2WugRT2');
insert into apikeysndvweifu (uid, apikey) values (402282, 'pkey_OSFDhue76HwR4y2WugRT2');

After running these commands quit out of psql and run

rails db:seed

No errors should be seen and you should be ready to go. 

* How to run the test suite

rails spec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

cap production deploy

* ...
