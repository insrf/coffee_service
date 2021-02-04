require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:users) { create_list(:user, 2) }

    before { get :index }

    it 'populates an array of all users' do
      expect(assigns(:users)).to match_array(users)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: {id: user}
    end

    it 'requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: {id: user}
    end

    it 'requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    it 'saves the new user in the database' do
      expect { post :create, params: {user: attributes_for(:user)} }.to change(User, :count).by(1)
    end

    it 'redirects to show view' do
      post :create, params: { user: attributes_for(:user) }
      expect(response).to redirect_to user_path(assigns(:user))
    end
  end

  describe 'PATCH #update' do
    it 'assings the requested user to @user' do
      patch :update, params: { id: user, user: attributes_for(:user) }
      expect(assigns(:user)).to eq user
    end

    it 'changes user attributes' do
      patch :update, params: { id: user.id, user: { name: 'new name'} }
      user.reload
      expect(user.name).to eq 'new name'
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'deletes user' do
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: user }
      expect(response).to redirect_to users_path
    end
  end
end
