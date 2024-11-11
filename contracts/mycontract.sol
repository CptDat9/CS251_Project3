// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW
mapping (address => uint) private lastActived;
// Save the time that user last activated.
mapping (address => uint) private totalOwed;
// Total money that user owed.
address[] private allUsers;
// list of users
mapping (address => mapping(address => uint)) private owe;
// mapping monitor debt from an user to another user
mapping (address => bool) private userCheck;
// Check the user that he/she is a member of List of users.
mapping (address => address[]) private neighbours;

function add_IOU(address _creditor, uint _amount) public{
    address _sender = msg.sender;
    // Cập nhật _sender = msg.sender (msg.sender là biến toàn cục của sol chỉ người gửi)
    lastActived[_sender] = block.timestamp;
    // Cập nhật thời gian hoạt động cuối của _sender theo thời gian gen của block (block.timestamp)
    totalOwed[_sender]+= _amount;
    // Cập nhật tổng số tiền _sender nợ _creditor (thêm _amount)
    if(!userCheck[_sender]){
        // Xem _sender có trong hệ thống chưa
        userCheck[_sender] = true;
        allUsers.push(_sender);
        neighbours[_sender].push(_creditor);
    }
    if(!userCheck[_creditor]){
        // Kiểm tra _creditor có trên hệ thống chưa
    userCheck[_creditor] = true;
    allUsers.push(_creditor);
    }
    owe[_sender][_creditor] = _amount;
    // cập nhật nợ của _sender với _creditor là _amount.
    owe[_creditor][_sender] = 0;
    // Không cho nợ ngược lại
}
function getAllUser() public view returns(address[] memory){
    return allUsers;
}
function getTotalOwed(address user) public view returns(uint){
    return totalOwed[user];
}
function getLastActive(address user)public view returns(uint){
    return lastActived[user];
}
function getAddress()public view returns(address){
    return msg.sender;
}
function getCreditor(address node) public view returns(address[] memory){
    return neighbours[node];
}
function lookup(address debtor , address creditor) public view returns (uint){
     return owe[debtor][creditor];
} 

}
//     /* BẢN NGẮN HƠN */      //    
//-----------------------------//
/*
contract Splitwise {
    //debtbook['debtor']['creditor']
    mapping(address => mapping(address => uint32)) debtbook;

    function lookup(address debtor, address creditor) external view returns (uint32 ret){
        return debtbook[debtor][creditor];
    }
    function add_IOU_chain(address creditor, uint32 amount, address[] calldata path, uint32 flow) external{
        require(amount > 0, "transaction amount must be positive!");

        require(creditor != msg.sender, "debtor and creditor cannot be the same!");

        require(path[0] == path[path.length-1]);

        debtbook[msg.sender][creditor] += amount;
  
        if(flow > 0){

            require(path[0]==path[path.length - 1], "path must be a loop!");
            for(uint i = 0;i < path.length - 1;i++){
                
                require(debtbook[path[i]][path[i+1]] >= flow, "loop incomplete!");
             
                debtbook[path[i]][path[i+1]] -= flow;
            }
        }
    }
}
*/
