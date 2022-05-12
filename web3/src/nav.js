import React from 'react'

export const Nav = ({account, setAccount}) => {

    let isConnected = false;

    const {ethereum} = window.ethereum;

    async function connectWallet()
    {
    if(ethereum)
    {
        const accounts = ethereum.request({ methid: "eth_requestAccounts "});
        setAccount(accounts[0]);
        isConnected = true;
    }
}

  return (
    <div>
        <div>Facebook</div>
        <div>Twitter</div>
        <div>Instagram</div>

        {isConnected? (
            <p>Connected</p>
        ): 
        (<button onClick={connectWallet}> Connect</button>)
        }
    </div>
  )
}
