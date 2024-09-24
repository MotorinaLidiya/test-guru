document.addEventListener('turbolinks:load', function() {
    const control = document.querySelector('.sort-by-title')

    if (control) { control.addEventListener('click', sortRowsByTitle) }
})

function sortRowsByTitle() {
    const table = document.querySelector('table')
    const tbody = table.querySelector('tbody')
    const rows = Array.from(tbody.querySelectorAll('tr'))

    if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
        rows.sort(compareRowsAsc)
        this.querySelector('.octicon-arrow-up').classList.remove('hide')
        this.querySelector('.octicon-arrow-down').classList.add('hide')
    } else {
        rows.sort(compareRowsDesc)
        this.querySelector('.octicon-arrow-down').classList.remove('hide')
        this.querySelector('.octicon-arrow-up').classList.add('hide')
    }

    tbody.innerHTML = ''
    rows.forEach(row => tbody.appendChild(row))
}

function compareRowsAsc(row1, row2) {
    const testTitle1 = row1.querySelector('td').textContent.trim()
    const testTitle2 = row2.querySelector('td').textContent.trim()

    return testTitle1.localeCompare(testTitle2)
}

function compareRowsDesc(row1, row2) {
    const testTitle1 = row1.querySelector('td').textContent.trim()
    const testTitle2 = row2.querySelector('td').textContent.trim()

    return testTitle2.localeCompare(testTitle1)
}
