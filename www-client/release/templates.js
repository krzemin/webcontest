(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['contest-list.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, self=this, functionType="function", escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1, foundHelper;
  buffer += "\n      <tr>\n        <td>";
  foundHelper = helpers.name;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.name; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</td>\n        <td>";
  foundHelper = helpers.date;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.date; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</td>\n        <td>\n          ";
  stack1 = depth0.registered;
  stack1 = helpers['if'].call(depth0, stack1, {hash:{},inverse:self.program(7, program7, data),fn:self.program(2, program2, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n        </td>\n      </tr>\n      ";
  return buffer;}
function program2(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n            ";
  stack1 = depth0.active;
  stack1 = helpers['if'].call(depth0, stack1, {hash:{},inverse:self.program(5, program5, data),fn:self.program(3, program3, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n          ";
  return buffer;}
function program3(depth0,data) {
  
  
  return "\n            <button class=\"btn btn-success\">Open contest</button>\n            ";}

function program5(depth0,data) {
  
  
  return "\n            <span class=\"badge badge-success\">Registered</span>\n            ";}

function program7(depth0,data) {
  
  
  return "\n          <button class=\"btn btn-primary\">Register</button>\n          ";}

  buffer += "<div class=\"well\">\n  <h2>Please select contest</h2>\n\n  <table class=\"table table-stripped\">\n    <thead>\n      <th>Contest</th>\n      <th>Start date</th>\n      <th></th>\n    </thead>\n    <tbody>\n      ";
  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </tbody>     \n  </table>\n</div>\n";
  return buffer;});
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
  


  return "<form class=\"form-signin well\">\n    <h2>Please sign in</h2>\n    <input type=\"text\" class=\"input-block-level\" placeholder=\"E-mail address\" id=\"email\">\n    <input type=\"password\" class=\"input-block-level\" placeholder=\"Password\" id=\"password\">\n    <button class=\"btn btn-large btn-primary\" type=\"button\" data-loading-text=\"Signing in...\"  id=\"sign-in\">Sign in</button>\n</form>\n";});
})();