require 'rails_helper'

RSpec.describe CompanyProfilesController, type: :controller do
  let(:user) { create(:user, role: :company) }
  let(:profile) { create(:company_profile, user: user) }

  before { sign_in user }

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: profile.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    it 'updates the profile and redirects' do
      patch :update, params: { id: profile.id, company_profile: { name: 'New Name', address: 'New Address' } }
      expect(response).to redirect_to(company_root_path)
      expect(flash[:notice]).to eq('Profile updated successfully')
    end

    it 'renders edit on failure' do
      patch :update, params: { id: profile.id, company_profile: { name: '', address: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'access control' do
    it 'redirects non-company users' do
      sign_out user
      employee = create(:user, role: :employee)
      sign_in employee
      get :edit, params: { id: profile.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access denied')
    end
  end
end
