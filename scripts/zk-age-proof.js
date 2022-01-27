const ethers = require('ethers');
const BigNumber = require('ethers').BigNumber;
const {doZKProof, getZKHash, getZKProof} = require('@authenticid-labs/zk-age-proof');


// const CONTRACT_ADDRESS = "0x6630C92AeaAbd97Cd2952B4F18791D6Cf17cAfc0";
const wallet = '0x07f1fb513EEFB2dA17ff90a200859Bdae52f0bb3';

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const signer = await hre.ethers.getSigner();
  const {proof, timestamp} = await getZKProof(signer, wallet);

  const hash = getZKHash(25, new Date(timestamp*1000), new Date('18/Mar/1968'), 'ROBERT SHAWN MITCHELL');
  const success = doZKProof(25, hash, proof);
  console.log('Proof result: ', success);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
