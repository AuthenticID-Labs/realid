const ethers = require('ethers');
const BigNumber = require('ethers').BigNumber;

const CONTRACT_ADDRESS = "0xA0C7Aaf36175B62663a4319EB309Da47A19ec518";


async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  const price = BigNumber.from(ethers.utils.parseEther("0.01"));

  // We get the contract to deploy
  const myRegistrar = await hre.ethers.getContractAt("MyRegistrar", CONTRACT_ADDRESS, await hre.ethers.getSigner());
  
  const bal = await myRegistrar.balance();
  console.log("MyRegistrar balance : ", bal);
  //const success = await myRegistrar.withdraw(bal);
  //console.log(success);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
