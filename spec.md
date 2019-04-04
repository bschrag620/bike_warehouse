Requirements for project:
https://learn.co/tracks/full-stack-web-development-v6/rails/rails-project-mode/rails-portfolio-project

[x] Use Ruby on Rails

[x] Include at least one has_many/belongs_to and 2 has_many/through, and a many to many that utilizes a join table
	- Bike belongs_to Frame, Frame has_many Bikes
	- Frame has_many Disciplines, Disciplines has_many Frames
	- Bike has_many Disciplines, through Frame
	- Bike has_many Reviews
	- User has_many Reviews, Review belongs_to user_id, bike_id
	- Review also has property of :rating and :comment, which the user has direct creation of

[x] Validates model attributes on creation

[x] At least one class AR scope method that is chainable. Hint: requires the use of .where, .order, etc
	- bike model has several chainable methods. 

[x] User authentication including signup, login, logout

[x] Authentication must also allow omniauth login
	- users can signup/login via Facebook

[x] Be RESTful and utilize nested routes. Must include a nested index and show route
	- several nested routes and a namespaced admin route

[x] Display validation errors using fields_with_errors div class that displays error messages
	- forms *should* all render_errors at the top. Utilized a helper mehtod to render the errors in a partial view

[x] DRY - Do Not Repeat Yourself. Logic for controllers should be captured in the models, views utilize helper methods and partials. 
	- several of the views have helper methods. Also created concerns for a couple of the models where it seemed appropriate
	- lots of partials used

[x] Follow Rails Style Guide https://github.com/bbatsov/rails-style-guide

[x] Follow Ruby Style Guide https://github.com/bbatsov/ruby-style-guide


***JS project requirements***

[x] - render at least one index pag via JS and active model serialization JSON. 
	

[x] - render a show page via JS and AMS JSON

[x] - Dynamically render on the page at least one 'has-many' relationship through JSON using JS

[x] - Must use Rails app and JS to render a form for creating a resource that submits dynamically

[x] - Must translate the JSON repsonse in JS model objects using either ES6 class or constructor syntax. Model objects must have at least one method on the prototype


Videos to watch
---------------

https://www.youtube.com/watch?v=oHPM0ekV7zQ 
https://www.youtube.com/watch?v=Yd0nH9CWWfo&amp=&feature=youtu.be 