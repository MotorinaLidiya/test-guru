document.addEventListener('turbolinks:load', function() {
    const table = document.querySelector('table')
    const tbody = table.querySelector('tbody')
    const rows = Array.from(tbody.querySelectorAll('tr'))

    const rowsPerPage = 10
    let currentList = 1

    function showRows() {
        const totalRows = currentList * rowsPerPage

        rows.forEach((row, index) => {
            row.style.display = (index < totalRows) ? 'table-row' : 'none'
        })

        if (totalRows >= rows.length) {
            document.getElementById('showMoreRows').style.display = 'none'
            document.getElementById('showLessRows').classList.remove('hide')
        }
    }

    document.getElementById('showMoreRows').addEventListener('click', function() {
        currentList++
        showRows()
    })

    document.getElementById('showLessRows').addEventListener('click', function() {
        currentList = 1
        showRows()
        document.getElementById('showLessRows').classList.add('hide')
        document.getElementById('showMoreRows').style.display = 'table-row'
    })

    showRows()
})

