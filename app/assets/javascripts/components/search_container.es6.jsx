class SearchContainer extends React.Component {
  propTypes: {
      title_search: React.PropTypes.string
    }

  constructor(props) {
    super(props)

    this.state = { term: '', members: [], ministries: [] }
    this.hideDropdown = this.hideDropdown.bind(this);
    this.showDropdown = this.showDropdown.bind(this);
    this.setPreventHideDropdown = this.setPreventHideDropdown.bind(this);
    this.resetPreventHideDropdown = this.resetPreventHideDropdown.bind(this);
  }

  search(term){
    this.setState( {term});
    $.ajax({
      url: `/autocomplete.json/?term=${term}`,
      method: 'GET',
      success: (data) => 
        this.setState({ 
          members: data.members,
          ministries: data.ministries})
    });
  }
  setPreventHideDropdown() {
    this.setState({ preventHideDropdown: true });
  }

  resetPreventHideDropdown() {
    this.setState({ preventHideDropdown: false });
  }

  hideDropdown() {
    if (!this.state.preventHideDropdown) {
      this.setState({ showDropdown: false });
    }
  }

  showDropdown() {
    this.setState({ showDropdown: true });
  }

  render () {
    return (
      <div>
        <Searchbar
          showDropdown={this.showDropdown}
          hideDropdown={this.hideDropdown}
          term={this.state.term}
          title_search={this.props.title_search}
          title_placeholder={this.props.title_placeholder}
          onSearchTermChange={(term) => {this.search(term)}}
        />
        {this.renderSearchResults()}
      </div>  
    );
  }
  renderSearchResults(){
    if(!this.state.showDropdown || (this.state.members.length === 0 && this.state.ministries.length === 0)) {
      return;
    }
    return (
      <SearchResultsList
        setPreventHideDropdown={this.setPreventHideDropdown}
        resetPreventHideDropdown={this.resetPreventHideDropdown}
        term={this.state.term}
        title_search={this.props.title_search}
        members={this.state.members}
        ministries={this.state.ministries}
      />
    );
  }
}

