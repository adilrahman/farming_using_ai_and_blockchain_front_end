pragma solidity 0.5.4;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol';

contract Crowdfunding {
    Project[] private projects;
    mapping(address => Project[]) userProjectList;

    function startProject(
        string calldata _ProjectName,
        string calldata _ProjectDescription,
        uint256 _GoalAmount,
        uint256 _minimunContribution,
        uint256 durationInDays,
        string calldata _creatorName,
        string calldata _phoneNumber
    ) external {
        uint256 raiseUntil = now + durationInDays * 1 days;
        Project newProject = new Project(
            _ProjectName,
            _ProjectDescription,
            _GoalAmount,
            _minimunContribution,
            raiseUntil,
            msg.sender
        );
        projects.push(newProject);

        newProject.setOwnerDetails(_creatorName, _phoneNumber);
        // newProject.initialFund();
    }

    function numberOfProjects() public view returns (uint256) {
        return projects.length;
    }

    function returnAllProjects() external view returns (Project[] memory) {
        return projects;
    }
}

contract Project {
    // using SafeMath for uint256;

    enum State {
        Fundraising,
        Successful,
        Expired,
        Cancelled
    }

    // State variables

    // creator details
    address payable public creator;
    string public creatorName;
    string public phoneNumber;
    uint256 public completeAt;
    uint256 public raiseBy;

    //project details
    string public ProjectName;
    string public ProjectDescription;
    uint256 public GoalAmount; // required to reach at least this much, else everyone gets refund
    uint256 public currentBalance; // update on each contribution
    uint256 public minimunContribution;
    State public state; // state of the project (fundraising/expired/successful)

    mapping(address => uint256) public contributions;
    address payable[] contributersAddress;
    uint256 public numberOfContributors;

    constructor(
        string memory _ProjectName,
        string memory _ProjectDescription,
        uint256 _GoalAmount,
        uint256 _minimunContribution,
        uint256 _fundRaisingDeadline,
        address payable _creator
    ) public {
        ProjectName = _ProjectName;
        ProjectDescription = _ProjectDescription;
        GoalAmount = _GoalAmount;
        minimunContribution = _minimunContribution;
        currentBalance = 0;
        raiseBy = _fundRaisingDeadline;
        state = State.Fundraising;
        creator = _creator; // set to who calling this
        numberOfContributors = 0;
    }

    function initialFund() external payable {
        require(msg.sender == creator);
    }

    function setOwnerDetails(
        string memory _creatorName,
        string memory _phoneNumber
    ) public {
        creatorName = _creatorName;
        phoneNumber = _phoneNumber;
    }

    function contibute() public payable {
        require(state == State.Fundraising, "Not recv any new contributions");
        require(
            msg.value > minimunContribution,
            "should be greaterthan min amount"
        );
        require(
            (msg.value + currentBalance) <= GoalAmount,
            "should be lessthan Goalamount"
        );

        contributions[msg.sender] = contributions[msg.sender] + msg.value;
        currentBalance += msg.value;
        numberOfContributors++;
        checkIfFundingCompleteOrExpired();
    }

    function contributorsCount() public view returns (uint256) {
        return numberOfContributors;
    }

    function isAContributor() external view returns (bool) {
        if (contributions[msg.sender] > 0) {
            return true;
        }
        return false;
    }

    function checkIfFundingCompleteOrExpired() public {
        if (currentBalance >= GoalAmount) {
            state = State.Successful;
        } else if (now > raiseBy) {
            state = State.Expired;
        }
    }

    function payOut() internal returns (bool) {
        require(state == State.Successful);
        uint256 totalRaised = currentBalance;
        currentBalance = 0;

        if (creator.send(totalRaised)) {
            return true;
        } else {
            currentBalance = totalRaised;
            state = State.Successful;
        }
        return false;
    }

    function cancelTheProject() public returns (bool) {
        require(msg.sender == creator, "Your not the creator");
        state = State.Cancelled;
        if (refundAll() == true) {
            return true;
        }
        return false;
    }

    function refundAll() public returns (bool) {
        for (uint256 i = 0; i < contributersAddress.length; i++) {
            address payable person = contributersAddress[i];
            uint256 amount = contributions[person];
            if (amount > 0) {
                person.transfer(amount);
                currentBalance -= amount;
                contributions[person] = 0;
                numberOfContributors--;
            }
        }
        return true;
    }

    function getRefund() public returns (bool) {
        // require(state == State.Expired);
        require(contributions[msg.sender] > 0);

        uint256 amountToRefund = contributions[msg.sender];
        contributions[msg.sender] = 0;

        if (!msg.sender.send(amountToRefund)) {
            contributions[msg.sender] = amountToRefund;
            return false;
        } else {
            currentBalance = currentBalance - amountToRefund;
        }
        numberOfContributors--;
        return true;
    }

    // get details about the project
    function getSummary()
        public
        view
        returns (
            address payable,
            string memory,
            string memory,
            uint256,
            string memory,
            string memory,
            uint256,
            uint256,
            uint256,
            State,
            uint256
        )
    {
        return (
            creator,
            creatorName,
            phoneNumber,
            raiseBy,
            ProjectName,
            ProjectDescription,
            GoalAmount,
            currentBalance,
            minimunContribution,
            state,
            numberOfContributors
        );
    }
}
