# sinatra\_todos\_database #

The repository containing all the commits for this project before the move
into a separate repo is found [here](https://github.com/johnisom/RB185).

This is a todo list manager powered by Sinatra and PostgreSQL.

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
installation instructions][install]

[install]: https://launchschool.com/blog/how-to-install-postgres-for-linux
