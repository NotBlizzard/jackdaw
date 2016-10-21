var Avatar = React.createClass({
  getInitialState: function() {
    return {email: ""}
  },
  handleChange: function() {
    this.setState({email: React.findDOMNode(this.refs.email).value})
  },
  render: function() {
    return (
      <div>
        <div className="avatar">
          <img src={ "https://gravatar.com/avatar/"+md5(this.state.email) }></img>
        </div>
        <form method="/login" method="POST">
          <input name="authenticity_token" type="hidden" value={this.props.csrf}></input>
          <label>Email</label><br />
          <input autofocus="autofocus" defaultValue={this.state.email} onChange={this.handleChange} name="user[email]" ref="email" className='register_input'></input>
          <br />
          <label>Pass</label><br />
          <input name="user[password]" type='password' className='register_input'></input><br />
          <input type="submit" value="Log in" className="button"></input>
          <br />
        </form>
      </div>
    )
  }
})