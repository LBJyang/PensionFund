// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract PensionFund is ReentrancyGuard, Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    using ECDSA for bytes32;

    uint256 public startAge; //the first you doposit your pension.
    uint256 public retirementAge; //expect retire time
    uint256 public lifeExpectancy; //expect life expectancy
    uint256 public monthlyDeposit; //amount deposit per month
    uint256 public monthlyPension; //amount of money will be sent out after retired
    address public payoutWallet; //the wallet which will get the pension.
    IERC20 public token; //the deposit token,it can be stable token like udst,or the famous token like wbtc\eth.
    uint256 public gaps = 1; //the months num the onwer miss the diposit or withdraw.
    uint256 public totalPensions; //the total money that had been deposit in the contract.
    address[] public signers; //the signers
    uint8 public threshold; //multisig the threshold

    uint256 constant SECONDS_PER_DAY = 24 * 60 * 60;
    uint256 constant SECONDS_PER_YEAR = 365 * SECONDS_PER_DAY;
    uint256 constant SECONDS_PER_LEAP_YEAR = 366 * SECONDS_PER_DAY;
    //EIP712 multisig Info
    bytes32 private constant EIP712DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
    bytes32 private constant INFO_TYPEHASH =
        keccak256(
            "Info(address signer,uint256 retirementAge,uint256 lifeExpectancy,address payoutWallet,uint256 totalPensions)"
        );
    bytes32 private DOMAIN_SEPARATOR;

    struct Date {
        uint256 year;
        uint256 month;
    }
    Date public lastDate; //the last deposit whether deposit or withdraw.

    event Deposit(
        address indexed user,
        uint256 indexed amount,
        uint256 indexed months
    );
    event Withdraw(address indexed user, uint256 indexed amount);
    event Payout(
        address indexed to,
        uint256 indexed amount,
        uint256 indexed month
    );

    constructor(
        uint256 _retirementAge,
        uint256 _lifeExpectancy,
        uint256 _monthlyDeposit,
        address _token,
        address _payoutWallet,
        address[] memory _signers,
        uint8 _threshold,
        uint256 _totalPensions
    ) Ownable(msg.sender) {
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                EIP712DOMAIN_TYPEHASH, // type hash
                keccak256(bytes("PensionFund")), // name
                keccak256(bytes("1")), // version
                block.chainid, // chain id
                address(this) // contract address
            )
        );
        retirementAge = _retirementAge;
        lifeExpectancy = _lifeExpectancy;
        monthlyDeposit = _monthlyDeposit;
        token = IERC20(_token);
        payoutWallet = _payoutWallet;
        signers = _signers;
        threshold = _threshold;
        totalPensions = _totalPensions;
    }

    /**
     * The deposit function can be trigged by dapp in a confirm way.
     * Msg.sender send monthlyDeposit to the contract address.
     * Add the totalPension.
     * If you missed your contributions for the previous months, you will need to make a lump-sum payment this time to catch up.
     */
    function deposit() public nonReentrant {
        require(
            block.timestamp < retirementAge,
            "You have retired.Do not need to deposit."
        );
        Date memory rightnow = getYearAndMonth(block.timestamp);
        if (lastDate.year != 0) {
            uint256 lastMonths = lastDate.year * 12 + lastDate.month;
            uint256 rightnowMonths = rightnow.year * 12 + rightnow.month;
            require(rightnowMonths > lastMonths, "You have done the deposit.");
            gaps = rightnowMonths - lastMonths;
        } else {
            startAge = block.timestamp;
        }
        token.safeTransferFrom(
            payable(msg.sender),
            address(this),
            monthlyDeposit * gaps
        );
        totalPensions = totalPensions.add(monthlyDeposit * gaps);
        emit Deposit(msg.sender, monthlyDeposit, gaps);
        lastDate = rightnow;
    }

    /**
     * the withdraw action.
     * when the time > retiredTime,calculateMonthlyPension.set lastDate to retiredDate.
     * if you did not claim your pension before,you can get your pension in sum.
     */
    function payout() public nonReentrant {
        require(
            block.timestamp > retirementAge,
            "You havn't retired.You can't withdraw."
        );
        //the first time wihtdraw the pension,set the monthlyPension.
        Date memory retiredDate = getYearAndMonth(retirementAge);
        Date memory rightnow = getYearAndMonth(block.timestamp);
        if (lastDate.month < retiredDate.month) {
            monthlyPension = calculateMonthlyPension();
            lastDate = retiredDate;
        }
        uint256 lastMonths = lastDate.year * 12 + lastDate.month;
        uint256 rightnowMonths = rightnow.year * 12 + rightnow.month;
        require(rightnowMonths > lastMonths, "You have done the withdraw.");
        gaps = rightnowMonths - lastMonths;

        token.safeTransferFrom(
            address(this),
            payoutWallet,
            monthlyPension * gaps
        );
        totalPensions = totalPensions.sub(monthlyPension * gaps);
        emit Payout(payoutWallet, monthlyPension, gaps);
    }

    function changeRetirementAge(
        uint256 _retirementAge,
        bytes32[] memory digests,
        bytes[] memory signatures
    ) public checkThreshold(digests, signatures) {
        retirementAge = _retirementAge;
    }

    function changeLifeExpectancy(
        uint256 _lifeExpectancy,
        bytes32[] memory digests,
        bytes[] memory signatures
    ) public checkThreshold(digests, signatures) {
        lifeExpectancy = _lifeExpectancy;
    }

    function changePayoutWallet(
        address _payoutWallet,
        bytes32[] memory digests,
        bytes[] memory signatures
    ) public checkThreshold(digests, signatures) {
        payoutWallet = _payoutWallet;
    }

    function withdrawPension(
        address withdrawAddress,
        bytes32[] memory digests,
        bytes[] memory signatures
    ) public checkThreshold(digests, signatures) {
        payable(withdrawAddress).transfer(totalPensions);
    }

    /**
     * If there is any defi method to improve the pension,this method can be changed at anytime.
     * Next step,maybe use aave or something else to do that,that's for update.
     */
    function calculateMonthlyPension() private view returns (uint256) {
        Date memory deathDate = getYearAndMonth(lifeExpectancy);
        Date memory retiredDate = getYearAndMonth(retirementAge);
        uint256 monthsWithdraw = (deathDate.year - retiredDate.year) *
            12 +
            deathDate.month -
            retiredDate.month;
        return totalPensions / monthsWithdraw;
    }

    //get the year and month
    function getYearAndMonth(uint256 timestamp)
        public
        pure
        returns (Date memory)
    {
        uint16 year = 1970;
        uint256 ds = timestamp / SECONDS_PER_DAY;

        while (true) {
            uint256 daysInYear = isLeapYear(year) ? 366 : 365;
            if (ds < daysInYear) {
                break;
            }
            ds -= daysInYear;
            year += 1;
        }

        uint256[12] memory daysInMonth = [
            uint256(31),
            28,
            31,
            30,
            31,
            30,
            31,
            31,
            30,
            31,
            30,
            31
        ];

        if (isLeapYear(year)) {
            daysInMonth[1] = 29;
        }

        uint256 month;
        for (month = 0; month < 12; month++) {
            if (ds < daysInMonth[month]) {
                break;
            }
            ds -= daysInMonth[month];
        }

        month++;

        return Date(year, month);
    }

    function isLeapYear(uint16 year) private pure returns (bool) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    /**
     * Multisig check.If the signatures num is not get the threshold,reject the request.
     */
    modifier checkThreshold(
        bytes32[] memory digests,
        bytes[] memory signatures
    ) {
        checkSig(digests, signatures);
        _;
    }

    function checkSig(bytes32[] memory digests, bytes[] memory signatures)
        private
        view
    {
        require(signatures.length >= threshold, "Not enough signatures");
        uint256 signerNum = 0;
        for (uint256 i = 0; i < signatures.length; i++) {
            bytes memory sig = signatures[i];
            require(sig.length == 65, "invalid signature length");
            bytes32 r;
            bytes32 s;
            uint8 v;
            assembly {
                r := mload(add(sig, 0x20))
                s := mload(add(sig, 0x40))
                v := byte(0, mload(add(sig, 0x60)))
            }

            address signer = digests[i].recover(v, r, s);
            // check the digest.
            bytes32 digest = keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    DOMAIN_SEPARATOR,
                    keccak256(
                        abi.encode(
                            INFO_TYPEHASH,
                            signer,
                            retirementAge,
                            lifeExpectancy,
                            payoutWallet,
                            totalPensions
                        )
                    )
                )
            );
            require(digest == digest[i], "invalid digest.");
            require(isSigner(signer));
            signerNum.add(1);
        }
        require(signerNum >= threshold, "not enough signers.");
    }

    function isSigner(address signer) private view returns (bool) {
        for (uint256 i = 0; i < signers.length; i++) {
            if (signers[i] == signer) {
                return true;
            }
        }
        return false;
    }
}
