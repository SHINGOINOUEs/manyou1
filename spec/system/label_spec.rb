require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:second_user) }
  let!(:label) { FactoryBot.create(:label) }

  context "タスクを新規登録した場合" do
    it "ラベルも登録できる" do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'user1password'         
      click_on 'Log in'  
      click_on "タスク一覧"
      binding.irb
      click_button "新しくタスクを投稿する"
      fill_in "task[title]", with: "タスク登録テスト" 
      fill_in"task[content]", with: "テストによる検証"
      fill_in "task[deadline]", with: "002023-12-01"   
      select 'outstanding', from: 'task_status'
      select 'common', from: 'task_priority'
      check 'ラベル1'
      click_on "登録する"
      expect(page).to have_content 'テスト'
    end
  end

  context "タスクにラベルを登録した場合" do
    it "つけたラべルで検索ができる" do
      visit new_session_path
      fill_in 'session_email', with: 'user1@example.com'
      fill_in 'session_password', with: 'user1password'      
      click_on 'Log in'
      click_on "タスク一覧"
      click_button "新しくタスクを投稿する"
      fill_in "task[title]", with: "タスク登録テスト"  
      fill_in "task[content]", with: "テストによる検証"
      fill_in "task[deadline]", with: "002023-12-01"   
      select 'outstanding', from: 'task_status'
      select 'common', from: 'task_priority'
      check 'ラベル1'
      check 'ラベル2'
      click_on "登録する"
      select 'ラベル2', from: 'task_label_ids'
      click_button "検索"
      expect(page).to have_content 'ラベル2'

    end
  end
end  