# Webscale
Web app used for demonstrating the GraphQL query planner

## Requirements

[Install Ruby on Rails 5.1](http://railsapps.github.io/installrubyonrails-mac.html)

This project assumes the following tools and their respective versions are installed:
* chruby: v0.3.9
* ruby-install: v0.6.1
* Ruby: v2.4.1
* RubyGems: v2.6.12
* Rails: v5.1
* MySQL: v5.7.19



## Getting Started

Clone this repository.

```
$ git clone https://github.com/GraphQL-Query-Planner/project.git
```

Install depenedcies.

```
$ bundle install
```

Start your rails server.

```
$ rails server
```

Visit `http://localhost:3000/`.


### MySQL Setup

Webscale is configured to use MySQL as it's database. In macOS, MySQL can be installed using brew:

```bash
$ brew install mysql
```

By default the mysql user is root with no password.

Once installed, you can now start `MySQL`:
```bash
$ brew services start mysql
```

Once installed, verify your environments connection to the database by creating the databases:

```bash
$ rake db:create
Created database 'webscale_dev'
Created database 'webscale_test'
```
