class DailyVerses extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidMount (){
    $.ajax({
      url:'https://dailyverses.net/getdailyverse.ashx?language='+this.props.language+'&isdirect=1&url=' +window.location.hostname,
      dataType: 'JSONP',
      success:function(json){
        $(".dailyVersesWrapper").prepend(json.html);
      }
    });
  }
  render () {
    return (
      <div className="dailyVersesWrapper"/>
    );
  }
}

