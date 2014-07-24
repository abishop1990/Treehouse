require 'spec_helper'

describe "Logging In" do

    it "logs the user in and goes to todo lists" do
        User.create(first_name: "Alan", last_name: "Bishop", email: "something@email.com", 
                    password: "thepassword", password_confirmation: "thepassword")
        
        visit new_user_session_path
        fill_in "Email Address", with: "something@email.com"
        fill_in "Password", with: "thepassword"
        click_button "Log In"
        
        expect(page).to have_content("Todo Lists")
        expect(page).to have_content("Thanks for logging in")

    end

    it "displays the email address in the event of a failed login" do
        visit new_user_session_path
        fill_in "Email Address", with: "something@email.com"
        fill_in "Password", with: "thepassword"
        click_button "Log In"

        expect(page).to have_content("Please check your email and password")
        expect(page).to have_field("Email Address", with: "something@email.com")

    end

end
