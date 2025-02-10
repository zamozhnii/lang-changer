# plugins/discourse-french-forum-lang/plugin.rb
enabled_site_setting :enable_lang_changer

# Этот метод будет вызываться при загрузке страницы
after_initialize do
  # Добавляем хук для изменения атрибута lang
  Discourse::Application.routes.append do
    get "/french-forum/*path" => "french_forum#lang_change"
  end

  # Создадим контроллер для изменения lang на 'fr'
  class ::FrenchForumController < ::ApplicationController
    def lang_change
      # Проверяем, является ли категория французским форумом
      if Category.exists?(name: 'French Forum') && category_forum?
        response.headers['Content-Language'] = 'fr'
      end
      # Продолжаем рендерить страницу с обновленным языком
      render :nothing => true
    end

    private

    def category_forum?
      # Получаем категорию текущей страницы (предположим, что URL соответствует)
      category = Category.find_by_slug(params[:path])
      category.present? && category.name == 'French Forum'
    end
  end
end