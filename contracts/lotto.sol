pragma solidity ^0.4.0;
contract Lotto{
    
  struct Ticket{
      uint number;
      mapping(uint => LottoTicket) lottoTickets;
  }
  
  struct LottoTicket{
      address participant;
      uint amount;
      uint number;
  }
  
  uint public totalLottoTickets;
  uint public prize;
  uint public maxNumberOfBet = 4;
  uint public maxTicketForParticipant = 4;
  uint public range = 10;
  address[] public winners;
  mapping(address => uint) public participantTicketsCount;
  mapping(uint => Ticket) public tickets;
  
  function pickNumber(uint number) public payable{
      require(number>0 && number<11);
      require(participantTicketsCount[msg.sender] <= maxTicketForParticipant);
      
      Ticket storage ticket = tickets[number];
      ticket.lottoTickets[ticket.number] = LottoTicket({
          participant:msg.sender,
          amount:msg.value,
          number:number
      });

      ticket.number++;
      
      totalLottoTickets++;
      prize+=msg.value;
      participantTicketsCount[msg.sender]++;
      
      if(totalLottoTickets >= maxNumberOfBet){
          generateWinner();
      }
  }
  
      function generateWinner() public {
          uint winTicketNumber = 1;//getRandomNumber();
          
          for(uint i=0; i<totalLottoTickets; i++) {
             winners.push(tickets[winTicketNumber].lottoTickets[i].participant);
          }
          
          uint lotteryPrize = prize;
          
          if(winners.length > 0){
           lotteryPrize = prize/winners.length;
            for(uint j=0 ; j< winners.length; j++){
                winners[j].transfer(lotteryPrize);
            }
          }else{
              winners[0].transfer(lotteryPrize);
          }
      }
      
      function getRandomNumber() private view returns(uint){
        return (uint(keccak256(block.timestamp, block.difficulty)) % range) + 1;
      }


}