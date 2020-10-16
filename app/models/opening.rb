class Opening < ApplicationRecord
  # allows 1 url for company name and jobtitle uniquness - not really what i want
  # validates_uniqueness_of :job_url, :scope => {:company_name, :job_title}
  
  # should only allow 1 unique job title per company (i think this is ok to do?)
  validates_uniqueness_of :job_title, scope: :company_name

end
