# Local Development Setup

## Technology stack

- Ruby 3.1.2
- Ruby on Rails 7.0.4
- PostgreSQL 14.6
- Application Server: Puma
- Component Library from Tailwind + Flowbite https://flowbite.com/docs/getting-started/introduction/

### Requirements

Before you get started, the following needs to be installed:

- **Ruby**. Version 3.1.2 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [RVM](https://rvm.io//) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
- **Bundler**: `gem install bundler`
- [**Git**](http://help.github.com/git-installation-redirect)
- **A database**. PostgreSQL 14.6 has been tested, so we give no guarantees that other databases (e.g. mySQL) work. You can install PostgreSQL by:

```
sudo apt-get install postgresql-14.6
```

### Setting up the development environment

1.  Get the code. Clone this git repository and check out the latest release:

    ```bash
    git clone https://github.com/
    cd cards
    ```

2.  Install the required gems by running the following command in the project root directory:

    ```bash
    bundle install
    ```

3.  Precompile assets by running:

    ```bash
    bundle exec rails assets:precompile
    ```

4.  Create and populate database with seeds using:

    ```
    rails db:create db:migrate db:seed
    ```

5.  Run server:

    `rails server` or `rails s`

Congratulations! cards should now be up and running for development purposes on http://localhost:3000/
