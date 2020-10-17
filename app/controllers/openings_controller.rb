class OpeningsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    all_jobs = Opening.where(interested: true)
    render json: all_jobs
  end

  def show
    job = Opening.find(params[:id])
    render json: job
  end

  def update
    job = Opening.find(params[:id])
    job.update(update_interested)
    render json: job
  end

  def linkedin
    url = [
      'https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area', 
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=25", 
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=full%20stack&location=New%20York%20City%20Metropolitan%20Area&start=50",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=25",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=50",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=75",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=100",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=125",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=150",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=175",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=engineer&location=New%20York%20City%20Metropolitan%20Area&start=200",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end&location=New%20York%20City%20Metropolitan%20Area",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end&location=New%20York%20City%20Metropolitan%20Area&start=25",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end&location=New%20York%20City%20Metropolitan%20Area&start=50",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end&location=New%20York%20City%20Metropolitan%20Area&start=75",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end&location=New%20York%20City%20Metropolitan%20Area&start=100",
    ]

    response = Linkedin.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.where(interested: true)
      render json: all_jobs
    else
      render json: response
    end

  end

  def indeed
    url = [
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1', 
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=10', 
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=20',
    ]
    response = Indeed.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.where(interested: true)
      render json: all_jobs
    else
      render json: response
    end
  end

  private
  def update_interested
    params.require(:opening).permit(:interested, :applied, :remind_me)
  end
end
