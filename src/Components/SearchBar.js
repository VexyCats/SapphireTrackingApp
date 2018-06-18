import React, { Component } from 'react'
import { FormGroup, InputGroup, FormControl, Glyphicon } from 'react-bootstrap'

class SearchBar extends Component{
constructor(props){
super(props);

this.state = {
  value: ''
}
}
render(){

 
  return (
    <div>
    <FormGroup>
    <InputGroup>
    <FormControl
    type="text"
    placeholder="Search"
    value={this.state.value}
    onChange={event => {this.setState({value: event.target.value})}}/>
    <InputGroup.Addon>
    <Glyphicon glyph="search"></Glyphicon>
    </InputGroup.Addon>
    </InputGroup>
    </FormGroup>
    {this.state.value}
    </div>
    )
}

}
export default SearchBar