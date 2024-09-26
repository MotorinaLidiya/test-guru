document.addEventListener('turbolinks:load', function () {
    const progress = document.querySelector('.progress')
    if (!progress) return

    const totalQuestions = Number(progress.dataset.totalQuestions)
    let currentQuestion = Number(progress.dataset.currentQuestion)

    const progressBar = document.querySelector('.progress-bar')

    function updateProgress() {
        const progressPercentage = (currentQuestion / totalQuestions) * 100

        progressBar.style.width = `${progressPercentage}%`
        progressBar.setAttribute("aria-valuenow", progressPercentage.toFixed(0))
    }

    updateProgress()

    document.addEventListener("test:nextQuestion", function() {
        currentQuestion = Math.min(currentQuestion + 1, totalQuestions);
        updateProgress();
    })

    document.addEventListener("test:prevQuestion", function() {
        currentQuestion = Math.max(currentQuestion - 1, 1);
        updateProgress();
    })
})