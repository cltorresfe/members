class SearchMemberListItem extends React.Component {
  render () {
    return (
      <li>
        <a href={this.props.member.url}>
          <img width="35" className="avatar-image" src={this.props.member.avatar_url} />
           <span dangerouslySetInnerHTML={{ __html: this.props.member.full_name }} />
        </a>
      </li>
    );
  }
}

