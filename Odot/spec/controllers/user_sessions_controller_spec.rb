require 'spec_helper'

describe UserSessionsController do

    describe "GET 'new'" do
        it "returns http success" do
            get 'new'
            response.should be_success
        end

        it "renders the new template" do
            get 'new'
            expect(response).to render_template('new')            
        end

    end

    describe "POST 'create'" do
        context "with correct credentials" do
            let!(:user) { User.create(first_name: "Alan", last_name: "Bishop", email: "something@email.com", password: "thepassword") }

            it "redirects to the todo path" do
                post :create, email: "something@email.com", password: "thepassword"
                expect(response).to be_redirect
                expect(response).to redirect_to(todo_lists_path)
            
            end

            it "finds the user" do
                expect(User).to receive(:find_by).with({email: "something@email.com"}).and_return(user)
                post :create, email: "something@email.com", password: "thepassword"
            end

            it "authenticates the user" do
                User.stub(:find_by).and_return(user)
                expect(user).to receive(:authenticate)
                post :create, email: "something@email.com", password: "thepassword"
            
            end

            it "sets the user_id in the sesion" do
                post :create, email: "something@email.com", password: "thepassword"
                expect(session[:user_id]).to eq(user.id)
            end


            it "sets the flash success message" do
                post :create, email: "something@email.com", password: "thepassword"
                expect(flash[:success]).to eq("Thanks for logging in!") 
            end

        end

        context "with blank credentials" do
            
            it "renders the new template" do
                post :create
                expect(response).to render_template('new')    
            end

            it "sets the flash error message" do
                post :create
                expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password.")
            end

        end

    end

end
