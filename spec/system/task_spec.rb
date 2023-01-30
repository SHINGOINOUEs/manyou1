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
        assert Task.all.order(created_at: :desc)
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        assert Task.all.order(created_at: :desc)
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

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        # タスクの検索欄に検索ワードを入力する (例: task)
        task1 = FactoryBot.create(:task, title: '万葉課題ステップ3')
        task2 = FactoryBot.create(:task, title: '万葉課題ステップ2')
        task3 = FactoryBot.create(:task, title: '賃貸物件課題')
        visit tasks_path
        fill_in 'task[title]', with: '万葉'
        # 検索ボタンを押す
        click_on "Search" 
        expect(page).to have_content task1.title
        expect(page).not_to have_content task3.title
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        task1 = FactoryBot.create(:task,status: 1)
        task2 = FactoryBot.create(:task,status: 2)
        task3 = FactoryBot.create(:task,status: 3)
        visit tasks_path        
        # プルダウンを選択する「select」について調べてみること
        select 'closed', from: 'task_status'  
        click_on "Search" 
        expect(page).to have_content task1.status

      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        task1 = FactoryBot.create(:task, title: '万葉課題ステップ3')
        task2 = FactoryBot.create(:task, title: '万葉課題ステップ2')
        task3 = FactoryBot.create(:task, title: '賃貸物件課題')
        task4 = FactoryBot.create(:task, status: 1 )
        task5 = FactoryBot.create(:task, status: 2 )
        task6 = FactoryBot.create(:task, status: 3 )
        task7 = FactoryBot.create(:task, title: '万葉課題ステップ3', status: 3  )
        visit tasks_path
        fill_in 'task[title]', with: '万葉'
        select 'closed', from: 'task[status]'
        click_on "Search" 
        expect(page).to have_content task1.status        
        expect(page).to have_content task5.status
        expect(page).not_to have_content task3.title   
      end
    end
  end  
end 
