class CreateEmployeeProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.text :skills
      t.string :resume_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
