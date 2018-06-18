import React, { Component } from 'react'
import {App}  from '../App.js'
import './Sapphires.css'



class SapphiresObject extends Component{

handleClick(event) {
 
  this.props.onClick(this.props.value.name)
}


render(){
//
this.handleClick = this.handleClick.bind(this);

const style = {
  
    border: '1px solid', /* Gray border */
    borderRadius: '4px',  /* Rounded border */
    padding: '5px', /* Some padding */
    width: '150px', /* Set a small width */

};
  return (
    <div className="row row-horizon">
  <div>
   
 

   <div className="card" onClick={this.handleClick}>
    <h1 className="cardTitle">{this.props.value.name}</h1>
    <h6 className="card-subtitle mb-2 text-muted">{this.props.value.weight} carats</h6>
    <img src="https://i.imgur.com/8TsPmtS.jpg" style={style} className="pic"></img>
       <div className="row">
    <li>
    <a href="#" className="card-link">Certificate link</a>
    </li>
    </div>
</div>

  </div>
</div>

    )
}

}

export default SapphiresObject