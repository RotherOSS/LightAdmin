# --
# Copyright (C) 2021 Rother OSS GmbH, https://rother-oss.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Language::de_RotherOSSLightAdmin;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # Template: AdminNotificationEvent
    $Self->{Translation}->{'Only send within working hours'} = 'Nur innerhalb der Arbeitszeit senden';
    $Self->{Translation}->{'Only send outside working hours'} = 'Nur außerhalb der Arbeitszeit senden';
    $Self->{Translation}->{'No permission to edit this ticket notification.'} = 'Sie haben keine Berechtigung, diese Ticket-Benachrichtigung zu bearbeiten.';

    # Template: AdminAttachment
    $Self->{Translation}->{'No permission to edit this attachment.'} = 'Sie haben keine Berechtigung, diesen Anhang zu bearbeiten.';
    
    # Template: AdminTemplate
    $Self->{Translation}->{'No permission to edit this template.'} = 'Sie haben keine Berechtigung, diese Vorlage zu bearbeiten.';
}

1;
