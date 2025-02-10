# name: lang_changer
# about: Change localization
# version: 0.1
# authors: IDW
# url: https://github.com/zamozhnii/lang-changer

enabled_site_setting :lang_changer_enabled

   after_initialize do
     # настраиваем поведение до инициализации основных компонентов

     # добавляем обработчик маршрутов
     add_to_class(:guardian, :is_french_forum?) do |category_id|
       category = Category.find_by(id: category_id)
       category && category.name == "French Forum"
     end

     # изменяем lang атрибут на необходимый перед рендерингом страницы
     register_html_builder('server:before-head-close') do |controller, _|
       if controller.guardian.is_french_forum?(controller.request.params[:category_id])
         "<script>document.documentElement.setAttribute('lang', 'fr');</script>"
       else
         "<script>document.documentElement.setAttribute('lang', 'en');</script>"
       end
     end
   end