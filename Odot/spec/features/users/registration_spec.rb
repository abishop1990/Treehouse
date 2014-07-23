require "spec_helper"

describe "Signing Up" do
    
    it "allows a user to register" do
        expect(User.count).to eq(0)

        visit "/"
        expect(page).to have_content("Sign Up")        
        click_link "Sign Up"       

        fill_in "First Name", with: "Alan"
        fill_in "Last Name", with: "Bishop"
        fill_in "Email", with: "fake@email.com"
        fill_in "Password", with: "PLATYPUS"
        fill_in "Password (again)", with: "PLATYPUS"
        click_button "Sign Up"
        
        expect(User.count).to eq(1)        

    end

end 
