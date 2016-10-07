class SearchMinistryListItem extends React.Component {
  render () {
    return (
      <li>
        <a href={this.props.ministry.url}>
          <img width="35" className="avatar-image" src={this.props.ministry.avatar_url} />
           <span dangerouslySetInnerHTML={{ __html: this.props.ministry.name }} />
        </a>
      </li>
    );
  }
}

