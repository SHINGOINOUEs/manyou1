require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe '新規登録機能' do
    context 'ユーザを新規登録した場合'do
      it '登録したユーザが表示される' do
        visit new_user_path
        fill_in 'Name', with:'Administrator'
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: 'adminpassword'
        fill_in 'Password confirmation', with: 'adminpassword'
        click_on 'Create my account'
        expect(page).to have_link 'Profile'
        expect(page).to have_link 'Logout'
        expect(page). to have_content 'Administrator'
        expect(page). to have_content 'admin@example.com'
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
    before do
      FactoryBot.create(:user)
      visit new_user_path
      fill_in 'Name', with:'user1'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: 'user1password'
      fill_in 'Password confirmation', with: 'user1password'
      click_on 'Create my account'
    end
    context 'セッション機能' do
      it 'ログインできる' do
        expect(page).to have_link 'Profile'
        expect(page).to have_link 'Logout'
      end
    end
    context 'セッション機能' do
      it '自分の詳細画面に飛べる' do
        expect(page). to have_content 'user1'
        expect(page). to have_content 'user1@example.com'
      end
    end
    context '他人の詳細ページをクリック' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(1)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログインする' do
      it 'ログアウトする' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:user)
    end
    context '管理ユーザ登録' do
      it '管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザー登録' do
      it '一般ユーザーは管理画面にアクセスできない' do
        visit new_user_path
        fill_in 'Name', with:'user1'
        fill_in 'Email', with: 'user1@example.com'
        fill_in 'Password', with: 'user1password'
        fill_in 'Password confirmation', with: 'user1password'
        click_on 'Create my account'
        click_on 'ユーザー管理画面'
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

    context '管理ユーザ登録' do
      it 'ユーザーの新規登録ができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        click_on 'ユーザー管理画面'
        click_on 'ユーザーの作成'
        fill_in 'Name', with:'user2'
        fill_in 'Email', with: 'user2@example.com'
        fill_in 'Password', with: 'user2password'
        fill_in 'Password confirmation', with: 'user2password'
        click_on 'Create my account'
        expect(page).to have_content 'user2のページ'
        expect(page).to have_content 'user2@example.com'
      end
    end
    
    context '管理ユーザ登録' do
      it 'ユーザーの詳細画面にアクセス' do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        click_on 'ユーザー管理画面'
        visit admin_user_path(2)
        expect(page).to have_content 'user1のページ'
        expect(page).to have_content 'user1@example.com'
      end
    end

    context '管理ユーザ登録' do
      it 'ユーザーの編集画面からユーザーを編集できる' do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        click_on 'ユーザー管理画面'
        visit edit_admin_user_path(2)
        fill_in 'user[name]', with: 'user3'
        click_on '編集完了'
        expect(page).to have_content "user3"
      end
    end

    context '管理ユーザの登録' do
      it 'ユーザの削除ができる' do
        @second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'admin@example.com'
        fill_in 'session[password]', with: 'adminpassword'
        click_on 'Log in'
        click_on 'ユーザー管理画面'
        click_link '削除', href: admin_user_path(@second_user)
        # confirmウインドウのOKボタンを押す
        page.driver.browser.switch_to.alert.accept
        expect(page). to have_content 'ユーザーを削除しました'
      end
    end
  end
end

      