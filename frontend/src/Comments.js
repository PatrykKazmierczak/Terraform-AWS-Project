import { Component } from "react";
import { Spinner, Table } from 'react-bootstrap';
import './Comments.css';

export default class Comments extends Component {
  constructor() {
    super();

    this.state = {
        loaded: false,
        comments: []
    };
  }

  componentDidMount() {
    fetch(`${this.props.getUrl}/`)
      .then(response => response.json())
      .then(result =>
        this.setState({loaded: true, comments: result.comments}))
  }

  render() {
    return (
      <div className="Comments">
        {!this.state.loaded ?
        <Spinner animation='border' /> :
        <Table striped bordered hover>
          <thead>
            <tr>
              <th>E-Mail</th>
              <th>Komentarz</th>
            </tr>
          </thead>
          <tbody>
            {this.state.comments.map(comment =>
              <tr key={comment.mail}>
                <th>{comment.mail}</th>
                <th>{comment.comment}</th>
              </tr>
            )}
          </tbody>
        </Table>
        }
      </div>
    )
  }
}
