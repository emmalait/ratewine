const WINERIES = {}

WINERIES.show = () => {
    $("#winerytable tr:gt(0)").remove()
    const table = $("#winerytable")

    WINERIES.list.forEach((winery) => {
        table.append('<tr>'
            + '<td>'+ winery['name'] + '</td>'
            + '<td>'+ winery['year'] + '</td>'
            + '<td>'+ winery['active']['name'] + '</td>'
            + '<td>'+ winery['wines'] + '</td>'   
            + '</tr>')
    })
}

WINERIES.sort_by_name = () => {
    WINERIES.list.sort((a, b) => {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    })
}
  
WINERIES.sort_by_year = () => {
    WINERIES.list.sort((a, b) => {
        return a.year - b.year
    })
}
  
WINERIES.sort_by_active = () => {
    WINERIES.list.sort((a, b) => {
        return a.active.name.toUpperCase().localeCompare(b.active.name.toUpperCase());
    })
  }

WINERIES.sort_by_wines = () => {
    WINERIES.list.sort((a, b) => {
        return a.wines - b.wines;
    })
}

document.addEventListener("turbolinks:load", () => {
    if ($("#winerytable").length == 0) {
        return
    }

    $("#name").click((e) => {
        e.preventDefault()
        WINERIES.sort_by_name()
        WINERIES.show();    
    })

    $("#year").click((e) => {
        e.preventDefault()
        WINERIES.sort_by_year()
        WINERIES.show();    
    })

    $("#active").click((e) => {
        e.preventDefault()
        WINERIES.sort_by_active()
        WINERIES.show();    
    })

    $("#wines").click((e) => {
        e.preventDefault()
        WINERIES.sort_by_wines()
        WINERIES.show();    
    })

    $.getJSON('wineries.json', (wineries) => {
        WINERIES.list = wineries
        WINERIES.show()
    })
})