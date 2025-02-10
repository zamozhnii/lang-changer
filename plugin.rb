# plugins/discourse-french-forum-lang/plugin.rb
enabled_site_setting :enable_lang_changer

# Этот метод будет вызываться при загрузке страницы
after_initialize do
    # Привязываем маршрут к категории с slug "french-forum"
    Discourse::Application.routes.append do
      get "/c/french-forum/:id" => "french_forum#lang_change"
    end
  
    # Создаем контроллер для изменения lang на 'fr'
    class ::FrenchForumController < ::ApplicationController
        def lang_change
          category = Category.find_by(id: params[:id])
          
          if category && category.name == 'French Forum'
            @lang = 'fr'
          else
            @lang = 'en'
          end
      
          render body: nil
        end
      end
  end