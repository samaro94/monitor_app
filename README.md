# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    3.0.0

* Configuration

        bin/bash bundle install
        rails server

* Database creation

        bin/bash rails db:create
        bin/bash rails db:migrate

* Database initialization
    
        bin/bash rails db:seed

* Services (job queues, cache servers, search engines, etc.)

* Resume

    The sistem has a user login and register, once that the user is logged can:
        - Watch the list of services, add and modify the services
        - Watch and modify the availabilities for each user on the system
        - Modify services schedules
    
    The availabilities are configured by user and day of the week.

    With this information loaded, there's a service for calculate the work shifts for every day of the week
