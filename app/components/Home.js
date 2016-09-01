import React, { Component } from 'react';
import {FormGroup, FormControl, InputGroup, Button, Glyphicon, ButtonToolbar, DropdownButton, MenuItem } from 'react-bootstrap';


export default class Home extends Component {
  render() {
    return (
      <div>
        <div className="container-fluid">
          <FormGroup>
            <InputGroup>
              <InputGroup.Button>
                <DropdownButton title="GET">
                  <MenuItem eventKey="1">Action</MenuItem>
                  <MenuItem eventKey="2">Another action</MenuItem>
                  <MenuItem eventKey="3" active>Active Item</MenuItem>
                  <MenuItem divider />
                  <MenuItem eventKey="4">Separated link</MenuItem>
                </DropdownButton>
              </InputGroup.Button>
              <FormGroup controlId="formValidationWarning1">
                <FormControl type="text" />
              </FormGroup>
              <InputGroup.Button>
                <Button bsStyle="success" className="search-button" >Send</Button>
              </InputGroup.Button>
            </InputGroup>
          </FormGroup>
        </div>
      </div>
    );
  }
}
