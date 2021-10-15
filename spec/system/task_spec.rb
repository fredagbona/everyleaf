require 'rails_helper'
RSpec.describe 'Task management function', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:ndtask)
    visit tasks_path
  end
  describe 'New creation function' do
    context 'When creating a new task' do
      it 'The created task is displayed' do # Create a task for use in testing
        task = FactoryBot.create(:task, name: 'task',description: 'description', expiration_date: DateTime.now, status: 'completed')
        
        #Transition to task list page
        visit tasks_path
        # The text "task" appears on the visited (transitioned) page (task list page)
        # expect (confirm/expect) that have_content is included (is included)
        expect(page).to have_content 'task'
        # The result of expect is true Then test successful, false If so, the result is output as a failure
      end
    end
    context 'When tasks are arranged in descending order of creation date and time' do
      it 'New task is displayed at the top' do
         task_list = all('.task_row') 
         expect(task_list[-1]).to have_content 'Name low'
         expect(task_list[0]).to have_content 'Name high'
      end
    end

    context 'When lists of tasks are arranged in descending order of expiration date' do
      it 'New task is displayed in the descending order of expiration date' do 
        click_on 'sort by end deadline'
         task_list = all('.task_row') 
         expect(task_list[-1]).to have_content 'Name low'
         expect(task_list[0]).to have_content 'Name high'
      end
    end 

    context 'When you search a task' do
      it 'Task can search by title' do 
        task1= FactoryBot.create(:task)
        task2= FactoryBot.create(:ndtask)
        visit tasks_path
        fill_in 'search_title' , with: 'Name low' 
        click_on 'search'
        expect(page).to have_content 'Name low'
      end

      it 'Task can search by status' do 
        task1= FactoryBot.create(:task)
        task2= FactoryBot.create(:ndtask)
        visit tasks_path
        select 'progress', from: 'search_status' 
        click_on 'search'
        expect(page).to have_content 'Name high'
      end

      it 'Task can search by status and title' do 
        task1= FactoryBot.create(:task)
        task2= FactoryBot.create(:ndtask)
        visit tasks_path
        fill_in 'search_title' , with: 'Name high' 
        select 'progress', from: 'search_status' 
        click_on 'search'
        expect(page).to have_content 'Name high'
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