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

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task)}
    let!(:third_task){FactoryBot.create(:third_task)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.scope_title('タスクのテスト1')).to include(task)
        expect(Task.scope_title('タスクのテスト1')).not_to include(second_task)
        expect(Task.scope_title('タスクのテスト1').count).to eq 1      
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.where(status: 'closed')).to include(task)
        expect(Task.where(status: 'closed')).not_to include(second_task)
        expect(Task.where(status: 'closed').count).to eq 1       
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.scope_title('タスクのテスト1').where(status:'closed')).to include(task)
        expect(Task.scope_title('タスクのテスト1').where(status:'closed')).not_to include(second_task)
        expect(Task.scope_title('タスクのテスト1').where(status:'closed').count).to eq 1   
      end
    end
  end
end
