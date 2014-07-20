require 'spec_helper'

describe TodoList do
    it { should have_many(:todo_items) }

    describe "#has_completed_items?" do
        let(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery List") }

        it "returns true with completed todo_list items" do
            todo_list.todo_items.create(content: "Eggs", completed_at: Time.now)
            expect(todo_list.has_completed_items?).to be_true
        end 

        it "returns true with completed todo_list items" do
            todo_list.todo_items.create(content: "Eggs")
            expect(todo_list.has_completed_items?).to be_false
        end 

    end    

end
