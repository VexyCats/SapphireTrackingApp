import React from 'react'
import { Router, Route, BrowserHistory, IndexRoute } from 'react-router'
import ReactDOM from 'react-dom'
import App from './App'
import Web3 from 'web3'

import constants from './constants/contract.js'


 var  abi = constants.ABI;



 var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/uE6gfDzr3GtshFkgieHQ"));
 var address = constants.ADDRESS
 var sapphiresContract = web3.eth.contract(abi).at(address);
 let totalsupply = sapphiresContract.numTokensTotal();
 let sapphiresList = [];
console.log('Contract is set as ' + sapphiresContract);
//works
console.log('Owner is ' + sapphiresContract.owner.call());



	



function addItems(){
	totalsupply = Number(totalsupply)
	var i = '0';
	while(i < totalsupply){
	let sapphiresObject = sapphiresContract.sapphiresObj(i);
	sapphiresList.push({
		name: String(sapphiresObject[1]), 
		weight: Number(sapphiresObject[0]),
		price: Number(sapphiresObject[2]),
		certUrl: String(sapphiresObject[3]),
		picUrl: String(sapphiresObject[4])
	})

	console.log(sapphiresObject)
	i = i + 1;
	}
}


addItems();
 console.log(sapphiresList)





ReactDOM.render(
<App list={sapphiresList}/>,
  document.getElementById('root')
);
if (module.hot) {
module.hot.accept();
}
