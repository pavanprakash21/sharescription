# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.4.1

* System dependencies
Redis
PostgreSQL

* Configuration
None

* Database creation
rails db:create db:migrate
TODO: Add rails db:populate command to fill the seed data

* Database initialization

* How to run the test suite
rspec

* Services (job queues, cache servers, search engines, etc.)
2 queues - mailer queue and default queue after their namesakes

* Deployment instructions
heroku create thisapp

Assumptions made:

1. Medical Records belongs to only user
2. Medical record can have many prescriptions
3. Asking for permission has been understood as asking permission to view the prescriptions of a particular medical record
4. When a doctor asks for permission, a pseudo record 'share record' will be created
5. User can temporarily turn off the permission to a particular doctor or a pharmacist over a medical record.
6. User can also delete a permitted record.
7. Doctors can view the medical records by going to a user's profile from a list of users and then ask for permission
