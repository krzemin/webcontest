(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['contests2.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, self=this;

function program1(depth0,data) {
  
  
  return "\n        <div class=\"notfoundevents\"><p>No events for you</p></div>    \n    ";}

  buffer += "<script id=\"tmpl_ownevents\" type=\"text/templates\">\n    ";
  stack1 = depth0.event;
  stack1 = helpers.unless.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</script>\n";
  return buffer;});
templates['contests.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, self=this;

function program1(depth0,data) {
  
  
  return "\n        <div class=\"notfoundevents\"><p>No events for you</p></div>    \n    ";}

  buffer += "<script id=\"tmpl_ownevents\" type=\"text/templates\">\n    ";
  stack1 = depth0.event;
  stack1 = helpers.unless.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</script>\n";
  return buffer;});
templates['demo.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, self=this;

function program1(depth0,data) {
  
  
  return "\n        <div class=\"notfoundevents\"><p>No events for you</p></div>    \n    ";}

  buffer += "<script id=\"tmpl_ownevents\" type=\"text/templates\">\n    ";
  stack1 = depth0.event;
  stack1 = helpers.unless.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</script>\n";
  return buffer;});
})();