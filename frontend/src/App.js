import './App.css';
import { Component } from 'react';
import Comments from './Comments';
import AddComment from './AddComment';

export default class App extends Component {
  constructor() {
    super();
    this.state = {
      apiUrl: "https://695uaouno9.execute-api.eu-north-1.amazonaws.com"
    }
  }

  render() {
    return (
      <div className="App">
        <Comments getUrl={this.state.apiUrl} />
        <AddComment postUrl={this.state.apiUrl} />
      </div>
    )
  }
}
