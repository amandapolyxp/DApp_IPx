// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SocialNetwork {

    string public name;
    uint public postCount = 0;

    constructor (){
        name = "Test bed for bc project testing folders";
    }

    struct Post {
        uint id;
        string content;
        uint tipAmount;
        address author; 
    }

    event PostCreated(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    event PostTipped(
        uint id,
        string content,
        uint tipAmount,
        address payable author
    );

    mapping(uint => Post) public posts;

    function createPost(string memory _content) public{
        require(bytes(_content).length > 0);
        postCount ++;
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        emit PostCreated(postCount, _content, 0, payable(msg.sender));
    }


    function tipPost(uint _id) public payable{
        Post memory _post = posts[_id];
        address _author = _post.author;
        payable(_author).transfer(msg.value);
        _post.tipAmount = _post.tipAmount + msg.value;
        posts[_id] = _post;
        emit PostTipped(postCount, _post.content, _post.tipAmount, payable(_post.author));
    }
}