import { Component } from "react";
import { Button, Form } from "react-bootstrap";
import './AddComment.css';

export default class AddComment extends Component {
  constructor () {
    super()
    this.submitComment = this.submitComment.bind(this)
  }

  submitComment(event) {
    fetch(
      `${this.props.postUrl}/?mail=${event.target[0].value}&comment=${event.target[1].value}`,
      {method: "POST"}
    )
  }

  render() {
    return (
      <div className="AddComment">
        <Form onSubmit={this.submitComment}>
          <Form.Group controlId="email">
            <Form.Label>Adres e-mail</Form.Label>
            <Form.Control type="email" placeholder="Podaj e-mail" />
          </Form.Group>
          <br />
          <Form.Group controlId="comment">
            <Form.Label>Komentarz</Form.Label>
            <Form.Control type="text" placeholder="Komentarz" />
          </Form.Group>
          <br />
          <Button variant="light" type="submit">
            Wyślij komentarz
          </Button>
        </Form>
      </div>
    )
  }
}
