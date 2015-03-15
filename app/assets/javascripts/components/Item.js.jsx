App.components.Item = React.createClass({

  componentWillMount: function() {
    var state = this.state;
    var props = this.props;

    window.addEventListener('saveAllItems', function() {
      var request = $.ajax({
        url: "/api/items/" + props.id,
        method: "PUT",
        data: {
          item: {
            title: state.title,
            content: state.content
          }
        }
      });

      request.then(function(response) {
        console.log(response)
      });
    });
  },

  getInitialState: function() {
    return {
      title:       this.props.title,
      content:     this.props.content,
      isCollapsed: false
    }
  },

  toggleCollapsed: function(e) {
    this.setState({
      isCollapsed: !this.state.isCollapsed
    })
  },

  updateTitle: function(e) {
    var text = e.currentTarget.innerHTML;
    this.setState({title: text});
  },

  updateContent: function(e) {
    var text = e.currentTarget.innerHTML;
    this.setState({content: text});
  },

  render: function() {
    var collapseLink, children;

    if (_.any(this.props.children)) {
      collapseLink = <a onClick={this.toggleCollapsed} href="javascript:;">[-]</a>;
    }

    if (!this.state.isCollapsed) {
      children = <App.components.ItemList items={this.props.children} />;
    }

    return (
      <li className="item">
        {collapseLink}
        <h2 contentEditable onInput={this.updateTitle}>{this.state.title}</h2>
        <p  contentEditable onInput={this.updateContent}>{this.state.content}</p>
        {children}
      </li>
    )
  }
})
