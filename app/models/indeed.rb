class Indeed < Kimurai::Base
  @name = 'google'
  @engine = :selenium_chrome

  @@jobs = []

  def self.process(url)
    @start_urls = url
    self.crawl!
  end

  def scrape_page
    # Update response to current response after interaction with a browser
    doc = browser.current_response
    # browser.save_screenshot
    sleep 4
    # sometimes a pop up will appear, refreshing page will avoid issues
    # page.has_css?('table tr.foo')
    if browser.current_response.css('div#popover-background')
      puts 'found popup'
      browser.refresh 
      sleep 3 # let page have time to load JS
      # when there's an event active it will reappear on refresh
      # if browser.current_response.css('div.vjs-highlight')
      #   puts 'found kforce'
      #   doc.css('div.vjs-highlight').remove
      #   puts 'removed kforce ad'
      #   sleep 2
      #   browser.execute_script("document.querySelector('div.vjs-highlight').remove()") ; sleep 2
      # end
    
    end

    if browser.current_response.css('div.vjs-highlight')
      puts 'found kforce'
      doc.css('div.vjs-highlight').remove
      puts 'removed kforce ad'
      sleep 1

      # if browser.current_response.css('div.vjs-highlight')
      #   puts 'found kforce'
      #   doc.css('div.vjs-highlight').remove
      #   puts 'removed kforce ad'
      #   sleep 2
      #   browser.execute_script("document.querySelector('div.vjs-highlight').remove()") ; sleep 2
      # end

    end

    if !browser.current_response.css('a.jobtitle').attribute('href')
      puts "2nd pop up found"
      browser.refresh
      sleep 3
      browser.save_screenshot

      # if browser.current_response.css('div.vjs-highlight')
      #   puts 'found kforce'
      #   doc.css('div.vjs-highlight').remove
      #   puts 'removed kforce ad'
      #   sleep 2
      #   browser.execute_script("document.querySelector('div.vjs-highlight').remove()") ; sleep 2
      # end

    end 

    # browser.save_screenshot

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
      job = {
        company_name: job_company_name, 
        job_title: job_role, 
        location: job_location, 
        salary_info: job_salary,
        job_description: job_description,
        job_url: job_url,
        job_source: 'https://indeed.com',
        job_id: "indeed",
        applied: false,
        remind_me: false,
        interested: true,  
      }
      @@jobs << job
      
      # we want to delete the LI so that the dom will render the next job (only shows 7 until scroll)
      doc.css('div.jobsearch-SerpJobCard')[0].remove
      browser.execute_script("document.querySelector('div.jobsearch-SerpJobCard').remove()") # ; sleep 2
      sleep 0.3
    end
  end

  def parse(response, url:, data: {})
    scrape_page

    @@jobs.map{ |job| Opening.create(job) }

  end
    
end