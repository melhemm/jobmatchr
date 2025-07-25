require 'rails_helper'

RSpec.describe EmployeeDashboardController, type: :controller do
  let(:user) { create(:user, role: :employee) }
  before { sign_in user }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'redirects non-employee users' do
      sign_out user
      company = create(:user, role: :company)
      sign_in company
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Access denied.')
    end
  end
end
