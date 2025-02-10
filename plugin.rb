# name: custom-html-lang
# about: Устанавливает lang="fr" для категории French Forum до загрузки страницы
# version: 0.1
# authors: Your Name

enabled_site_setting :enabled

after_initialize do
  # Обрабатываем запрос и добавляем lang="fr" для категории French Forum
  on(:before_render) do |controller|
    # Проверяем, если это категория French Forum (предположим, что ID категории = 10)
    if controller.params[:category_id]
      category = Category.find_by(id: controller.params[:category_id])
      
      if category && category.name == 'French Forum'
        # Добавляем lang="fr" до загрузки страницы
        controller.response.headers["X-Content-Language"] = "fr"
      end
    end
  end
end
