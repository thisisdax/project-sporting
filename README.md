# WDI Project 3 - Sporting

Project 3 of WDI7 course. A sport platform for users to spontaneously join sport events, built as a mobile friendly platform. Made use of several other APIs like google map and facebook for this project. Tried to implement Ajax with the website as well.

## Getting Started

To get started, please git clone this repo and proceed to bundle install.
start your postgresql
run the following commands in sequence:
rails db:create
rails db:migrate
rails db:seed
rails s
Open up a browser and type in 'localhost:3000', the program should be up and running.

### Prerequisites

The project has several gem dependencies, most prominently "devise", "omniauth-facebook" and "cloudinary".
You are required to use postgresql for the database.

### How to Use

You may use the app without an account. However, to use additional features such as event creation and joining an event, you would require to be logged in.

You may join an event that has been created by someone else, provided there are available slots and the event have yet to expire.

## Live Version

The app has been deployed to http://sporting-sg.herokuapp.com/

## Built With

What did you use to build it, list the technologies, plugins, gems, packages etc.

```
gem 'cloudinary'
gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'therubyracer'
gem 'devise'
gem 'omniauth-facebook'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'redis'
gem 'bcrypt'
gem 'bootstrap_form'
gem 'capistrano-rails'
gem 'byebug'
gem 'web-console'
gem 'listen'
gem 'spring'
gem 'spring-watcher-listen'
gem 'tzinfo-data'
```


## Workflow

We tried practicing the git workflow for this project.

## Authors
*Group of Project Sporting for WdI7 Project 3*
* **Agnes Chew** [tomatokenji](https://github.com/tomatokenji)
* **Chengkoon Ann** [chengkoon](https://github.com/chengkoon)
* **Dax Tan** - [thisisdax](https://github.com/thisisdax)

## Acknowledgments

* Used bootstrap for styling
