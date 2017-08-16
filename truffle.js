module.exports = {
  networks: {
    dev: {
      host: "localhost",
      port: 8545,
      network_id: "dev"
    },
    test: {
      host: "localhost",
      port: 8546,
      network_id: "test"
    },
    prod: {
      host: "localhost",
      port: 8544,
      network_id: "prod"
    }
  }
};
