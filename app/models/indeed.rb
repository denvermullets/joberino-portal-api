class Indeed < Kimurai::Base
  @name = 'vehicles_spider'
  @engine = :selenium_chrome

  def self.process(url)
    @start_urls = url
    self.crawl!
  end

  def parse(response, url:, data: {})
    # Update response to current response after interaction with a browser
    doc = browser.current_response
    # browser.save_screenshot
    sleep 2
    
    # sometimes a pop up will appear, refreshing page will avoid issues
    if browser.current_response.css('div.popover-foreground')
      browser.refresh 
      sleep 2 # let page have time to load JS
    end

    if !browser.current_response.css('a.jobtitle').attribute('href')
      browser.refresh
      puts "2nd pop up found"
      sleep 2
    end 

    while (doc.css('div.jobsearch-SerpJobCard')[0]) do
      # this loop goes thru the however many job listings are on the page
      doc = browser.current_response
      # get first job listing
      single_job = doc.css('div.jobsearch-SerpJobCard')[0]
      # get job information
      
      job_url = single_job.css('a.jobtitle').attribute('href')
      job_role = single_job.css('a.jobtitle').text.strip().gsub(/\n/, "")
      job_company_name = single_job.css('span.company').text.strip().gsub(/\n/, "")
      job_location = single_job.css('span.location') ? single_job.css('span.location').text.strip().gsub(/\n/, "") : single_job.css('div.location').text.strip().gsub(/\n/, "")
      job_salary = single_job.css('span.salaryText') ? single_job.css('span.salaryText').text.strip().gsub(/\n/, "") : ''
      job_description = single_job.css('div.summary ul li').text.strip().gsub(/\n/, "")
      puts ' ===== '
      puts job_company_name
      puts job_role
      puts job_location
      puts job_salary
      puts job_description
      puts job_url
      puts " ===== "

      Opening.create(
        company_name: job_company_name, 
        job_title: job_role, 
        location: job_location, 
        salary_info: job_salary,
        job_description: job_description,
        job_url: job_url,
        job_source: 'Indeed',
        applied: false,
        remind_me: false,
        interested: true,
      )
      # we want to delete the LI so that the dom will render the next job (only shows 7 until scroll)
      doc.css('div.jobsearch-SerpJobCard')[0].remove
      browser.execute_script("document.querySelector('div.jobsearch-SerpJobCard').remove()") ; sleep 2
    end
  end
    
end