# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2022 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Language::de_LightAdmin;

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
