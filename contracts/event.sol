// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Bank {

    mapping(address => uint256) public balances;
    
    event Deposit (address indexed user, uint256 amount);
    event Withdraw (address indexed user, uint256 amount);

    //Fonction Déposer de l'argent sur le contrat
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        
        // Appeler l'event Deposit
        emit Deposit(msg.sender, msg.value);
    }

    // Fonction de retrait de token
    function withdraw(uint256 _amount) external {
        //Requis > si la balance est supérieure à zéro
        // Ceci empêche l'addresse de réclamer plus que disponible sur l'adresse
        // Même si //balance revert c'est une protection non négligeable 
        require(balances[msg.sender] >= _amount, "vous n'avez pas d'argent = crevardise");
        //Sec la balance en remettant à zéro 
        balances[msg.sender] -= _amount; 
        (bool sent,) = payable(msg.sender).call{value: balances[msg.sender]}("");
        require(sent, "failed");
        
        // Appeler l'event Withdraw
        emit Withdraw(msg.sender, _amount);

    }

    //verifier le solde
    function getBalance(address _user) external view returns(uint256) {
        return balances[_user];
    }
}