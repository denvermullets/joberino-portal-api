class Linkedin < Kimurai::Base
  @name = 'vehicles_spider'
  @engine = :selenium_chrome

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def scrape_page
    # Update response to current response after interaction with a browser
    # response = browser.current_response

    username = ENV['EMAIL']
    password = ENV['PASSWORD']
    sleep 5
    browser.find(:css, 'a.nav__button-secondary').click
    sleep 1
    browser.fill_in 'session_key', with: username
    sleep 1
    browser.fill_in 'session_password', with: password
    sleep 3
    browser.find(:css, 'button.btn__primary--large').click
    sleep 2
    
    # Update response to current response after interaction with a browser
    # response = browser.current_response
    job_listings = browser.find(:css, 'ul.jobs-search-results__list')
    job_listings.css('li.jobs-search-results__list-item').each do |single_job|
      job_url = job_listings.css('div div.job-card-container div.flex-grow-1 div.mr1 a')
      byebug
    end
    # byebug
    doc = 'hi'
    # browser.save_screenshot
  end 
  def parse(response, url:, data: {})
    scrape_page
    # sleep 3
    # doc = browser.current_response
    # returned_tequila = doc.css('div.ais-hits')
    # returned_tequila.css('div.ais-hits--item').each do |single_tequila|
    #   # scrape each individual product listing url for tqdb
    #   url = "https://tequilamatchmaker.com" + single_tequila.css('a').attribute('href').text 
    
    
    # Opening.create(company_name: nil, job_url: url, job_title: nil, salary_info: nil, 
    #   location: nil, job_id: nil, extra_info: nil, company_page: nil, connection: nil, 
    #   job_description: nil, applied: false, remind_me: false)
    # puts url
  end
    
end