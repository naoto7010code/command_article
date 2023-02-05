require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe '投稿の保存' do
    context '投稿できる場合' do
      it '投稿できる' do
        expect(@article).to be_valid
      end
    end
    context '投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @article.text = ''
        @article.valid?
        expect(@article.errors.full_messages).to include("Text can't be blank")
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @article.user = nil
        @article.valid?
        expect(@article.errors.full_messages).to include('User must exist')
      end
    end
  end
end
