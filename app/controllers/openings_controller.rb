class OpeningsController < ApplicationController
  def index

  end

  def linkedin
    url = 'https://tequilamatchmaker.com/tequilas'
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
