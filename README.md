# angular-rest-template
A showcase for building LOB application's common patterns:
- Master details.
- Common controls: associating using searchable dropbox, date time picker, 
- Communicating between forms using bus (search in form will fill another form's data table).
- Login with OAuth.
- CRUD.
- RESTful server.
- Dashboard *TODO

The application is aiming to build POS with clean codebase by incorporating:
- Coffeescript, a clean and concise replacement for Javascript :)
- Minimal code duplication between controllers using CoffeeScript OOP capability. View model pattern is the main actor here.
- Thanks for our dirty worker (Grunt), we have the luxury of uglified production server at ease :)

This project is a client consumer for [angular-rest-template](https://github.com/arinal/spring-rest-template) backend server.

Generated with [yo angular generator](https://github.com/yeoman/generator-angular)
version 0.11.1.

## Build & development

Make sure you have [nodejs](https://nodejs.org) installed. Refer to this [site](https://nodejs.org) about the installation details.
A running backend server is mandatory before starting this project. Please visit [spring-rest-template](https://github.com/arinal/spring-rest-template) to have it up and running.

Afterwards, follow these steps

0. `npm install grunt-cli bower` to install those two.
1. Download & install all the required node components by typing `npm install`.
2. Download client library dependencies by typing `bower install`.
3. Run `grunt serve` will start the server. Fire your browser and hit `localhost:9000` to see it in action.

> *TODO: executing steps below will fail because this project hasn't implemented unit testing yet. Please put extra `--force`*

4. Executing `grunt` will compile the project and put all the nicely bundled and minified files to `dist` folder. 
5. Executing `grunt serve:dist` will run the compiled project.