require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:company_profile).dependent(:destroy) }
  it { should have_one(:employee_profile).dependent(:destroy) }

  it { should define_enum_for(:role).with_values(employee: 0, company: 1) }

  describe '#create_profile' do
    let(:user_employee) { User.new(role: 'employee', email: 'emp@example.com', password: 'password') }
    let(:user_company) { User.new(role: 'company', email: 'comp@example.com', password: 'password') }

    it 'creates an employee_profile for employee' do
      expect(user_employee).to receive(:build_employee_profile).and_call_original
      user_employee.save
    end

    it 'creates a company_profile for company' do
      expect(user_company).to receive(:build_company_profile).and_call_original
      user_company.save
    end
  end
end
