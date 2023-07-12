// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Operations{
    int InitialValue=1;

    function getInitialValue() view public returns(int)
    {
        return InitialValue;
    }

    function subtract(int value) public
    {
        InitialValue=InitialValue-value;
    }

    function addition(int value) public
    {
       InitialValue=InitialValue+value;
    }
}
