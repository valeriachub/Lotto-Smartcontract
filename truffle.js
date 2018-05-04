// Allows us to use ES6 in our migrations and tests.


module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      gas: 470000
    },
    rinkeby: {
      host: 'localhost',
      port: 8545,
      network_id: '4', // Rinkeby ID 4
      from: '0x84e7F3bFc78f2Fc5d4Fe47AfdFC94A8cd3CD1CFd', // account from which to deploy
      gas: 6712390
    }
  }
}
