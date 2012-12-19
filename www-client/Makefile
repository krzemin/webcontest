all: templates toaster

templates:
	handlebars templates/*.tmpl -f release/templates.js

toaster:
	toaster -dc .
