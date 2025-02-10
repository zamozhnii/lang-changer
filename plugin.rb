# name: lang_changer
# about: Change language code
# version: 0.1
# authors: IDW
# url: https://github.com/zamozhnii/lang_changer_plugin.git

enabled_site_setting :lang_changer_enabled

after_initialize do
  # Добавление в сериализатор
  add_to_serializer(:post, :lang_for_html) do
    object.lang_for_html
  end

  # Инициализация плагина
  if SiteSetting.lang_changer_enabled

    import { withPluginApi } from 'discourse/lib/plugin-api';
    import { Store } from 'discourse/lib/store';

    export default {
        name: 'lang-changer',

        initialize() {
            withPluginApi('0.8', api => {
                api.onPageChange(() => {
                    // Получаем текущий маршрут
                    const currentRoute = api.getCurrentRoute();

                    // Проверяем, если это страница категории
                    if (currentRoute && currentRoute.params && currentRoute.params.category_id) {
                    const categoryId = currentRoute.params.category_id;

                    // Получаем категорию
                    const category = Store.findBy('categories', categoryId);

                    // Проверяем имя категории и меняем lang
                    if (category) {
                        console.log(`You are on category: ${category.name}`);

                        // Меняем lang в зависимости от категории
                        if (category.name === 'French Forum') {
                            document.documentElement.setAttribute('lang', 'fr');
                        } else {
                            document.documentElement.setAttribute('lang', 'en');
                        }
                    }
                    }
                });
            });
        }
    };

  end
end