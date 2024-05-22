const Voting  = require("Voting")
const { expect } = require('chai')

contract("Voting", accounts => {
    let votingInstance;

    beforeEach(async() => {
        votingInstance = await Voting.deployed();
    })

    it('Should add candidate', async() => {
        await votingInstance.addCandidate("Aldi", "Deskripsi dari aldi", { form: accounts[0] })
        const candidate = await votingInstance.getCandidate(3)
        expect(candidate.name).to.equal("Aldi")
        expect(candidate.deskripsi).to.equal("Deskripsi dari aldi")
        expect(candidate.voteCount.toString()).to.equal("0")
    });
    
})