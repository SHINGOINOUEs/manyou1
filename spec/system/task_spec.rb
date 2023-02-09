require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do    
  describe '新規作成機能' do      
    let!(:user) {FactoryBot.create(:user) }
    let!(:user2) {FactoryBot.create(:second_user) }
    let!(:task) {FactoryBot.create(:task, user: user) }
    let!(:task2){FactoryBot.create(:second_task, user: user)}
    let!(:task3){FactoryBot.create(:third_task, user: user)}   

    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do   
        visit new_session_path        
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password 
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
    let!(:user) {FactoryBot.create(:user) }
    let!(:user2) {FactoryBot.create(:second_user) }    
    let!(:task){FactoryBot.create(:task, deadline: '2023-02-25',priority: 'low',user: user)}
    let!(:task2){FactoryBot.create(:task, deadline: '2023-02-23',priority: 'common',user:user)}
    let!(:task3){FactoryBot.create(:task, deadline: '2023-02-12',priority: 'high',user:user)}  
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        expect(page).to have_content 'テストサンプル1'
      end
    end
  
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path        
        assert Task.all.order(created_at: :desc)
      end
    end

    context '終了期限でソートするボタンを押した場合' do
      it '終了期限が近いものから表示する' do 
        visit new_session_path        
        fill_in 'session[email]', with:'user1@example.com'
        fill_in 'session[password]', with:'user1password' 
        click_button "Log in"    
        visit tasks_path
        click_button "終了期限"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content "2023-02-25"
        expect(task_list[1]).to have_content "2023-02-23"
        expect(task_list[2]).to have_content "2023-02-12"
      end
    end 

    context '優先順位でソートするボタンを押した場合' do
      it '優先順位が高いタスクが一番上に表示される' do 
        visit new_session_path        
        fill_in 'session[email]', with:'user1@example.com'
        fill_in 'session[password]', with: 'user1password'
        click_button "Log in"                   
        visit tasks_path
        click_button "優先度"  
        task_list = all('.task_row')               
        expect(task_list[0]).to have_content "high"   
        expect(task_list[1]).to have_content "common"   
        expect(task_list[2]).to have_content "low"   
      end
    end    
  end

  describe '詳細表示機能' do  
    let!(:user) {FactoryBot.create(:user) }
    let!(:user2) {FactoryBot.create(:second_user) }
    let!(:task) {FactoryBot.create(:task,title:'写真共有アプリ',content:'テストサンプル1' ,user:user) } 
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do  
        visit new_session_path        
        fill_in 'session[email]', with:user.email
        fill_in 'session[password]', with:user.password
        click_button "Log in"  
        task
        visit task_path(task)  
        expect(page).to have_content "写真共有アプリ"
        
      end
    end
  end

  describe '検索機能' do   
    let!(:user) {FactoryBot.create(:user) }
    let!(:user2) {FactoryBot.create(:second_user) }
    let!(:task) {FactoryBot.create(:task, title: '写真共有アプリ',status:'closed',user: user) }
    let!(:task2){FactoryBot.create(:second_task, title: '万葉課題ステップ2',status:'in_progress',user: user)}
    let!(:task3){FactoryBot.create(:third_task, title: '賃貸物件課題',status:'outstanding',user: user)}         
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with:user.email
        fill_in 'session[password]', with:user.password
        click_button "Log in"      
        visit tasks_path
        fill_in 'task[title]', with:'万葉'
        click_on "Search" 
        expect(page).to have_content "万葉課題ステップ2"
        expect(page).not_to have_content "写真共有アプリ"
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit new_session_path        
        fill_in 'session[email]', with:user.email 
        fill_in 'session[password]', with:user.password
        click_button "Log in"                
        visit tasks_path        
        select 'closed', from: 'task_status'  
        click_on "Search" 
        expect(page).to have_content "closed"
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit new_session_path        
        fill_in 'session[email]', with:user.email
        fill_in 'session[password]', with:user.password
        click_button "Log in"     
        visit tasks_path
        fill_in 'task[title]', with: '万葉'
        select 'in_progress', from: 'task[status]'
        click_on "Search" 
        expect(page).to have_content "万葉課題ステップ2"    
        expect(page).to have_content "in_progress"
      end
    end
  end  
end 

