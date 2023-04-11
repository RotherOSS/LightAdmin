.. toctree::
    :maxdepth: 2
    :caption: Contents

Sacrifice to Sphinx
===================

Description
===========
Enables creating and managing of templates, attachments and ticket notifications with a queue- or group-based permission concept.

System requirements
===================

Framework
---------
OTOBO 10.1.x

Packages
--------
\-

Third-party software
--------------------
\-

Usage
=====

The module adds a light admin functionality. Using this, agents can be granted restricted admin permissions to the following areas:

* Ticket notifications
* Templates including attachments and linked queues

After package installation and configuration, the light admin user has access to ticket notifications and templates in general. Regarding the access, three states are distinguished:

# Object is only related to queues on which the user has rw permissions or, in case of templates, no queue at all. The light admin user is permitted to do everything, but can only (and in case of ticket notifications, is required to) assign the object to queues which he has access to.
# Object is related to queues on which the user has ro permissions or no permissions at all or no queue restriction at all is given in case of ticket notifications. Here, the light admin user is allowed to view the object but has no edit permissions. A message box is shown with the information that the user is not permitted to edit the object and the save button is hidden.
# Object is related to queues on which the user has no permissions at all. These objects are hidden.

Setup
-----

The permissions can be assigend to every group. For convenience reasons, a specialised light admin group can be created.

To grant light admin permissions to the group, it has to be added to GroupRo in the following system configuration settings:

* Frontend::Module###Admin
* Frontend::Navigation###Admin###001-Framework
* Frontend::NavigationModule###AdminNotificationEvent
* Frontend::NavigationModule###AdminTemplate
* Frontend::NavigationModule###AdminTemplateAttachment
* Frontend::NavigationModule###AdminQueueTemplates
* Frontend::NavigationModule###AdminAttachment
* Frontend::Module###AdminNotificationEvent
* Frontend::Module###AdminTemplate
* Frontend::Module###AdminTemplateAttachment
* Frontend::Module###AdminQueueTemplates
* Frontend::Module###AdminAttachment

About
=======

Contact
-------
| Rother OSS GmbH
| Email: hello@otobo.de
| Web: https://otobo.de

Version
-------
Author: |doc-vendor| / Version: |doc-version| / Date of release: |doc-datestamp|
