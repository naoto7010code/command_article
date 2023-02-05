require 'rails_helper'

RSpec.describe '投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article_title = Faker::Lorem.sentence
    @article_text = Faker::Lorem.sentence
  end
  context '投稿ができるとき'do
  it 'ログインしたユーザーは新規投稿できる' do
    # ログインする
    sign_in(@user)
    # 新規投稿ページへのボタンがあることを確認する
    expect(page).to have_content('投稿する')
    # 投稿ページに移動する
    visit new_article_path
    # フォームに情報を入力する
    fill_in 'article_title', with: @article_title
    fill_in 'article_text', with: @article_text
    # 送信するとarticleモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Article.count }.by(1)
    # 投稿完了ページに遷移することを確認する
    expect(current_path).to eq(articles_path)
    # 「投稿が完了しました」の文字があることを確認する
    expect(page).to have_content('投稿が完了しました。')
    # トップページに遷移する
    visit root_path
    # トップページには先ほど投稿した内容が存在することを確認する（タイトル）
    expect(page).to have_content(@article_title)
  end
end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
     # 新規投稿ページへのボタンがないことを確認する
     expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe '編集', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  context '編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿の編集ができる' do
      # 1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 1に「編集」へのリンクがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link '編集', href: edit_article_path(@article1)
      # 編集ページへ遷移する
      visit edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#article_title').value
      ).to eq(@article1.title)
      expect(
        find('#article_text').value
      ).to eq(@article1.text)
      # 投稿内容を編集する
      fill_in 'article_title', with: "#{@article1.title}+編集したタイトル"
      fill_in 'article_text', with: "#{@article1.text}+編集したテキスト"
      # 編集してもarticleモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Article.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(article_path(@article1))
      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content('更新が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のが存在することを確認する（タイトル）
      expect(page).to have_content("#{@article1.title}+編集したタイトル")
    end
  end
  context '編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿の編集画面には遷移できない' do
      # 1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 2に「編集」へのリンクがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '編集', href: edit_article_path(@article2)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 1に「編集」へのリンクがないことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link '編集', href: edit_article_path(@article1)
      # 2に「編集」へのリンクがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '編集', href: edit_article_path(@article2)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
  end
  context '削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿の削除ができる' do
      # 1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 1に「削除」へのリンクがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link '削除', href: article_path(@article1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.more')[1].hover.find_link('削除', href: article_path(@article1)).click
      }.to change { Article.count }.by(-1)
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(article_path(@article1))
      # 「削除が完了しました」の文字があることを確認する
      expect(page).to have_content('削除が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@article1.title}")
    end
  end
  context '削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿の削除ができない' do
      # 1を投稿したユーザーでログインする
      sign_in(@article1.user)
      # 2に「削除」へのリンクがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '削除', href: article_path(@article2)
    end
    it 'ログインしていないと削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 1に「削除」へのリンクがないことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link '削除', href: article_path(@article1)
      # 2に「削除」へのリンクがないことを確認する
      expect(
        all(".more")[0].hover
      ).to have_no_link '削除', href: article_path(@article2)
    end
  end
end

RSpec.describe '詳細', type: :system do
  before do
    @article = FactoryBot.create(:article)
  end
  it 'ログインしたユーザーは詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@article.user)
    # 「詳細」へのリンクがある
    expect(
      all(".more")[0].hover
    ).to have_link '詳細', href: article_path(@article)
    # 詳細ページに遷移する
    visit article_path(@article)
    # 詳細ページに内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("#{@article.text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 「詳細」へのリンクがある
    expect(
      all(".more")[0].hover
    ).to have_link '詳細', href: article_path(@article)
    # 詳細ページに遷移する
    visit article_path(@article)
    # 詳細ページに内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("#{@article.text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end
