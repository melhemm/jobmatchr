class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :company_profile, dependent: :destroy
  has_one :employee_profile, dependent: :destroy

  enum role: { employee: 0, company: 1 }

  after_create :create_profile

  def create_profile
    if company?
      build_company_profile.save(validate: false)
    else
      build_employee_profile.save(validate: false)
    end
  end
end
