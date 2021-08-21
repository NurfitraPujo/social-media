# Social Media API
Implementing simple social media API using Ruby

### Prequisite
- Ruby Version : 3.0.1^
- Bundler Gem Version : 2.2.19^

### Dependencies
- sinatra : 2.1
- puma : 5.4
- mysql2 : 0.5.3
- config : 3.1
- sinatra-contrib : 2.1

## Table of Content
- [Installing locally](#installing-locally)
- [Testing](#testing)
- [Migrations](#migrations)

## Installing Locally 
1. First we need to clone the repo into our local machine
```bash
git clone git@github.com:NurfitraPujo/social-media.git
```
2. Install dependencies using bundler. Make sure you already have [Mysql](https://www.mysql.com/downloads/) DBMS in your local machine
```bash
bundle install --without test
```
3. Run the migration script for production / development. see **Migration Link**
4. Start the application
```bash
# using ruby
ruby main.rb 

# using bundlerEn
bundle exec ruby main.rb
```

## Testing
1. Install dependecies for testing using bundler
```bash
bundle install
```
2. Run migration script for testing
3. Run rspec
```bash
rspec
```
Test coverages will automatically calculated each time you run rspec. If you want to see the individual codes that haven't been covered you can open `index.html` inside coverages folder (After running rspec at least once of course)

## Migrations
Before doing any instruction below make sure you have installed  [Mysql](https://www.mysql.com/downloads/) v8 or equivalent
### Setup
1. Open mysql console and enter your root password
2. Run the migration script
```bash
# testing
source /absolute/path/into/migrations/folder/migration_test.sql

# development / production
source /absolute/path/into/migrations/folder/migration.sql
```
### Rollback
1. Open mysql console and enter your root password
2. Run the migration script
```bash
# testing
source /absolute/path/into/migrations/folder/rollback_test.sql

# development / production
source /absolute/path/into/migrations/folder/rollback.sql
```
