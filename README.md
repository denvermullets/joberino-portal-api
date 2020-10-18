## Joberino

![dk](https://i.imgur.com/hMfFHoj.gif)

## What it do

Joberino pulls listings in the last 24hrs and adds them to a Postgresql database and avoids duplicates based on company and job title. So no 2 'IBM - Software Engineer' roles. The idea is that it makes it easier to keep track of the 'new' job postings without having to see all the senior jobs and stuff you have viewed already.

Currently you can save a listing, mark it as applied, or ignore the job posting. As of right now there's no filtering based on saved or applied jobs, but that should be implemented soon~ish.

Feel free to make PR's

### Some notes on sources:

- Built in NYC is the quickest to scrape
- LinkedIn takes about 5mins to scrape to avoid being logged out or marked as a bot. Especially since you're using your own login information.
- Indeed is largely useless as it rarely has jobs that aren't already on LinkedIn or other sites.
  - They also have agressive popups and there's a 3rd popup I never got to see the HTML for. Scraping could fail and you'll need to refresh the page and que Indeed again.

## Installation

This is built using ``Ruby 2.7.1`` and ``Rails 6.0.3.4``. Please make sure you're using at least those versions of Ruby / Rails.

Joberino uses Kimurai gem, which uses Selenium, Nokogiri, and Capybara. Bundle install should take care of you but if not here's the commands you can use.

```
brew cask install google-chrome firefox
brew cask install chromedriver
brew install geckodriver
brew install phantomjs
gem install kimurai
gem install 'nokogiri'
```

I've heard from people that the `google-chrome` gives an error on install, but I think that's 'cause you already have Chrome installed. Selenium runs a headless (invisible) Chrome browser to do the scraping.

Clone repo down and `bundle install`

```
rails db:create
rails db:migrate
rails s
```

This creates your db and runs the API on [http://localhost:3000](http://localhost:3000). You do not need to use the frontend repo if you don't want to and can make your own frontend.

## I hate this app I just want the JSON

Cool, I got you! I [built all the scraping](https://github.com/denvermullets/teq-scraper) in just a Ruby app that exports it as JSON if you just want to make your own stuff.



