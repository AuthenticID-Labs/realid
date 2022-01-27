// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;


contract ZKAgeProof {
    struct ProofPackage {
        bytes32 proof;
        uint timestamp;
    }
    mapping(address => ProofPackage) public proofs;
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    function addProof(address toAdd, bytes32 proof) public {
        require(msg.sender == owner, "owner only");
        proofs[toAdd] = ProofPackage({proof: proof, timestamp: block.timestamp});
    }

    function getProof(address subject) public view returns (bytes32 proof, uint timestamp) {
        ProofPackage memory pp = proofs[subject];
        return (pp.proof, pp.timestamp);
    }
}