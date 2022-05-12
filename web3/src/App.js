import logo from './logo.svg';
import './App.css';
import { ethers } from 'ethers';
import { useState } from 'react';
import { Nav } from './nav';
import {Main} from './main';
;

function App() {
  const [account, setAccount] = useState([]);
  return (
  
    <div className="App">
     <Nav account = {account} setAccount = {setAccount}></Nav>
     <Main account = {account} setAccount = {setAccount}></Main>
    </div>
  );
}

export default App;
