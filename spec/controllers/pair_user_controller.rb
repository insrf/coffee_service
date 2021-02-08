require 'rails_helper'

RSpec.describe PairUsersController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:pair_user) { create(:pair_user, user1_id: user1.id, user2_id: user2.id) }

  describe 'GET #index' do
    let(:pair_users) { create_list(:pair_user, 2) }

    before { get :index }

    it 'populates an array of all users' do
      expect(assigns(:pair_users)).to match_array(pair_users)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: pair_user }
    end

    it 'requested pair_user to @pair_user' do
      expect(assigns(:pair_user)).to eq pair_user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'new PairUser to @PairUser' do
      expect(assigns(:pair_user)).to be_a_new(PairUser)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: {id: pair_user}
    end

    it 'requested pair_user to @pair_user' do
      expect(assigns(:pair_user)).to eq pair_user
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    it 'saves the new pair_user in the database' do
      expect { post :create, params: {pair_user: { user1_id: user1.id, user2_id: user2.id} } }.to change(PairUser, :count).by(1)
    end

    it 'redirects to show view' do
      post :create, params: { pair_user: { user1_id: user1.id, user2_id: user2.id} }
      expect(response).to redirect_to pair_user_path(assigns(:pair_user))
    end
  end

  describe 'DELETE #destroy' do
    let(:user3) { create(:user) }
    let(:user4) { create(:user) }
    let!(:pair_user) { create(:pair_user, user1_id: user3.id, user2_id: user4.id) }

    it 'deletes user' do
      expect { delete :destroy, params: { id: pair_user } }.to change(PairUser, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: pair_user }
      expect(response).to redirect_to pair_users_path
    end
  end
end
