class CreateCompanyProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :company_profiles do |t|
      t.string :name
      t.string :address
      t.string :website
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
