App.components.Layout = React.createClass({
  saveAllItems: function() {
    var event = new Event('saveAllItems');
    window.dispatchEvent(event);
  },

  render: function() {
    return (
      <div className="app">
        <h1>Item App</h1>
        <button onClick={this.saveAllItems}>SAVE</button>
        <App.components.ItemList items={window.rootItems} />
      </div>
    )
  }
})
