class SearchResultsList extends React.Component {
  constructor(props) {
    super(props)

    this.state = { term: '', members: [], ministries: [] }
  }
  render () {
    return (
      <ul className="dropdown-menu" id="autocomplete-items" onMouseEnter={() => {this.props.setPreventHideDropdown()}} onMouseLeave={() => {this.props.resetPreventHideDropdown()}}>
        <span className="dropdown-arrow-top"></span>
        <span className="dropdown-arrow-bottom"></span>
        <li>
          <a href={`/search?q=${this.props.term}`}>
            <i className="fa fa-search"></i> {this.props.title_search} <strong>{this.props.term}</strong>
          </a>
        </li>
        {this.renderMemberHeading()}
        {this.renderMembers()}
        {this.renderMinistryHeading()}
        {this.renderMinistries()}
      </ul>
    );
  }
  renderMembers() {
   return this.props.members.slice(0, 4).map((member) => {
      return <SearchMemberListItem key={member.id} member={member} />
    });
  }

  renderMemberHeading() {
    if (this.props.members.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Members</h4></li>
  }

  renderMinistries() {
   return this.props.ministries.slice(0, 3).map((ministry) => {
      return <SearchMinistryListItem key={ministry.id} ministry={ministry} />
    });
  }

  renderMinistryHeading() {
    if (this.props.ministries.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Ministries</h4></li>
  }
}

