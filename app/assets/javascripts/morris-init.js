
new Morris.Line({
  // ID of the element in which to draw the chart.
  element: 'myfirstchart',
  // Chart data records -- each entry in this array corresponds to a point on
  // the chart.
  data: [
    { label: 'Enero', value: 20 },
    { label: 'Feb', value: 10 },
    { label: 'Marzo', value: 5 },
    { label: 'Abril', value: 5 },
    { label: 'Mayo', value: 20 }
  ],
  // The name of the data record attribute that contains x-values.
  parseTime: false,
  xkey: 'mes',
  // A list of names of data record attributes that contain y-values.
  ykeys: ['value'],
  xLabelFormat: function(d)
                {
                    return "Mes " + d.src.label;
                },
  // Labels for the ykeys -- will be displayed when you hover over the
  // chart.
  labels: ['Personas']
});

Morris.Donut({
  element: 'graph_donut',
  data: [
    {label: 'Jam', value: 25},
    {label: 'Frosted', value: 40},
    {label: 'Custard', value: 25},
    {label: 'Sugar', value: 10}
  ],
  colors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
  formatter: function (y) {
    return y + "%";
  },
  resize: true
});