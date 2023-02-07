require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }  
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do   
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_button 'Log in'
        visit new_task_path
        fill_in "task[title]", with: "タスク登録テスト"  
        fill_in "task[content]", with: "テストによる検証"
        fill_in "task[deadline]", with: "002023-12-01"        
        click_on "登録する"    
        expect(page).to have_content 'タスク登録テスト'               
      end
    end
  end

  describe '一覧表示機能' do 
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }  
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin@example.com'
      fill_in 'session[password]', with: 'adminpassword'
      click_button 'Log in'
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        expect(page).to have_content 'task1'          
      end
    end
  
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        assert Task.all.order(created_at: :desc)
      end
    end

    context '終了期限でソートするボタンを押した場合' do
      it '終了期限が近いものから表示する' do   
        visit tasks_path
        task1 = FactoryBot.create(:task, deadline: '2023-02-25')
        task2 = FactoryBot.create(:task, deadline: '2023-02-23')
        task3 = FactoryBot.create(:task, deadline: '2023-02-12')
        click_button "終了期限"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "2023-02-25"
        expect(task_list[1]).to have_content "2023-02-23"
        expect(task_list[2]).to have_content "2023-02-12"
      end
    end
  end  

    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高いタスクが一番上に表示される' do 
        visit tasks_path
        task1 = FactoryBot.create(:task, priority: 'low')
        task2 = FactoryBot.create(:task, priority: 'common')
        task3 = FactoryBot.create(:task, priority: 'high')
        click_button "優先度"  
        task_list = all('.task_row')               
        expect(task_list[0]).to have_content "high"   
        expect(task_list[1]).to have_content "common"   
        expect(task_list[2]).to have_content "low"   
      end
    end    

  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }  
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin@example.com'
      fill_in 'session[password]', with: 'adminpassword'
      click_button 'Log in'
    end
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
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }  
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin@example.com'
      fill_in 'session[password]', with: 'adminpassword'
      click_button 'Log in'
    end    
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

