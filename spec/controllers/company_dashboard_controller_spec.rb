require 'rails_helper'

RSpec.describe CompanyDashboardController, type: :controller do
  let(:user) { create(:user, role: :company) }
  before { sign_in user }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'redirects non-company users' do
      sign_out user
      employee = create(:user, role: :employee)
      sign_in employee
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access denied.')
    end
  end
end
