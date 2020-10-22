## Joberino

![dk](https://i.imgur.com/hMfFHoj.gif)

## What it do

Joberino pulls listings in the last 24hrs and adds them to a Postgresql database and avoids duplicates based on company and job title. So no 2 'IBM - Software Engineer' roles. The idea is that it makes it easier to keep track of the 'new' job postings without having to see all the senior jobs and stuff you have viewed already.

Currently you can save a listing, mark it as applied, or ignore the job posting. As of right now there's no filtering based on saved or applied jobs, but that should be implemented soon~ish. You can view jobs while it's scraping, it won't disrupt it.

You will need to supply your LinkedIn email and password (stored in a .env file in the root directory). Usage is below in the Installation section.

Feel free to make PR's. As long as I'm still looking for a job, I'll be working on this.

### [LINK TO FRONTEND REPO](https://github.com/denvermullets/joberino-portal-frontend)

### Some notes on sources:

- Built in NYC is the quickest to scrape and has a good chunk of the jobs on LinkedIn.
  - You trade having connection info w/having a brief job description.
- LinkedIn takes about 5mins to scrape to avoid being logged out or marked as a bot. Especially since you're using your own login information.
  - I've noticed sometimes LinkedIn will log you out in your browser while it's scraping 'cause it's trying to figure out if you're a bot or not. Just log back in and you should be fine.
  - I'd also imagine this breaks ToS for LinkedIn, however we're not publicly sharing this info or doing anything other than personal tracking.
- Indeed is largely useless as it rarely has jobs that aren't already on LinkedIn or other sites.
  - They also have agressive popups and there's a 3rd popup I never got to see the HTML for. Scraping could fail and you'll need to refresh the page and que Indeed again.

If you want to add more search terms or url on the 3 sources, add them to the arrays in `openings_controller.rb` since each url contains the search terms and the page it's on.

## Installation

This is built using `Ruby 2.7.1` and `Rails 6.0.3.4`. Please make sure you're using at least those versions of Ruby / Rails.

Joberino uses Kimurai gem, which uses Selenium, Nokogiri, and Capybara. Bundle install should take care of you but if not here's the commands you can use. It also uses Dotenv to manage your LinkedIn info.

```
brew cask install google-chrome firefox
brew cask install chromedriver
brew install geckodriver
brew install phantomjs
gem install kimurai
gem install nokogiri
```

I've heard from people that the `google-chrome` gives an error on install, but I think that's 'cause you already have Chrome installed. Selenium runs a headless (invisible) Chrome browser to do the scraping.

If you encounter this error:

```
Couldn't create 'joberino_portal_api_development' database.
Please check your configuration.
rails aborted!
PG::ConnectionBad: could not connect to server: No such file or directory
```

Try running `brew postgresql-upgrade-database` and that should fix the error.

Create a `.env` file in the root directory and inside of it put your email and pw for LinkedIn. This is just stored locally.

```
EMAIL=your@email.com
PASSWORD=yourPas$word
```

Once you `bundle install` fire it up.

```
rails db:create
rails db:migrate
rails s
```

This creates your db and runs the API on [http://localhost:3000](http://localhost:3000). You do not need to use the frontend repo if you don't want to and can make your own frontend.

## I hate this app I just want the JSON

Cool, I got you! I [built all the scraping](https://github.com/denvermullets/teq-scraper) in just a Ruby app that exports it as JSON if you just want to make your own stuff.
