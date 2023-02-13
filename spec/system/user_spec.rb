require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do

  describe 'ユーザー新規登録機能' do
    context 'ユーザを新規登録した場合'do
      it '登録したユーザが表示される' do
        visit new_user_path
        fill_in 'user[name]', with:'Administrator'
        fill_in 'user[email]', with: 'admin@example.com'
        fill_in 'user[password]', with: 'adminpassword'
        fill_in 'user[password_confirmation]', with: 'adminpassword'
        click_on '登録する'
        expect(page).to have_content 'のページ'        
      end
    end

    context 'ユーザがログインせずにタスク画面に飛んだ場合' do
      it 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした後' do
      it 'マイページに遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        expect(page).to have_content 'Administrator'
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        visit user_path(2)
        expect(page).to have_content '新しくタスクを投稿する'
      end
    end 
    context 'ログアウトをすると' do
      it 'ログイン画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe '管理画面のテスト' do

    before do
      FactoryBot.create(:user)
    end

    context '管理ユーザーがログインすると' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理画面'
      end
    end

    context '管理ユーザーがログインすると' do
      it 'ユーザー詳細画面にアクセスできる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        visit admin_users_path
        click_on 'ユーザー追加', match: :first
        expect(page).to have_content '新規登録'
      end
    end

    context '管理ユーザーがログインすると' do
      it 'ユーザーの新規登録ができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        visit new_admin_user_path
        fill_in 'user[name]', with: 'user1'
        fill_in 'user[email]', with: 'user1@example.com'
        select '管理者ユーザー', from: 'user_admin'
        fill_in 'user[password]', with: 'user1password'
        fill_in 'user[password_confirmation]', with: 'user1password'
        click_on '登録'
        expect(page).to have_content 'user1'
      end
    end
    context '管理ユーザーがログインすると' do
      it '編集画面からユーザーを編集できる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with:'adminpassword' 
        click_button "Log in"
        visit admin_users_path
        click_on '編集', match: :first        
        fill_in 'user[name]', with: 'user5' 
        fill_in 'user[email]', with: 'user5@example.com' 
        fill_in 'user[password]', with: 'user5password' 
        fill_in 'user[password_confirmation]', with: 'user5password'
        click_button "更新"
        expect(page).to have_content 'user5' 
      end
    end

    context '管理ユーザーはユーザーを削除した場合' do
      it 'ユーザー一覧画面に表示されない' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword' 
        click_button "Log in"
        visit admin_users_path
        click_on '削除', match: :first
        expect(page.accept_confirm).to eq "本当に削除してよろしいですか？"        
        expect(page).to have_content '削除しました'
      end
    end
  end
end    



      