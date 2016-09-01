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
              <FormControl />
              <InputGroup.Button>
                <Button className="search-button" ><Glyphicon glyph="search"/>Search</Button>
              </InputGroup.Button>
            </InputGroup>
          </FormGroup>
        </div>
      </div>
    );
  }
}
