// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Neah game learning solidity / Did System
// Convention _privateVariable avec un prefix underscore

contract Bank {

    mapping(address => uint256) public balances;
    


    // permet d'inscrire des logs sur la blockchain
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

    // permet des action sur la VM sans gas si inscription sur la blockchain. C
    // Permet de faire un double check pour vérifier les datas du front 
    function addition(uint256 value_A, uint256 value_B) external pure returns(uint256){
        return value_A + value_B;
    }
}