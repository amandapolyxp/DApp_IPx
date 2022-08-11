const TicketContract = artifacts.require('./TicketContract.sol')

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('TicketContract', ([deployer, author, tipper]) => {
  let ticketContract

  before(async () => {
    ticketContract = await TicketContract.deployed()
  })

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await ticketContract.address
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

    it('has a name', async () => {
      const name = await ticketContract.name()
      assert.equal(name, 'Ticket Smart Contract Constructor')
    })
  })

  describe('tickets', async () => {
    let result, ticketCount

    before(async () => {
      result = await ticketContract.createTicket('Issue','This is my first ticket', { from: author })
      ticketCount = await ticketContract.ticketCount()
    })

    it('creates tickets', async () => {
      // SUCESS
      assert.equal(ticketCount, 1)
      const event = result.logs[0].args
      assert.equal(event.id.toNumber(), ticketCount.toNumber(), 'id is correct')
      assert.equal(event.content, 'This is my first ticket', 'content is correct')
      assert.equal(event._type, 'Issue', 'type is correct')
      assert.equal(event.tipAmount, '0', 'tip amount is correct')
      assert.equal(event.author, author, 'author is correct')

      // FAILURE: Post must have content
      await ticketContract.createTicket('Invalid','', { from: author }).should.be.rejected;
    })

  })
})

