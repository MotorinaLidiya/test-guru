document.addEventListener('turbolinks:load', function () {
    const timer = document.querySelector('.timer')
    if (!timer || !timer.dataset.duration) return

    let duration = Number(timer.dataset.duration)
    const testPassageId = timer.dataset.testPassageId

    new TestPassageTimer(testPassageId, duration)
})

class TestPassageTimer {
    constructor(testPassageId, duration) {
        this.testPassageId = testPassageId
        this.duration = duration
        this.timerElement = document.getElementById('time-remaining')
        this.timerInterval = null

        const storedDuration = localStorage.getItem(`duration_${this.testPassageId}`)
        if (storedDuration) {
            this.duration = Number(storedDuration)
        }

        this.init()
    }

    init() {
        if (!this.timerElement) return
        this.startTimer()
        this.setupFinishButton()
        this.setupUnloadListener()
    }

    startTimer() {
        this.timerInterval = setInterval(() => this.updateTimer(), 1000)
    }

    updateTimer() {
        const minutes = Math.floor(this.duration / 60)
        const seconds = Math.floor(this.duration % 60)
        this.timerElement.textContent = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`

        if (this.duration <= 0) {
            clearInterval(this.timerInterval)
            alert("Время вышло!")
            this.submit()
        }

        this.duration--
        localStorage.setItem(`duration_${this.testPassageId}`, `${this.duration}`)
    }

    submit() {
        const form = document.getElementById('final_question_form')

        if (form) {
            form.submit()
        }
        else {
            setTimeout(function () {
                window.location.href = `/test_passages/${testPassageId}/result`
            }, 1000)
        }
    }

    setupFinishButton() {
        const finishTestButton = document.getElementById('finish-test-button')
        if (finishTestButton) {
            finishTestButton.addEventListener('click', (e) => {
                e.preventDefault()
                clearInterval(this.timerInterval)
                localStorage.removeItem(`duration_${this.testPassageId}`)
                this.submit()
            })
        }
    }

    setupUnloadListener() {
        window.addEventListener('beforeunload', () => {
            clearInterval(this.timerInterval)
            localStorage.setItem(`duration_${this.testPassageId}`, `${this.duration}`)
        })
    }
}
