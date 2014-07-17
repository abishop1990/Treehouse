require 'spec_helper'

describe "Creating todo_lists" do
    it "redirects to the todo lists index page on success" do
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "My todo list"
        fill_in "Description", with: "What I'm doing today"
        click_button "Create Todo list"

        expect(page).to have_content("My todo list")
    end

    it "displays an error when a todo_list has no title" do
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: ""
        fill_in "Description", with: "What I'm doing today"
        click_button "Create Todo list"

        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("What I'm doing today") 
    end
    
    it "displays an error when a todo_list has a title less than 3 characters" do
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "Hi"
        fill_in "Description", with: "What I'm doing today"
        click_button "Create Todo list"

        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("What I'm doing today") 
    end

    it "displays an error when a todo_list has a description less than 5 characters" do
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")

        fill_in "Title", with: "Hello"
        fill_in "Description", with: "What"
        click_button "Create Todo list"

        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("What I'm doing today") 
    end

end

