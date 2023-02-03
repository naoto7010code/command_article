require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'usernameが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.username = ''  # nicknameの値を空にする
      user.valid?
      expect(user.errors.full_messages).to include("Username can't be blank")
    end
    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.email = ''  # emailの値を空にする
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
  end
end
