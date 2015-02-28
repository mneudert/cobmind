#!/usr/bin/env perl

use MaxMind::DB::Writer::Tree;
use Net::Works::Network;

my %types = (
    type => 'utf8_string',
);

my $tree = MaxMind::DB::Writer::Tree->new(
    ip_version            => 4,
    record_size           => 24,
    database_type         => 'CobMind-Test',
    languages             => ['en'],
    description           => { en => 'CobMind test database' },
    map_key_type_callback => sub { $types{ $_[0] } },
);

my $network
    = Net::Works::Network->new_from_string( string => '127.0.0.0/24' );

$tree->insert_network(
    $network,
    {
        type => 'local',
    },
);

open my $fh, '>', './CobMind-ipv4-24.mmdb';
$tree->write_tree($fh);
