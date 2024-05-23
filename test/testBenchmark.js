const Benchmark = require("benchmark");
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const INFURA_API_KEY = `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`;
const fs = require("fs");
const contractJson = JSON.parse(
  fs.readFileSync("../build/contracts/Voting.json", "utf8")
);
const contractAbi = contractJson.abi;
const { Web3 } = require("web3");

const web3 = new Web3(INFURA_API_KEY);

const contractAddress = "0xf02aD093B043Df2115474A4A07e670Bd635018A5";
const contract = new web3.eth.Contract(contractAbi, contractAddress);

const account = web3.eth.accounts.privateKeyToAccount(PRIVATE_KEY);
web3.eth.accounts.wallet.add(account);

const suite = new Benchmark.Suite();

suite
  .add("vote", async function () {
    await contract.methods.vote(1).send({ from: account.address });
  })
  .on("cycle", function (event) {
    console.log(String(event.target));
  })
  .on("complete", function () {
    console.log(("Fastest is ", +this.filter("fastest").map("name")));
  })
  .run({ async: true });
