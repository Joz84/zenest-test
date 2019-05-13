# Zenest

This is the web application for Zenest

## Getting Started

#### Clone the project
```
$ git clone git@github.com:ClaudineP435433/zenest.git
```

#### Environment variables
We use `.env` gem to protect our configuration, run the following command :
All you have to do now is to get keys from an admin and copy/paste them to your application.yml

* `cloudinary_name`
* `cloudinary_key`
* `cloudinary_secret`
* `GOOGLE_API_SERVER_KEY`
* `STRIPE_PUBLISHABLE_KEY`
* `STRIPE_SECRET_KEY`
* `MAILCHIMP_API_KEY`
* `MAILCHIMP_WELCOME_LIST_ID`
* `MAILCHIMP_NEWSLETTER_LIST_ID`
* `SENDGRID_USERNAME`
* `SENDGRID_PASSWORD`

### Prerequisites

### Installing

```
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

## Running the tests

```
$ bundle exec rspec
```

## Deployment

Once you merged your work to master branch, Heroku will automatically deploy to staging application xxxxxx

Ask an admin for accessing the Heroku Dashboard and promote to production.

## Support

Rails app generated with MihiVai template.

