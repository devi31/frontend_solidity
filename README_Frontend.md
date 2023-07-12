# Function Frontend
This project demonstrates how to connect solidity contract to the frontend.

![Screenshot (521)](https://github.com/devi31/frontend_solidity/assets/52243140/9f307366-03ad-422b-aa40-627627f581f8)

## Pre-requisites
1. Install metamask and connect it to the local host to get some free test ethers.
2. Install npm package

## Description

This project is a simple example of how to interact with a smart contract from a frontend.
The HTML code provided is a simple frontend for a smart contract. The contract has three functions: getInitialValue, addition, and subtract. The getInitialValue function returns the initial value of the contract. The addition function adds a specified amount to the initial value, and the subtract function subtracts a specified amount from the initial value.

The frontend code uses the web3 library to interact with the smart contract. The web3.eth.requestAccounts function gets the list of accounts that the user has access to. The contract.methods.addition(value).send({ from: account }) function calls the addition function on the contract, and the value parameter is the amount to be added. The result.events.ValueChanged.returnValues[0] property returns the new value of the contract.

The add and subtract functions in the frontend code use the web3.eth.requestAccounts function to get the user's account, and then they call the corresponding function on the contract. The new value of the contract is then displayed on the frontend.

 

## Getting Started

### Connecting metamask to localhost

#### Using hardhat method
    STEP 1: Setting Up Project Structure: Create a project named **any name**. Next, open the project folder on the terminal or simply navigate to that directory and run the following commands:

                  cd <project name>
                  npm init --y

STEP 2: Creating Hardhat Project: Install the Hardhat packages that enable you to run a blockchain server, on the terminal, run the following commands:

                  npm install hardhat

After the installation, run the hardhat command below:
                    
                    npx hardhat

STEP 3: Running Hardhat Server: On completion of the installation, again run this command to spin up the Hardhat blockchain server:


                    npx hardhat node
STEP 4: Configuring Network: open metamask, add network details, with host name as: LocalHost8545, id as:31337.

STEP 6: Importing Accounts: From step 3, copy the first private key for the account zero (0) and paste it import account option.

With this one-time process implemented, anytime you spin up your Hardhat blockchain server, your account will be updated with a fresh 10,000 ETH balance.

### Executing Solidity program

To run the program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
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

```
after successful compilation. Go to deploy option:
--> under the environment section, select Inject provider which connects it to the metatamask account.
now, click on deploy button, it will ask for permission , some amount of ether will be deducted from the account.

### Connecting Frontend with solidity contract

The Frontend code is using HTML, JavaScript, and Web3.js library to connect to the Solidity contract:
```
<!DOCTYPE html>
<html>
<head>
    <title>Frontend Example</title>
    <script src="https://cdn.jsdelivr.net/npm/web3@1.5.0/dist/web3.min.js"></script>
</head>
<body>
    <h1>Operations Contract</h1>
    <div>
        <label>Initial Value: </label>
        <span id="initialValue"></span>
    </div>
    <br>
    <div>
        <label>Add Amount: </label>
        <input type="number" id="addInput">
        <button onclick="add()">Add</button>
    </div>
    <br>
    <div>
        <label>Subtract Amount: </label>
        <input type="number" id="subtractInput">
        <button onclick="subtract()">Subtract</button>
    </div>

    <script>
        // Check if MetaMask is installed
        if (typeof web3 !== 'undefined') {
            web3 = new Web3(web3.currentProvider);
        } else {
            alert("Please install MetaMask to use this application!");
        }

        // Contract ABI (Application Binary Interface)
        var contractABI = [
            {
                "constant": true,
                "inputs": [],
                "name": "getInitialValue",
                "outputs": [
                    {
                        "name": "",
                        "type": "int256"
                    }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "value",
                        "type": "int256"
                    }
                ],
                "name": "subtract",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "value",
                        "type": "int256"
                    }
                ],
                "name": "addition",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            }
        ];

        // Contract address deployed on Remix
        var contractAddress = '<YOUR_CONTRACT_ADDRESS>';

        // Instantiate the contract
        var contract = new web3.eth.Contract(contractABI, contractAddress);

        // Get and display the initial value
        contract.methods.getInitialValue().call().then(function(result) {
            document.getElementById('initialValue').textContent = result;
        });

        // Add function
        function add() {
            var value = parseInt(document.getElementById('addInput').value);
            web3.eth.requestAccounts()
            .then(function(accounts) {
                var account = accounts[0];
                contract.methods.addition(value).send({ from: account })
                .then(function(result) {
                    // Update the initial value on the frontend
                    document.getElementById('initialValue').textContent = result.events.ValueChanged.returnValues[0];
                });
            })
            .catch(function(error) {
                console.error(error);
            });
        }

        // Subtract function
        function subtract() {
            var value = parseInt(document.getElementById('subtractInput').value);
            web3.eth.requestAccounts()
            .then(function(accounts) {
                var account = accounts[0];
                contract.methods.subtract(value).send({ from: account })
                .then(function(result) {
                    // Update the initial value on the frontend
                    document.getElementById('initialValue').textContent = result.events.ValueChanged.returnValues[0];
                });
            })
            .catch(function(error) {
                console.error(error);
            });
        }
    </script>
</body>
</html>
```

In this code, after checking if MetaMask is installed, it requests the user's accounts using web3.eth.requestAccounts(). The user will be prompted by MetaMask to connect and authorize the application to interact with their accounts. Once authorized, the selected account is used to send transactions to the contract.

remember to replace <YOUR_CONTRACT_ADDRESS> with the actual address of your deployed contract on Remix.

### Getting Results

   #### using VScode editor 

Set up a local development environment:

1.You'll need a local development environment to serve the HTML file. One popular choice is to use a web server like http-server.

2.Install http-server globally by running npm install -g http-server.

3.Navigate to the directory where your HTML file is located using the command line.

4.Start the local server by running http-server.

5.The server will start and display the URL where your application is hosted .

## Authors

Contributors names and contact info
 [B devi](devibattini@gmail.com)


## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
