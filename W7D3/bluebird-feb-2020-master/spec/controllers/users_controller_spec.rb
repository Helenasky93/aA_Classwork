require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'GET #new' do
        it 'renders the new users template' do
            get :new #HTTP verb and the controller action (simulating a request)
            expect(response).to render_template(:new) 
        end
    end

    describe 'POST #create' do

        let(:user_params) do 
            {   user: {
                    username: 'rayzah_blaydes', 
                    email: 'down_undah@aa.io', 
                    password: 'dingos', 
                    age: 70
                } 
            }
        end

        context 'with valid params' do
            it 'saves user to the database and logs in the user' do
                post :create, params: user_params
                user = User.find_by(username: 'rayzah_blaydes')
                expect(session[:session_token]).to eq(user.session_token)
            end

            it "redirects to the user's show page" do
                post :create, params: user_params
                user = User.find_by(username: 'rayzah_blaydes')
                expect(response).to redirect_to(user_url(user))
            end
        end

        context 'with invalid params' do
            it 'should validate the user params and render the new template with errors' do
                post :create, params: { user: { username: 'rayzah_blaydes' } }
                expect(response).to render_template(:new)
                expect(flash[:errors]).to be_present
            end
        end
    end
end
