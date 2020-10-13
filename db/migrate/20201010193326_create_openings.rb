class CreateOpenings < ActiveRecord::Migration[6.0]
  def change
    create_table :openings do |t|
      t.string :company_name
      t.string :job_url
      t.string :job_title
      t.string :salary_info
      t.string :location
      t.string :job_id
      t.string :extra_info
      t.string :company_page
      t.string :connection
      t.string :job_description
      t.string :job_source
      t.boolean :applied
      t.boolean :remind_me
      t.boolean :interested
      t.timestamps
    end
  end
end
