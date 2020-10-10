class Linkedin < Kimurai::Base
  @name = 'vehicles_spider'
  @engine = :selenium_chrome

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    sleep 3
    doc = browser.current_response
    returned_tequila = doc.css('div.ais-hits')
    returned_tequila.css('div.ais-hits--item').each do |single_tequila|
      # scrape each individual product listing url for tqdb
      url = "https://tequilamatchmaker.com" + single_tequila.css('a').attribute('href').text 
      # t.string :company_name
      # t.string :job_url
      # t.string :job_title
      # t.string :salary_info
      # t.string :location
      # t.string :job_id
      # t.string :extra_info
      # t.string :company_page
      # t.string :connection
      # t.string :job_description
      # t.boolean :applied
      # t.boolean :remind_me
      Opening.create(company_name: nil, job_url: url, job_title: nil, salary_info: nil, 
        location: nil, job_id: nil, extra_info: nil, company_page: nil, connection: nil, 
        job_description: nil, applied: false, remind_me: false)
      puts url
    end
    
  end
end 