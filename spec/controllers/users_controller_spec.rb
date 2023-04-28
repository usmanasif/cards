require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      before do
        get :index
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
        get :new
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not authenticated' do
      before do
        get :new
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before do
        sign_in user
      end

      context 'with valid params' do
        let(:valid_params) do
          {
            user: {
              first_name: 'John',
              last_name: 'Doe',
              email: 'john@example.com',
              password: 'password',
              role: 1
            }
          }
        end

        it 'creates a new user' do
          expect {
            post :create, params: valid_params
          }.to change(User, :count).by(1)
        end

        it 'redirects to root path' do
          post :create, params: valid_params
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid params' do
        let(:invalid_params) do
          {
            user: {
              first_name: '',
              last_name: '',
              email: '',
              password: '',
              role: ''
            }
          }
        end

        it 'does not create a new user' do
          expect {
            post :create, params: invalid_params
          }.to_not change(User, :count)
        end
      end
    end

    context 'when user is not authenticated' do
      let(:valid_params) do
        {
          user: {
            first_name: 'John',
            last_name: 'Doe',
            email: 'john@example.com',
            password: 'password',
            role: 1
          }
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: valid_params
        }.to_not change(User, :count)
      end

      it 'redirects to sign in page' do
        post :create, params: valid_params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
