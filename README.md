# Data project

This project creates a virtual machine environment with which to easily play
around with Postgres, import data, and make changes according to versioned
schema migrations.

## Setup

1. Copy this project with git: `git clone git@github.com/reentim/dataproj.git`
2. Install VirtualBox (https://www.virtualbox.org/wiki/Downloads) and Vagrant (https://www.vagrantup.com/downloads.html).
3. `cd dataproj`
4. `vagrant up`
5. `vagrant ssh`
6. `cd /vagrant`
8. `make create`

## Usage

Now you have a running Postgres server, and a database named `dataproj`. You can
connect to it using a [Postgres
client](https://www.postgresql.org/docs/current/static/app-psql.html) like
`psql`: `psql dataproj`. Type `\?` to display `psql` help.

Running commands through the Postgres client might be sufficient.

But if you want to make results reproducible and mistakes reversible, use the tooling:

Add to the `Makefile` `download` directive, then run `make download` to download
a CSV dataset.

Use the [Standalone migrations
gem](https://github.com/thuss/standalone-migrations) to create a table for the
dataset. The column names should correspond to the CSV header line, and for now,
it's best to create the columns as `character varying`. Worry about
[types](https://www.postgresql.org/docs/current/static/datatype.html) later.

Create another migration to import the data with the [`COPY`
command](https://www.postgresql.org/docs/current/static/sql-copy.html), e.g.

```
def up
  execute <<-SQL
    COPY pedestrian_volumes
    FROM '/vagrant/tmp/pedestrian_volume.csv'
    CSV
    HEADER
  SQL
end
```

## TODO
* Configure VM / Postgres server to allow outside connections, e.g. from a GUI
  Postgres client.
