# bike_warehouse

An web app for creating, tracking, browsing, and purchasing bikes. Users with admin privelages and create and edit bikes in inventory while normal users can browse and purchase bikes in inventory.

Users can also leave ratings and reviews for bikes.

Bikes have attributes of frame, color, size, disicplines (through frames), price, and reviews.

Frames are associated with a manufacturer and disciplines.

Manufacturers and frames simply have the attributes of a name.

To install, fork the repo. 
Run:
`bundle install`

Follow by:
`rake db:migrate && rake db:seed`

This should generate a few items in the database. Run:

`rails s` 
to launch the app. Then navigate to `localhost:3000` to get started.