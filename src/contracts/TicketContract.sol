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

    //Ticket[] private ticketsPerUser; 

    // example of mapping
    mapping(uint => Ticket) public tickets;
    uint public ticketCount = 0;

    //address owner;

    /*modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }*/

    struct Ticket{
        uint _id;
        TicketStatus ticket;
        address author;
        uint tipAmount;
        //string _url;
        string _type;
        string _content;
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address author; // this information is given by Solidity as msg.sender
    }

    event TicketCreated(
        uint id,
        string content,
        string _type,
        uint tipAmount,
        address author
    );

    function createTicket(string memory _type, string memory _content) public{
        // Require valid content
        require(bytes(_content).length > 0);
        TicketStatus ticket = TicketStatus.Pending;
        incrementCount();
        tickets[ticketCount] = Ticket(ticketCount, ticket, msg.sender, 0, _type, _content);
        emit TicketCreated(ticketCount, _content, _type, 0, msg.sender);
    }

    /*constructor() public {
        owner = msg.sender;
    }*/

    // how to instance struct
    //Ticket tPerUser = Ticket(TicketStatus.Pending, "user", "default");


    // update info and THEN add to array

    // auto-increment ticket id
    function incrementCount() internal{
        ticketCount += 1;
    }

    // mapping with ticket id


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