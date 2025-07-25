require 'rails_helper'

RSpec.describe EmployeeProfilesController, type: :controller do
  let(:user) { create(:user, role: :employee) }
  let(:profile) { create(:employee_profile, user: user) }

  before { sign_in user }

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: profile.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    it 'updates the profile and redirects' do
      patch :update, params: { id: profile.id, employee_profile: { first_name: 'New', last_name: 'Name' } }
      expect(response).to redirect_to(employee_root_path)
      expect(flash[:notice]).to eq('Profile updated successfully')
    end

    it 'renders edit on failure' do
      patch :update, params: { id: profile.id, employee_profile: { first_name: '', last_name: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'access control' do
    it 'redirects non-employee users' do
      sign_out user
      company = create(:user, role: :company)
      sign_in company
      get :edit, params: { id: profile.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access denied')
    end
  end
end
