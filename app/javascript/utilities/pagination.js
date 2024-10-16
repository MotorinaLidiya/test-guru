document.addEventListener('turbolinks:load', function() {
    const table = document.querySelector('table')
    if (!table) return

    const tbody = table.querySelector('tbody')
    const rows = Array.from(tbody.querySelectorAll('tr'))

    const rowsPerPage = 5
    let currentList = 1

    const showMoreButton = document.getElementById('showMoreRows')
    const showLessButton = document.getElementById('showLessRows')

    function showRows() {
        const totalRows = currentList * rowsPerPage

        rows.forEach((row, index) => {
            row.style.display = (index < totalRows) ? 'table-row' : 'none'
        })

        if (totalRows >= rows.length) {
            showMoreButton && (showMoreButton.style.display = 'none')
        } else {
            showMoreButton && (showMoreButton.style.display = 'block')
        }

        if (currentList > 1) {
            showLessButton && showLessButton.classList.remove('hide')
        } else {
            showLessButton && showLessButton.classList.add('hide')
        }
    }

    showMoreButton?.addEventListener('click', function() {
        currentList++
        showRows()
    })

    showLessButton?.addEventListener('click', function() {
        currentList = 1
        showRows()
        showLessButton.classList.add('hide')
        showMoreButton.style.display = 'block'
    })

    showRows()
})
