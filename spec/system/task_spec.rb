require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do   
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        fill_in "task[title]", with: "タスク登録テスト"  
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in "task[content]", with: "テストによる検証"
        fill_in "task[deadline]", with: "002023-12-01"        
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        click_on "登録する"    
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'タスク登録テスト'               
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task)
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'テストサンプル1'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される            
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:third_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first).to have_content 'タスクのテスト3'
      end
    end

    context 'タスクを終了期限で並び替えるを押した場合' do
      it 'タスクの順番が終了期限の降順で表示されること' do
        # ここに実装する
        task = FactoryBot.create(:task)
        task = FactoryBot.create(:second_task)
        task = FactoryBot.create(:third_task)
        visit tasks_path
        task_list = all('.task_row')

        click_on "終了期限でソートする"
        expect(task_list.first).to have_content 'タスクのテスト3'
      end
    end    

  end

  describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do  
          @task = FactoryBot.create(:task, title: 'task1', content: 'content1')
          visit task_path(@task)
          expect(page).to have_content 'task1'
          expect(page).to have_content 'content1'
      end
    end
  end
end 
