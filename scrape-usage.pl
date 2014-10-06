#!/usr/bin/perl

use strict;
use warnings;
use WWW::Mechanize;

# Change these to match your primary account
my $username = 'example@cox.net';
my $password = 'moarBandw1dth';

my $login_form_url = 'https://idm.west.cox.net/coxlogin/ui/internettools';
my $usage_url = 'https://myaccount.cox.net/internettools/datausage/usagelist.cox';

my $mech = WWW::Mechanize->new();

$mech->dump_forms();
$mech->get($login_form_url);

$mech->submit_form(
    form_name => 'LoginPage',
    fields    => {
        username  => $username,
        password  => $password,
        target    => 'http://www.cox.com/myconnection/home.cox',
        onsuccess => 'https://myaccount.cox.net/internettools/datausage/usage.cox'
        onfailure => 'http:/idm.east.cox.net/coxlogin/ui/internettools',
    }
);

$mech->get($usage_url);
$mech->submit_form(
    form_name => 'usageForm',
    fields    => {
        'usageForm'              => 'usageForm',
        'usageForm:j_idt125'     => '1',
        'usageForm:type'         => 'Daily',
        'usageForm:view'         => 'List',
        'usageForm:billingCycle' => 'Current',
    }
);

$mech->save_content("usage.html");
