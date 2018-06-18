import React, { Component } from 'react'
import { FormGroup, InputGroup, FormControl, Glyphicon } from 'react-bootstrap'
import bootstrap from 'react-bootstrap'
import Sapphires from '../build/contracts/Sapphires.json'
import getWeb3 from './utils/getWeb3'
import { BrowserRouter, Route, Link } from 'react-router-dom'
import SearchBar from './Components/SearchBar'
import SapphiresObject from './Components/SapphiresObject'



import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/less/bootstrap.less'
//import './bootstrap.css'

 import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'




class Closeup extends Component{
constructor(props){
super(props);

this.state = {
  value: this.props.objectID
}
}
render(){

 
  return (
    <div>
    {this.props.objectID}
    </div>
    )
}

}




class App extends Component {
  constructor(props) {
    super(props)


   
    this.state = {
      hidden: true,
      closeUpId: null,
      storageValue: 0,
      web3: null,
      coinbase: '0',
      list: []


    }
    this.props.list.map((item) =>{
      return( 
      this.state.list.push(item))
    })
  }

  componentWillMount() {
    console.log(this.state.listOfSapphires)
   
}
handleclick = (event) => {
  console.log(event)
}

  
  render() {
console.log(this.state.list)


      return (
      <div className="main">
       <BrowserRouter>
        <nav className="navbar pure-menu pure-menu-horizontal">
        

            <Link to='/' className="pure-menu-heading pure-menu-link">Home</Link>
            <Link to='/aboutus' className="pure-menu-heading pure-menu-link">About Us</Link>
            <Link to='/' className="pure-menu-heading pure-menu-link navbar-right">Reset Metmask</Link>
            <Route exact path='/aboutus' component={SearchBar} />
                   </nav>
</BrowserRouter>
        <main className="containerLarge">
          < SearchBar />
          <container className='multisapphirescontainer'>
         {this.state.list.map((item, key) => {
          return (
            <div className="col-sm-5" key={item.name}>
            <SapphiresObject  onClick={this.handleclick}  value={item}  /></div>)}) }
            
             </container>
             
        </main>
          
    
       </div> );
    }
   
   
            
}



export default App
