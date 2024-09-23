document.addEventListener('turbolinks:load', function() {
    const passwordField = document.getElementById('password')
    const passwordConfirmationField = document.getElementById('password_confirmation')
    const passwordError = document.getElementById('password-error')

    if (passwordField && passwordConfirmationField) {
        function validatePasswords() {
            const password = passwordField.value
            const passwordConfirmation = passwordConfirmationField.value

            if (passwordConfirmation === '') {
                passwordError.textContent = ''
                passwordField.classList.remove('valid', 'invalid')
                passwordConfirmationField.classList.remove('valid', 'invalid')
                return
            }

            if (password === passwordConfirmation) {
                passwordField.classList.add('valid')
                passwordField.classList.remove('invalid')
                passwordConfirmationField.classList.add('valid')
                passwordConfirmationField.classList.remove('invalid')
                passwordError.textContent = ''
            } else {
                passwordField.classList.add('invalid')
                passwordField.classList.remove('valid')
                passwordConfirmationField.classList.add('invalid')
                passwordConfirmationField.classList.remove('valid')
                passwordError.textContent = 'Пароли не совпадают'
            }
        }

        passwordField.addEventListener('input', validatePasswords)
        passwordConfirmationField.addEventListener('input', validatePasswords)
    }
})
