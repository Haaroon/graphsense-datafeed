DROP KEYSPACE IF EXISTS graphsense_raw;
CREATE KEYSPACE graphsense_raw WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 };

USE graphsense_raw;

// BITCOIN blockchain data

CREATE TYPE joinsplit (
    txid blob,
    vpub_old int,
    vpub_new int,
);

CREATE TYPE input (
    txid blob,
    vout int
);

CREATE TYPE output (
    value bigint,
    n int,
    addresses list<text>
);

CREATE TABLE block (
    height int PRIMARY KEY,
    block_hash blob,
    timestamp int,
    block_version int,
    size int,
    txs list<blob>
);

CREATE TABLE transaction (
    height int,
    tx_hash blob,
    timestamp int,
    coinbase boolean,
    vin list<FROZEN<input>>,
    vout list<FROZEN<output>>,
    vjoinsplit list<FROZEN<<joinsplit>>,
    PRIMARY KEY (height, tx_hash)
);

CREATE TABLE exchange_rates (
    timestamp int PRIMARY KEY,
    eur double,
    usd double
);

CREATE TABLE tag (
    address text,
    tag text,
    tag_uri text,
    description text,
    actor_category text,
    source text,
    source_uri text,
    timestamp int,
    PRIMARY KEY (address, tag, source)
);

