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
                post :create, email: "something@email.com", password: "PLATYPUS"
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

        end
    end

end
