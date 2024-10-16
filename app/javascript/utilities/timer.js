document.addEventListener('turbolinks:load', function () {
    const timer =  document.querySelector('.timer')
    if (!timer || !timer.dataset.duration) return

    const timerElement = document.getElementById('time-remaining')
    if (!timerElement) return

    let duration = Number(timer.dataset.duration)
    const testPassageId = timer.dataset.testPassageId

    const storedDuration = localStorage.getItem(`duration_${testPassageId}`);
    if (storedDuration) {
        duration = Number(storedDuration);
    }

    const remainingTimeInput = document.getElementById('remaining-time')
    if (!remainingTimeInput) return

    function submit() {
        const button = document.getElementById('final_question_form')

        if (button) {
            remainingTimeInput.value = duration
            button.submit()
        }
        else {
            setTimeout(function () {
                window.location.href = `/test_passages/${testPassageId}/result`
            }, 1000)
        }
    }

    function updateTimer() {
        const minutes = Math.floor(duration / 60)
        const seconds = Math.floor(duration % 60)
        timerElement.textContent = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`

        if (duration <= 0) {
            clearInterval(timerInterval)
            alert("Время вышло!")
            remainingTimeInput.value = 0
            submit()
            return
        }

        duration--
        localStorage.setItem(`duration_${testPassageId}`, `${duration}`)
    }

    const timerInterval = setInterval(updateTimer, 1000)

    const finishTestButton = document.getElementById('finish-test-button')
    if (finishTestButton) {
        finishTestButton.addEventListener('click', function (e) {
            e.preventDefault()
            clearInterval(timerInterval)
            localStorage.removeItem(`duration_${testPassageId}`)
            submit()
        })
    }

    window.addEventListener('beforeunload', function () {
        clearInterval(timerInterval)
        localStorage.setItem(`duration_${testPassageId}`, `${duration}`)
    })
})
