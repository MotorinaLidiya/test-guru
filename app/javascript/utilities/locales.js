import i18next from 'i18next'

i18next.init({
    resources: {
        ru: {
            translation: {
                button: {
                    "modify_test_title": 'Изменить название',
                    "cancel": 'Отменить'
                }
            }
        },
        en: {
            translation: {
                button: {
                    "modify_test_title": 'Modify Title',
                    "cancel": 'Cancel'
                }
            }
        }
    }
});

window.i18next = i18next
