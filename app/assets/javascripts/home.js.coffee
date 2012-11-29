google.load 'visualization', '1.0', {'packages':['corechart']}
google.setOnLoadCallback drawChart

drawChart = ->
  data = google.visualization.DataTable
  data.addColumn 'string', 'Topping'
  data.addColumn 'number', 'Slices'
  data.addRows [
    ['Mushrooms', 3]
    ['Onions', 1]
    ['Olives', 1]
    ['Zucchini', 1]
    ['Pepperoni', 2]
  ]

  options = {
    'title': 'How Much Pizza I Ate Last Night'
    'width': 400
    'height': 300
  }

  chart = new google.vizualization.PieChart document.getElementById('chart_div')
  chart.draw data, options
