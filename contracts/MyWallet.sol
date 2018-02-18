pragma solidity ^0.4.17;
import "./mortal.sol";

contract MyWallet is mortal{
    event receiveFunds(address indexed _from, uint _amount);
    event proposalReceived(address indexed _from, address indexed _to, string _reason);
    uint proposalcounter;
    struct Proposal{
        address _from;
        address _to;
        uint256 _value;
        string _reason;
        bool sent;
    }
    
    mapping(uint=>Proposal) m_Proposals;
    
    function sendMoneyOn(address _to, uint256 _value, string _reason) public returns(uint256){
        if(owner==msg.sender){
            bool sent=_to.send(_value);
            if(!sent){
                revert();
            }
        }
        else{
            proposalcounter++;
            m_Proposals[proposalcounter]=Proposal(msg.sender,_to,_value,_reason,false);
            proposalReceived(msg.sender,_to, _reason);
            return proposalcounter;
        }
    }
    
    function confirmProposal(uint256 prop_id) onlyowner public returns(bool){
        Proposal prop=m_Proposals[prop_id];
        if(prop._from!=address(0)){
            if(prop.sent!=true){
                prop.sent=true;
                if(prop._to.send(prop._value)){
                    return true;
                }
                prop.sent=false;
                return false;
            }
        }
    }
    function() payable public {
        if(msg.value>0){
            receiveFunds(msg.sender,msg.value);
        }
    }
}
