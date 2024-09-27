import i18next from 'i18next'

i18next.init({
    resources: {
        ru: {
            translation: {
                button: {
                    "modify_test": 'Изменить тест',
                    "cancel": 'Отменить'
                }
            }
        },
        en: {
            translation: {
                button: {
                    "modify_test": 'Modify Test',
                    "cancel": 'Cancel'
                }
            }
        }
    }
});

window.i18next = i18next
