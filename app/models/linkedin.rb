class Linkedin < Kimurai::Base
  @name = 'linkedinerino'
  @engine = :selenium_chrome

  @@jobs = []

  def self.process(url)
    @start_urls = url
    self.crawl!
  end

  def scrape_page
    username = ENV['EMAIL']
    password = ENV['PASSWORD']
    sleep 2
    # see if we're logged in or not
    begin
      browser.find(:css, 'a.nav__button-secondary').click
      sleep 1
      browser.fill_in 'session_key', with: username
      browser.fill_in 'session_password', with: password
      sleep 2
      browser.find(:css, 'button.btn__primary--large').click
    rescue Capybara::ElementNotFound
      puts "user is logged in"
    end
    
    # Update response to current response after interaction with a browser
    doc = browser.current_response
    # browser.save_screenshot
    sleep 2
    
    while (doc.css('li.jobs-search-results__list-item')[0]) do
      # this loop goes thru the 25 job listings per page
      doc = browser.current_response
      # get div of all job listings, sometimes behaves weird if i don't snag a lower parent node
      job_listings = doc.css('ul.jobs-search-results__list')
      # get first job listing
      single_job = job_listings.css('li.jobs-search-results__list-item')[0]
      # get job information
      job_url = single_job.css('a.job-card-list__title').attribute('href')
      # job_url = "https://linkedin.com" + job_url
      job_role = single_job.css('a.job-card-list__title').text.gsub(/\n/, "").strip().gsub(/\n/, "")
      
      job_company_name = single_job.css('a.job-card-container__company-name').text.strip().gsub(/\n/, "")
      job_company_url = single_job.css('a.job-card-container__company-name').attribute('href')
      
      job_location = single_job.css('li.job-card-container__metadata-item').text.strip().gsub(/\n/, "")
      job_network = single_job.css('div.job-flavors__label').text.strip().gsub(/\n/, "")
      # we want to delete the LI so that the dom will render the next job (only shows 7 until scroll)
      job_listings.css('li.jobs-search-results__list-item')[0].remove
      browser.execute_script("document.querySelector('li.jobs-search-results__list-item').remove()") # ; sleep 2
      sleep 0.3
      puts ' ===== '
      puts job_company_name
      puts job_role
      puts job_location
      puts job_network
      puts job_company_url
      puts job_url
      puts " ===== "
      browser.save_screenshot
      # sleep 5
      job = {
        company_name: job_company_name,
        job_title: job_role,
        location: job_location,
        connection: job_network,
        company_page: job_company_url,
        job_url: job_url,
        applied: false,
        remind_me: false,
        interested: true,
        job_source: "https://linkedin.com",
      }
      @@jobs << job
    end
  end 

  def parse(response, url:, data: {})
    scrape_page
    
    @@jobs.reverse().map{ |job| Opening.create(job) }

  end
    
end