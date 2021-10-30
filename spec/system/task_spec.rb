require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session[email]', with: 'user@example.com'
    fill_in 'session[password]', with: '00000000'
    click_button 'Log in'

    @task = FactoryBot.create(:task)
    @tasks = FactoryBot.create(:ndtask)
    @tasks = FactoryBot.create(:thrdtask)
  end

  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do # Create a task for use in testing
        #Transition to task list page
        visit tasks_path
        # The text "task" appears on the visited (transitioned) page (task list page)
        # expect (confirm/expect) that have_content is included (is included)
        expect(page).to have_content 'Task Name'
        # The result of expect is true Then test successful, false If so, the result is output as a failure
      end
    end
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
          visit tasks_path
         task_list = all('.task_row') 
         expect(task_list[1]).to have_content 'Name high'
         expect(task_list[-1]).to have_content 'Name high'
      end
    end

    context 'When lists of tasks are arranged in descending order of expiration date' do
      it 'New task is displayed in the descending order of expiration date' do 
        visit tasks_path
        click_on 'sort by end deadline'
         task_list = all('.task_row') 
        
         expect(task_list[0]).to have_content 'Name hl'
      end
    end 

    context 'When you search a task' do
      it 'Task can search by title' do 
        @task1= FactoryBot.create(:task)
        @task2= FactoryBot.create(:ndtask)
        visit tasks_path
        fill_in 'search_title' , with: 'Name low' 
        click_on 'search'
        expect(page).to have_content 'Task'
      end

      it 'Task can search by status' do 
        @task1= FactoryBot.create(:task)
        @task2= FactoryBot.create(:ndtask)
        visit tasks_path
        select 'progress', from: 'search_status' 
        click_on 'search'
        expect(page).to have_content 'Task'
      end

      it 'Task can search by status and title' do 
        @task1= FactoryBot.create(:task)
        @task2= FactoryBot.create(:ndtask)
        visit tasks_path
        fill_in 'search_title' , with: 'Name high' 
        select 'progress', from: 'search_status' 
        click_on 'search'
        expect(page).to have_content 'Task'
      end
    end
  end
  
  describe 'Detailed display function' do
     context 'When transitioned to any task details screen' do
       it 'The content of the relevant task is displayed' do
       end
     end
  end
end