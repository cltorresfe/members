
var days = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado" ];
if (gon.attendances_week != null){
    line_week = new Morris.Line({
    // ID of the element in which to draw the chart.
    element: 'line_chart',
    // Chart data records -- each entry in this array corresponds to a point on
    // the chart.
    data: gon.attendances_week,
    // The name of the data record attribute that contains x-values.
    parseTime: false,
    xkey: 'attendances_date',
    // A list of names of data record attributes that contain y-values.
    ykeys: ['count'],
    xLabelFormat: function(d)
                  {
                    date = new Date(d.src.attendance_date);
                    return days[date.getUTCDay()]+' '+(date.getUTCDate()) ;
                  },
    // Labels for the ykeys -- will be displayed when you hover over the
    // chart.
    labels: ['Personas']
  });
}

donut_range_age = Morris.Donut({

  element: 'graph_donut_range',
  data: gon.members_range,
  colors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
  formatter: function (y, data) {
    return data.count+' / '+y;
  },
  resize: true
});

donut_gender = Morris.Donut({

  element: 'graph_donut_gender',
  data: gon.members_gender,
  colors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
  formatter: function (y) {
    return y;
  },
  resize: true
});
