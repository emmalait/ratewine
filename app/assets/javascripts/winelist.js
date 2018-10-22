const WINES = {}

WINES.show = () => {
  $("#winetable tr:gt(0)").remove()
  const table = $("#winetable")

  WINES.list.forEach((wine) => {
    table.append('<tr>'
      + '<td>' + wine['name'] + '</td>'
      + '<td>' + wine['style']['name'] + '</td>'
      + '<td>' + wine['winery']['name'] + '</td>'
      + '</tr>')
  })
}

WINES.sort_by_name = () => {
  WINES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

WINES.sort_by_style = () => {
  WINES.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase())
  })
}

WINES.sort_by_winery = () => {
  WINES.list.sort((a, b) => {
    return a.winery.name.toUpperCase().localeCompare(b.winery.name.toUpperCase());
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#winetable").length == 0) {
    return
  } 

  $("#name").click((e) => {
    e.preventDefault()
    WINES.sort_by_name()
    WINES.show();
    
  })

  $("#style").click((e) => {
    e.preventDefault()
    WINES.sort_by_style()
    WINES.show()
  })

  $("#winery").click((e) => {
    e.preventDefault()
    WINES.sort_by_winery()
    WINES.show()
  })

  $.getJSON('wines.json', (wines) => {
    WINES.list = wines
    WINES.show()
  })
})