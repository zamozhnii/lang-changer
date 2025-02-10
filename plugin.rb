# name: custom-html-lang
# about: Устанавливает lang="fr" для категории French Forum до загрузки страницы
# version: 0.1
# authors: Your Name

enabled_site_setting :enabled

after_initialize do
  # Регистрируем хук, который изменяет HTML до загрузки страницы
  add_to_serializer(:site, :custom_html_lang) do
    # Получаем текущую категорию
    category_id = nil
    if SiteSetting.enable_category_lang
      category_id = request.params["category_id"]
    end
    
    # Проверяем, если это категория French Forum (предположим, ID категории - 10)
    if category_id && Category.find(category_id).name == "French Forum"
      # Меняем lang="fr" на уровне HTML до загрузки страницы
      html_lang = 'fr'
    else
      html_lang = 'en'
    end

    # Возвращаем установленный атрибут lang
    html_lang
  end
end
