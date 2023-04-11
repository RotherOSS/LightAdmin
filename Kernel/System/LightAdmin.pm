# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://otobo.de/
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

package Kernel::System::LightAdmin;

use strict;
use warnings;

use MIME::Base64;

use Kernel::System::VariableCheck qw(IsArrayRefWithData);

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Queue',
);

=head1 NAME

Kernel::System::LightAdmin - lib for light admin package

=head1 DESCRIPTION

Two functions relevant for the package and grouped here.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $LightAdminObject = $Kernel::OM->Get('Kernel::System::LightAdmin');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 StdAttachmentStandardTemplatePermission()

Get the lowest permission level of all linked queues (attachment->template->queue).
Returns nothing if the user has no 'ro' on at least one linked queue, 'ro' if the user has no 'rw' on
at least one linked queue and 'rw' if the user has full permission on all queues or no link exists at all.

    my $Permission = $StdAttachmentObject->StdAttachmentStandardTemplateMemberList(
        ID      => $AttachmentID,
        UserID  => $Param{UserID},
        Default => 'ro',            # (optional) lowest permission level
    );

=cut

sub StdAttachmentStandardTemplatePermission {
    my ( $Self, %Param ) = @_;

    # Check needed stuff.
    for my $Needed (qw(ID UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }

    my $QueueObject         = $Kernel::OM->Get('Kernel::System::Queue');
    my $StdAttachmentObject = $Kernel::OM->Get('Kernel::System::StdAttachment');

    # Get all linked templates.
    my %TemplateList = $StdAttachmentObject->StdAttachmentStandardTemplateMemberList( AttachmentID => $Param{ID} );

    # 'rw' is the default permission on not linked attachments.
    return 'rw' if !%TemplateList;

    my $Permission;

    for my $TemplateID ( keys %TemplateList ) {
        # Get all queues linked with the template.
        my %Queues = $QueueObject->QueueStandardTemplateMemberList( StandardTemplateID => $TemplateID );
        my $TemplatePermission = $Self->QueueListPermission(
            QueueIDs => [ keys %Queues ],
            UserID   => $Param{UserID},
            Default  => 'rw',
        );

        if ( !defined $Permission ) {
            $Permission = $TemplatePermission // '';

            return 'ro' if $Permission eq 'ro';
        }
        elsif ( $Permission ne $TemplatePermission ) {
            return 'ro';
        }
    }

    return $Permission;
}

=head2 QueueListPermission()

Get the permission for a list of queues.
Returns nothing if the user has no 'ro' on any queue, 'ro' if the user has no 'rw' on at least one queue
and 'rw' if the user has full permission on all queues.

    my $Permission = $LightAdminObject->QueueListPermission(
        QueueIDs => \@QueueIDs,      # optional
        UserID   => $Param{UserID},
        Default  => 'rw',            # (optional) default 'ro' (ro|rw) fallback permission if no queues given
    );

=cut

sub QueueListPermission {
    my ( $Self, %Param ) = @_;

    # Check needed stuff.
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    my $QueueObject = $Kernel::OM->Get('Kernel::System::Queue');

    my %RoQueues = $QueueObject->GetAllQueues( UserID => $Param{UserID} );
    my %RwQueues = $QueueObject->GetAllQueues(
        UserID => $Param{UserID},
        Type   => 'rw',
    );

    # 'ro' is the default permission if no queue is given and parameter 'Default' is not set.
    my $DefaultPermission = $Param{Default} || 'ro';

    return $DefaultPermission if !IsArrayRefWithData( $Param{QueueIDs} );

    # final permission is rw or '' if all are of that kind, else ro
    my $Permission;
    QUEUE:
    for my $QueueID ( @{ $Param{QueueIDs} } ) {
        if ( !defined $Permission ) {
            if ( $RwQueues{$QueueID} ) {
                $Permission = 'rw';
            }
            elsif ( $RoQueues{$QueueID} ) {
                $Permission = 'ro';
                last QUEUE;
            }
            else {
                $Permission = '';
            }
        }

        elsif ( $Permission eq '' ) {
            if ( $RwQueues{$QueueID} || $RwQueues{$QueueID} ) {
                $Permission = 'ro';
                last QUEUE;
            }
        }

        elsif ( !$RwQueues{$QueueID} ) {
            $Permission = 'ro';
            last QUEUE;
        }
    }

    return $Permission;
}

1;
