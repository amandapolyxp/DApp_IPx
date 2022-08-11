// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SocialNetwork {
    // State variable
    string public name;
    uint public postCount = 0;
    

    // Constructor function
    constructor (){
        name = "Test bed for bc project testing folders";
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address author; // this information is given by Solidity as msg.sender
    }

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address author
    );

    mapping(uint => Post) public posts;

    function createPost(string memory _content) public{
        // Require valid content
        require(bytes(_content).length > 0);
        postCount ++;
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        emit PostCreated(postCount, _content, 0, msg.sender);
    }
}