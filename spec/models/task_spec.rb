require 'rails_helper'

#RSpec.describe Task, type: :model do
#pending "add some examples to (or delete) #{__FILE__}"

  RSpec.describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(title: '失敗テスト', content: '')
            expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(title: 'task', content: '発表会')          
          # ここに内容を記載する
          expect(task).to be_valid
        end
      end
    end  
end
