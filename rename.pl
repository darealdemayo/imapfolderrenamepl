#!/usr/bin/perl

use strict;
use warnings;
use Net::IMAP::Simple;
use Net::IMAP::Simple::SSL;

# Configuration
my $server = 'imap.purelymail.com';
my $username = 'testaa@dengg.one';
my $password = 'PASSSSS';

# Connect to the IMAP server
my $imap = Net::IMAP::Simple::SSL->new($server) || die "Unable to connect to IMAP server: $!";

# Login to your account
if (!$imap->login($username, $password)) {
    die "Login failed: " . $imap->errstr;
}

# List all folders
my @folders = $imap->mailboxes;

# Iterate through folders
foreach my $folder (@folders) {
    if ($folder =~ m/\//) {
        my $new_folder_name = $folder;
        $new_folder_name =~ s/\//./g;  # Replace '/' with '.'

        # Rename the folder
        if ($imap->rename_mailbox($folder, $new_folder_name)) {
            print "Renamed folder: $folder to $new_folder_name\n";
        } else {
            print "Failed to rename folder: $folder\n";
        }
    }
}

# Disconnect from the IMAP server
$imap->quit;
