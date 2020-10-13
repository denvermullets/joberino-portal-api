class OpeningsController < ApplicationController
  def index

  end

  def linkedin
    url = 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area'
    response = Linkedin.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.all
      render json: all_jobs
    else
      render json: response
    end

  end

  def indeed
    url = [
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1', 
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=10', 
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=20']
    response = Indeed.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.all
      render json: all_jobs
    else
      render json: response
    end
  end
end
