# Team Mars Buddy Scheme

Project No. 4: Buddy Scheme
Client: Dr. Jeroen Keppens

Authors of This Software
* Chang He
* Anastasia Bigovic
* Max Foucault
* Valentin Kizelev
* Alexis Ebojoh
* Evelina Premyanova
* Amartya Singh
* Pushkar Garg

## IMPORTANT: Our Rails project folder is the folder called "source_code" in the main directory of our coursework submission. To setup, configure, or run the software, or to execute any Ruby on Rails command, you must navigate to the "source_code" folder first!

This software is designed to meet the client's need of a web application that is able to facilitate an annual on-campus social activity called "buddy scheme." The main purpose of the buddy scheme is to pair up participating students for the purpose of mentoring. All currently enrolled or prospecting students of King's College London can join the buddy scheme, either taking the role of a "mentor" or a "mentee." However, general criteria for becoming a mentor include that a student is not a first-year or newly-transfered student. Also, a mentor should not be in a lower year than his/her paired mentee.

Team Mars Buddy Scheme can be considered as a simple tool or medium of socializing and making new friends. This can be very helpful for students new to the KCL community, as they may have this opportunity to be paired by the software to another student who has been in KCL for a while. The buddy scheme can enable new students to learn the rules and customs of KCL, to get advice on academics from old students, and to settle and integrate into KCL more easily. The scheme coordinator should pair up students of the same faculty or department. Such pairing conditions can be applied by the scheme coordinator using this software.

## List of Frameworks, API's, and Plugins Used in This Project

This software is based on Ruby on Rails framework. It also employs a variety of API's and plugins which make the implementation of this software possible. Their details are listed below.

* ruby 2.7.2p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux] (Also specified in the file ['.ruby-version'](./.ruby-version))

* Rails 6.0.3.5

* ActiveRecord::Base - Rails API

* SQLite3 Database (Ruby gem)

* ActiveAdmin (Ruby gem)

* Devise (Ruby gem)

* Rapidfire (Ruby gem)

Various other Ruby gems are utilized by this software.

['Gemfile'](./Gemfile) contains the complete list of Ruby gems utilized in this software. Please check this document for further details.

## Locations of Major Software Components

Under ['/db/migrate'](./db/migrate) you may find the database models for the tables required for the system's database. These tables store users' login credentials, users' personal information (name, gender, department, etc.), as well as data for other models (including BuddyScheme, Message, and Questionnaire).

This system has three types of users: ['AdminUser'](./db/migrate/20210316120011_devise_create_admin_users.rb) (a.k.a. "Administrator"), ['CoordUser'](./db/migrate/20210317120012_devise_create_coord_users.rb) (a.k.a. "Coordinator"), and ['Participant'](./db/migrate/20210319120014_create_participants.rb) (a.k.a. "Participant"). In the previous sentence, you can click on the names of those users to go to the location where their database models are defined. In addition, please click ['Participant'](./db/migrate/20210406094959_add_devise_to_participants.rb) to see the extension of the database model for "Participant", which is used to store the login credentials for "Participant" users.

Each of the three types of users specified in the previous paragraph has its designated ActiveAdmin namespace. There are three namespaces in total: ['admin'](./app/admin) (for AdminUser), ['coord'](./app/coord) (for CoordUser), and ['user'](./app/user) (for Participant). In the previous sentence, you can click on the names of the namespaces to go to the location where they are defined. One type of user can only access its own designated namespace and not the namespaces of the other two types of users. The three namespaces have different access levels to the same SQLite database. Different namespaces may retrieve different columns of each database table, and some database tables are off-limit to some namespaces. For example, some namespaces may perform all four CRUD operations to a table, while others may only have read-only access to a table or may not even have read access to some other tables. AdminUser and CoordUser typically have much higher database access levels than Participant does.

Below are some other locations for important software components:

* File ['routes.rb'](./config/routes.rb) contains routing specifications of this web application.

* File ['active_admin.rb'](./config/initializers/active_admin.rb) contains the setup configurations of ActiveAdmin.

* Folder ['app/controllers'](./app/controllers) contains the controllers for the login interface of the three user types.

* Folder ['app/models'](./app/models) contains the rails models for all database tables. Note that 'participant.rb' here also contains collections and methods that are important for this application to function.

* Folder ['app/views'](./app/views) contains the views that define the login pages of the three user types.

* Folder ['db'](./db) contains other important files related to the database, in addtion to the ['db/migrate'](./db/migrate) folder.

Since this system is built on Ruby On Rails, you may want to check the Ruby On Rails official guide ['here'](https://guides.rubyonrails.org/) on their website.

## Login Credentials for Seed Accounts

In ['db/seeds.rb'](./db/seeds.rb), there are login credentials for the three seed accounts, one for each user type: 'administrator@mars.com' for AdminUser, 'coordinator@mars.com' for CoordUser, and 'john.smith@mars.com' for Participant. The login credentials are also listed below. These seed account can be generated by running "rake db:seed" (given that your database is already created, see the Developer's Manual ('dev_manual.pdf') for further details). Note that the three email addresses associated with these accounts are not real email addresses. You may change the email address associated with your account once you log in to your account. You can (and are strongly advised to in production environment) change the passwords of the seed accounts once you log in with them, as the pre-set passwords are relatively simple.

* ['administrator@mars.com', 'proud.martians']

* ['coordinator@mars.com', 'proud.martians']

* ['john.smith@mars.com', 'marsisours']
