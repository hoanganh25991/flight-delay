/**
 * FlightDelay with Oraclized Underwriting and Payout
 *
 * @description	Ledger contract
 * @copyright (c) 2017 etherisc GmbH
 * @author Christoph Mussenbrock
 */

pragma solidity ^0.4.11;

import "./FlightDelayControlledContract.sol";
import "./FlightDelayAccessControllerInterface.sol";
import "./FlightDelayDatabaseInterface.sol";
import "./FlightDelayLedgerInterface.sol";
import "./FlightDelayConstants.sol";


contract FlightDelayLedger is FlightDelayControlledContract, FlightDelayLedgerInterface, FlightDelayConstants {

    FlightDelayDatabaseInterface FD_DB;
    FlightDelayAccessControllerInterface FD_AC;

    function FlightDelayLedger(address _controller) public {
        setController(_controller);
    }

    function setContracts() public onlyController {
        FD_AC = FlightDelayAccessControllerInterface(getContract("FD.AccessController"));
        FD_DB = FlightDelayDatabaseInterface(getContract("FD.Database"));

        FD_AC.setPermissionById(101, "FD.NewPolicy");
        FD_AC.setPermissionById(101, "FD.Controller"); // todo: check!

        FD_AC.setPermissionById(102, "FD.Payout");
        FD_AC.setPermissionById(102, "FD.NewPolicy");
        FD_AC.setPermissionById(102, "FD.Controller"); // todo: check!
        FD_AC.setPermissionById(102, "FD.Underwrite");
        FD_AC.setPermissionById(102, "FD.Owner");

        FD_AC.setPermissionById(103, "FD.Funder");
        FD_AC.setPermissionById(103, "FD.Underwrite");
        FD_AC.setPermissionById(103, "FD.Payout");
        FD_AC.setPermissionById(103, "FD.Ledger");
        FD_AC.setPermissionById(103, "FD.NewPolicy");
        FD_AC.setPermissionById(103, "FD.Controller");
        FD_AC.setPermissionById(103, "FD.Owner");

        FD_AC.setPermissionById(104, "FD.Funder");
    }

    /*
     * @dev Fund contract
     */
    function () public payable {
        require(FD_AC.checkPermission(104, msg.sender));

        bookkeeping(Acc.Balance, Acc.RiskFund, msg.value);
    }

    function withdraw(uint256 _amount) {
        require(FD_AC.checkPermission(104, msg.sender));
        require(this.balance >= _amount);

        bookkeeping(Acc.RiskFund, Acc.Balance, _amount);

        getContract("FD.Funder").transfer(_amount);
    }

    function receiveFunds(Acc _to) public payable {
        require(FD_AC.checkPermission(101, msg.sender));

        LogReceiveFunds(msg.sender, uint8(_to), msg.value);

        bookkeeping(Acc.Balance, _to, msg.value);
    }

    function sendFunds(address _recipient, Acc _from, uint _amount) public returns (bool _success) {
        require(FD_AC.checkPermission(102, msg.sender));

        if (this.balance < _amount) {
            return false; // unsufficient funds
        }

        LogSendFunds(_recipient, uint8(_from), _amount);

        bookkeeping(_from, Acc.Balance, _amount); // cash out payout

        if (!_recipient.send(_amount)) {
            bookkeeping(Acc.Balance, _from, _amount);
            _success = false;
        } else {
            _success = true;
        }
    }

    // invariant: acc_Premium + acc_RiskFund + acc_Payout + acc_Balance + acc_Reward + acc_OraclizeCosts == 0

    function bookkeeping(Acc _from, Acc _to, uint256 _amount) public {
        require(FD_AC.checkPermission(103, msg.sender));

        // check against type cast overflow
        assert(int256(_amount) > 0);

        // overflow check is done in FD_DB
        FD_DB.setLedger(uint8(_from), -int(_amount));
        FD_DB.setLedger(uint8(_to), int(_amount));
    }
}
