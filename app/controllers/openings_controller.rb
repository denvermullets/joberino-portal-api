class OpeningsController < ApplicationController
  def index

  end

  def linkedin
    # url = 'https://tequilamatchmaker.com/tequilas'
    url = 'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area'
    response = Linkedin.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.all
      render json: all_jobs
      # render json: '{ Success: 200 }'
    else
      render json: response
    end

  end
end
