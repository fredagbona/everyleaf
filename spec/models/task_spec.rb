require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task model test' do
    context 'Si le Title la tâche est vide' do
      it "C'est difficile à Validation" do
        task = Task.new(name: '', description: '失敗test')
        expect(task).not_to be_valid
      end
    end
  end
  describe "fonction de validation taches vides" do
    context 'Si les détails de la tâche sont vides' do
      it 'Validation est intercepté' do
          # Écrivez du contenu ici
      end
    end
  end

  describe "fonction scope" do
    before do
      @task_01 = FactoryBot.create(:task)
      @task_02 = FactoryBot.create(:ndtask)

    end
    context 'Test de portée' do
      it 'Titre peut être recherchée avec la méthode scope' do
        expect(Task.search_by_title('Name low')).to include(@task_01)
      end
      it 'Statut peut être recherchée avec la méthode scope' do
        expect(Task.search_by_status(0)).to include(@task_01)
      end
      it 'Statut et titre peut être recherchée avec la méthode scope' do
        expect(Task.search_by_title('Name low').search_by_status(0)).to include(@task_01)
      end
    end
  end

end