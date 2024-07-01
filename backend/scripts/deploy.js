const { ethers } = require("hardhat");

async function main() {
  const Solstice = await ethers.getContractFactory("Solstice");

  const Solstice_ = await Solstice.deploy();

  console.log("Contract address:", Solstice_.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
