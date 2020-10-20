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
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=25",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=50",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=75",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=100",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=125",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=150",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=175",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=software%20engineer&location=New%20York%20City%20Metropolitan%20Area&start=200",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=25",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=50",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=75",
      "https://www.linkedin.com/jobs/search/?f_TPR=r86400&geoId=90000070&keywords=front%20end%20developer&location=New%20York%20City%20Metropolitan%20Area&start=100",
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
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=30',
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=40',
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=50',
      'https://www.indeed.com/jobs?q=full%20stack%20developer&l=New%20York%2C%20NY&fromage=1&start=60',
    ]
    response = Indeed.process(url)

    if response[:status] == :completed && response[:error].nil?
      all_jobs = Opening.where(interested: true)
      render json: all_jobs
    else
      render json: response
    end
  end

  def nycstartup
    url = [
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=1',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=2',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=3',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=4',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=5',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=6',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=7',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=8',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=9',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=10',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=11',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=12',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=13',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=14',
      'https://www.builtinnyc.com/jobs/new-york-city/dev-engineering?page=15',
    ]
    response = Nycstartup.process(url)

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
