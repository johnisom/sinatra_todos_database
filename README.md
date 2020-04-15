# Sinatra Todos&mdash;Database #

Database persistent Sinatra-backed ruby web application for creating,
viewing, editing, and deleting to-do lists and their respective to-dos. 

This is a todo list manager powered by Sinatra and PostgreSQL. It offers
permanent database persistence, multiple todo lists, each with their own
todos, and editable todos & todo lists.

<p align="center">
  <img alt="GIF screen recording of application in use"
       src="example.gif">
</p>

## Installation ##

To be able to run this server locally, you must have PostgreSQL installed on
your machine. To do this, enter these commands (for Debian-based GNU/Linux
users):

```
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib libpq-dev
$ sudo -u postgres createuser --superuser $USER
# ^^ So you can connect to the server
$ sudo -u postgres createdb $USER
# ^^ To create a defaut database for use with the `psql` command
```

And optionally, to save your `psql` history, enter this command:

```
$ touch ~/.psql_history
```

Instructions for installing PostgreSQL can be found on [Launch School’s
installation instructions][install].

After you have `psql` set up, follow these instructions:

1. Clone this repository (`git clone https://github.com/johnisom/sinatra_todos_database`)
2. `cd` into the repository (`cd sinatra_todos_database`)
3. Install dependencies (`bundle install`)
   - If you don’t have ruby-2.6.5, install it
4. Create the database schema:
```
$ echo 'create database todos;' | psql
$ psql todos < schema.sql
```
5. Run the server locally (`bundle exec rackup`)
6. Enjoy your todo app at http://localhost:9292/

[install]: https://launchschool.com/blog/how-to-install-postgres-for-linux
