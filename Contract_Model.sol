// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract myContract{

    enum  TicketStatus { 
        Pending, 
        Accepted, 
        Declined, 
        Concluded 
    }

    //Ticket[] private ticketsPerUser; 

    // example of mapping
    mapping(uint => Ticket) public ticketsPerUser;
    uint256 public ticketCount = 0;

    //address owner;

    /*modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }*/

    struct Ticket{
        uint _id;
        TicketStatus ticket;
        string _userName;
        //string _url;
        string _type;
    }

    /*constructor() public {
        owner = msg.sender;
    }*/

    // how to instance struct
    //Ticket tPerUser = Ticket(TicketStatus.Pending, "user", "default");


    // update info and THEN add to array

    function addTicket(string memory _userName, string memory _type) public{
        // aqui tens de colocar uma nova instacia para a estrutura pq senao sempre adicionara o tPerUser que é """imutavel"""
        TicketStatus ticket = TicketStatus.Pending;
        incrementCount();
        ticketsPerUser[ticketCount] = Ticket(ticketCount, ticket, _userName, _type);

    }
    // auto-increment ticket id
    function incrementCount() internal{
        ticketCount += 1;
    }

    // mapping with ticket id


    function pending(uint _tId) public {
 
        ticketsPerUser[_tId].ticket = TicketStatus.Pending; 
    }

    function isPending(uint _tId) public view returns(bool){
  
            return ticketsPerUser[_tId].ticket == TicketStatus.Pending;
    }

    function accept(uint _tId) public {

            ticketsPerUser[_tId].ticket = TicketStatus.Accepted;   
    }

    function isAccepted(uint _tId) public view returns(bool){

            return ticketsPerUser[_tId].ticket == TicketStatus.Accepted;      
    }

    function decline(uint _tId) public {

            ticketsPerUser[_tId].ticket = TicketStatus.Declined;     
    }

    function isDeclined(uint _tId) public view returns(bool){

            return ticketsPerUser[_tId].ticket == TicketStatus.Declined;   
    }

    function conclude(uint _tId) public {

            ticketsPerUser[_tId].ticket = TicketStatus.Concluded;     
    }

    function isConcluded(uint _tId) public view returns(bool){

        return ticketsPerUser[_tId].ticket == TicketStatus.Concluded;   
    }
}