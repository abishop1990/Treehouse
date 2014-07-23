require 'spec_helper'

describe User do

    let(:valid_attributes) {
        {
            first_name: "Alan",
            last_name: "Bishop",
            email: "blah@bacon.com"
        }
    } 

    context 'validations' do
        let(:user) { User.new(valid_attributes) }

        before do
            User.create(valid_attributes)
        end


        it "requires an email" do 
            expect(user).to validate_presence_of(:email)
        end

        it "requires a unique email" do
            expect(user).to validate_uniqueness_of(:email)
        end 

        it "downcases an email before saving" do
            user = User.new(valid_attributes)
            user.email = "ALLCAPSEMAIL@CAPS.COM"
            expect(user.save).to be_true
            expect(user.email).to eq("allcapsemail@caps.com")
        end

    end

    describe "#downcase_email" do
        it "makes the email downcase" do
            user = User.new(valid_attributes.merge(email: "CAPSEMAIL@CAPS.COM"))
            user.downcase_email
            expect(user.email).to eq("capsemail@caps.com")    
        end
    end


end
