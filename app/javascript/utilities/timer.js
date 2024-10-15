document.addEventListener('turbolinks:load', function () {
    const timer =  document.querySelector('.timer')
    if (!timer || !timer.dataset.duration) return

    const timerElement = document.getElementById('time-remaining')
    if (!timerElement) return

    const duration = timer.dataset.duration
    const testPassageId = timer.dataset.testPassageId
    if (!duration || duration.split(':').length !== 2) return

    let remainingTime = durationToSeconds(duration)

    if (localStorage.getItem(`remainingTime_${testPassageId}`)) {
        remainingTime = Number(localStorage.getItem(`remainingTime_${testPassageId}`))
    }

    function updateTimer() {
        const minutes = Math.floor(remainingTime / 60)
        const seconds = Math.floor(remainingTime % 60)
        timerElement.textContent = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`

        if (remainingTime <= 0) {
            clearInterval(timerInterval)
            alert("Время вышло!")
            setTimeout(function () {
                window.location.href = `/test_passages/${testPassageId}/result`
            }, 1000)
            return
        }

        remainingTime--
        localStorage.setItem(`remainingTime_${testPassageId}`, remainingTime)
    }

    const timerInterval = setInterval(updateTimer, 1000)

    const finishTestButton = document.getElementById('finish-test-button')
    if (finishTestButton) {
        finishTestButton.addEventListener('click', function (e) {
            e.preventDefault()
            clearInterval(timerInterval)
            localStorage.removeItem(`remainingTime_${testPassageId}`)
            sendRemainingTime(testPassageId, remainingTime)
        })
    }

    window.addEventListener('beforeunload', function () {
        clearInterval(timerInterval)
        localStorage.setItem(`remainingTime_${testPassageId}`, remainingTime)
    })
})

function durationToSeconds(duration) {
    const [minutes, seconds] = duration.split(':').map(Number)
    return minutes * 60 + seconds
}

function sendRemainingTime(testPassageId, remainingTime) {
    fetch(`/api/test_passages/${testPassageId}/save_time?remaining_time=${remainingTime}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        }
    })
        .then(response => {
            console.log(response)
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Успешно сохранено:', data);

            document.getElementById('final_question_form').submit()
            //window.location.href = `/test_passages/${testPassageId}/result`
        })
        .catch(error => {
            console.error('Ошибка при отправке оставшегося времени:', error);
            console.error(`/api/test_passages/${testPassageId}/save_time`);
        });
}
