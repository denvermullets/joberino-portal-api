class Nycstartup < Kimurai::Base
  @name = 'google'
  @engine = :selenium_chrome

  @@jobs = []

  def self.process(url)
    @start_urls = url
    self.crawl!
  end

  def scrape_page
    sleep 3 #let vue page load
    doc = browser.current_response
    # browser.save_screenshot

    while (doc.css('div.job-item')[0]) do
      doc = browser.current_response
      single_job = doc.css('div.job-item')[0]
      job_url = single_job.css('a.job-row').attribute('href')
      job_role = single_job.css('h2.job-title')[0].text.strip().gsub(/\n/, "")
      job_company_name = single_job.css('div.company-title span')[0].text.strip().gsub(/\n/, "")
      job_description = single_job.css('div.job-description').text.strip().gsub(/\n/, "")
      job_location = "Greater NYC area"

      puts ' ===== '
      puts job_company_name
      puts job_role
      puts job_location
      # puts job_salary
      puts job_description
      puts job_url
      puts " ===== "
      job = {
        company_name: job_company_name, 
        job_title: job_role, 
        location: job_location, 
        # salary_info: job_salary,
        job_description: job_description,
        job_id: 'builtinnyc',
        job_url: job_url,
        job_source: '',
        applied: false,
        remind_me: false,
        interested: true,  
      }
      
      @@jobs << job

      # we want to delete the LI so that the dom will render the next job (only shows 7 until scroll)
      doc.css('div.job-item')[0].remove
      browser.execute_script("document.querySelector('div.job-item').remove()") 
      sleep 0.1
    
    end
  end

  def parse(response, url:, data: {})
    scrape_page

    @@jobs.map{ |job| Opening.create(job) }

  end
    
end