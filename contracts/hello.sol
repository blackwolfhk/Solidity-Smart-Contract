pragma solidity ^0.8.13;

contract MyFirstContract{
    string publiuc hey = "Hey Kelvin";
    unit256 public no = 4;

    // constructor(string memory _hey, unit_no){
    //     hey = _hey;
    //     no = _no;
    // }

    function addInfo(string memory _hey,uint _no) public {
        hey = _hey;
        no = _no;
    }
}