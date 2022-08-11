// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TicketContract{

    string public name;

    constructor(){
        name = 'Ticket Smart Contract Constructor';
    }

    enum  TicketStatus { 
        Pending, 
        Accepted, 
        Declined, 
        Concluded 
    }

    mapping(uint => Ticket) public tickets;
    uint public ticketCount = 0;

    struct Ticket{
        uint _id;
        TicketStatus ticket;
        address author;
        uint tipAmount;
        //string _url;
        string _type;
        string _content;
    }

    event TicketCreated(
        uint id,
        string content,
        string _type,
        uint tipAmount,
        address payable author
    );
    event RoadsTipped(
        uint id,
        string content,
        string _type,
        TicketStatus ticket,
        uint tipAmount,
        address payable author
    );


    function createTicket(string memory _type, string memory _content) public{
 
        require(bytes(_content).length > 0);
        TicketStatus ticket = TicketStatus.Pending;
        incrementCount();
        tickets[ticketCount] = Ticket(ticketCount, ticket, msg.sender, 0, _type, _content);
        emit TicketCreated(ticketCount, _content, _type, 0, payable(msg.sender));
    }

    function tipRoads(uint _id) public payable{

        require(_id > 0 && _id <= ticketCount);
        Ticket memory _ticket = tickets[_id];
        address payable _author = payable(_ticket.author);
        _author.transfer(msg.value);
        _ticket.tipAmount = _ticket.tipAmount + msg.value;
        tickets[_id] = _ticket;
        emit RoadsTipped(ticketCount, _ticket._content, _ticket._type,_ticket.ticket, _ticket.tipAmount, payable(_ticket.author));

    }
    
    function incrementCount() internal{
        ticketCount += 1;
    }

    function pending(uint _tId) public {
 
        tickets[_tId].ticket = TicketStatus.Pending; 
    }

    function isPending(uint _tId) public view returns(bool){
  
            return tickets[_tId].ticket == TicketStatus.Pending;
    }

    function accept(uint _tId) public {

            tickets[_tId].ticket = TicketStatus.Accepted;   
    }

    function isAccepted(uint _tId) public view returns(bool){

            return tickets[_tId].ticket == TicketStatus.Accepted;      
    }

    function decline(uint _tId) public {

            tickets[_tId].ticket = TicketStatus.Declined;     
    }

    function isDeclined(uint _tId) public view returns(bool){

            return tickets[_tId].ticket == TicketStatus.Declined;   
    }

    function conclude(uint _tId) public {

            tickets[_tId].ticket = TicketStatus.Concluded;     
    }

    function isConcluded(uint _tId) public view returns(bool){

        return tickets[_tId].ticket == TicketStatus.Concluded;   
    }
}