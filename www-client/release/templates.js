(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['example.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "\nkaka\n\n\n";});
templates['layout-center.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<div class=\"container\" id=\"main\">\n</div>\n";});
templates['layout-navbar.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<div class=\"navbar\">\n  <div class=\"navbar-inner\">\n    <div class=\"container\">\n      <a class=\"brand\" href=\"#\">Web Programmig Contest</a>\n      <div class=\"navbar-content\">\n\n        <ul class=\"nav\">\n          <li class=\"active\"><a href=\"#\"><i class=\"icon-eye-open icon-white\"></i> Problems</a></li>\n          <li><a href=\"#\"><i class=\"icon-file icon-white\"></i> Submit</a></li>\n          <li><a href=\"#\"><i class=\"icon-fire icon-white\"></i> Status</a></li>\n          <li><a href=\"#\"><i class=\"icon-th-list icon-white\"></i> Ranking</a></li>\n        </ul>\n\n        <ul class=\"nav pull-right\">\n          <li class=\"dropdown\">\n            <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">\n              <i class=\"icon-user icon-white\"></i>\n              Signed in as <b>krzemin</b>\n              <span class=\"caret\"></span>\n            </a>\n            <ul class=\"dropdown-menu\">  \n              <li><a href=\"#\"><i class=\"icon-envelope\"></i> Messages inbox</a></li>  \n              <li><a href=\"#\"><i class=\"icon-cog\"></i> Settings</a></li>  \n              <li><a href=\"#\"><i class=\"icon-pencil\"></i> Code snippets</a></li>  \n              <li class=\"divider\"></li>  \n              <li><a href=\"#\"><i class=\"icon-off\"></i> Sign out</a></li>  \n            </ul>  \n          </li>\n        </ul>\n\n      </div>\n   </div>\n  </div>\n</div>\n\n<div class=\"container-fluid\" id=\"main\"></div>\n";});
templates['sign-in.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<form class=\"form-signin well\">\n    <h2>Please sign in</h2>\n    <input type=\"text\" class=\"input-block-level\" placeholder=\"E-mail address\" id=\"email\">\n    <input type=\"password\" class=\"input-block-level\" placeholder=\"Password\" id=\"password\">\n    <button class=\"btn btn-large btn-primary\" type=\"button\" id=\"sign-in\">Sign in</button>\n</form>\n";});
})();