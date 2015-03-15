App.components.ItemList = React.createClass({

  render: function() {
    var items = this.props.items.map(function(item) {
      return <App.components.Item {...item} />
    });

    return <ol>{items}</ol>
  }

})
