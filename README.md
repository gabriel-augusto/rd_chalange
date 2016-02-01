#README [![Code Climate](https://codeclimate.com/github/gabriel-augusto/rd_chalange/badges/gpa.svg)](https://codeclimate.com/github/gabriel-augusto/rd_chalange)      [![Test Coverage](https://codeclimate.com/github/gabriel-augusto/rd_chalange/badges/coverage.svg)](https://codeclimate.com/github/gabriel-augusto/rd_chalange/coverage)     [![Build Status](https://travis-ci.org/gabriel-augusto/rd_chalange.svg?branch=master)](https://travis-ci.org/gabriel-augusto/rd_chalange)

##About

This application is a test proposed by the Resultados Digitais company. It's a Ruby on Rails application that segments a list of contacts based in the parameters sugested by the user. It's possible to maintain contacts and segments.

##Build application

###Requirements

* Ruby ~> 2.2.1
* Rails ~> 4.2.5.1

###Install

```bundle install --without production```

```rake db:migrate```

###Run application

```rails server```

The application will be available at ```localhost:3000```

###Run tests

At the application directory...

Run all tests: ```rspec```

Run separated test file: ```rspec spec/directoryname/filename```

##Heroku
This aplication is available at [heroku](rdchallenge.herokuapp.com)
