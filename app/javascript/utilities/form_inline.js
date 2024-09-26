document.addEventListener('turbolinks:load', function () {
    $('.form-inline-link').on('click', formInlineLinkHandler)

    const errors = document.querySelector('.resource-errors')

    if (errors) {
        const resourceId = errors.dataset.resourceId
        formInlineHandler(resourceId)
    }
})

function formInlineLinkHandler(event) {
    event.preventDefault()

    const testId = event.currentTarget.dataset.testId
    formInlineHandler(testId)
}

function getLocale() {
    return document.getElementById('locale').className
}

function formInlineHandler(testId) {
    const button = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
    const $testTitle = $('.test-title[data-test-id="' + testId + '"]')
    const $formInline = $('#form-container-' + testId )

    if (!button) return

    $formInline.toggle()
    $testTitle.toggle()

    i18next.changeLanguage(getLocale())

    if ($formInline.is(':visible')) {
        button.textContent = i18next.t('button.cancel')
    } else {
        button.textContent = i18next.t('button.modify_test')
    }
}
