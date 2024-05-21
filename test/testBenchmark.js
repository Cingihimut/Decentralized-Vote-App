const Benchmark = require("benchmark");
const fs = require("fs");
const contractJson = JSON.parse(
  fs.readFileSync("../build/contracts/Voting.json", "utf8")
);
const contractAbi = contractJson.abi;
const { Web3 } = require("web3");

const web3 = new Web3(
  "https://sepolia.infura.io/v3/16f433e205934f658b47af8449c3e512"
);

const abi = contractAbi;
const contractAddress = "0xf02aD093B043Df2115474A4A07e670Bd635018A5";
const contract = new web3.eth.Contract(contractAbi, contractAddress);

const privateKey =
  "0x2a5f064003361787f9a05dd0daa7927ce6d45112d8c2120ef231cbe27271bd20";
const account = web3.eth.accounts.privateKeyToAccount(privateKey);
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
