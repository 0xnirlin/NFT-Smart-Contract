const hre = require("hardhat");

async function main() {
 
  const [owner,addr1, addr2, addr3, addr4] = await ethers.getSigners();
  const Greeter = await hre.ethers.getContractFactory("BroPepe");
  const greeter = await Greeter.deploy();



  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);

  let totalSupply = await greeter.totalSupply();

  console.log("Total Supply", totalSupply.toString());
  //first start the mint
  let enableTxn = await greeter.setIsPublicMintEnabled(true); //enabled
  await enableTxn.wait() //wait for the transaction to complete.

  //setting the wl addresses
  let enableAddress = await greeter.setWlAddress();
  //wait for transaction to process
  await enableAddress.wait();

  //minting fron owner
  await greeter.connect(addr1).mint(1, {value: ethers.utils.parseEther("0.02")});
  console.log("Total Supply", totalSupply.toString());
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
