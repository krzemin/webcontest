(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['contest-list.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

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
  
  var buffer = "", stack1, foundHelper;
  buffer += "\n            <button class=\"btn btn-success open-contest\" id=\"";
  foundHelper = helpers.id;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.id; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "\">Open contest</button>\n            ";
  return buffer;}

function program5(depth0,data) {
  
  
  return "\n            <span class=\"badge badge-success\">Registered</span>\n            ";}

function program7(depth0,data) {
  
  var buffer = "", stack1, foundHelper;
  buffer += "\n          <button class=\"btn btn-primary register-for-contest\" id=\"";
  foundHelper = helpers.id;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.id; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "\">Register</button>\n          ";
  return buffer;}

  buffer += "<div class=\"well\">\n  <button class=\"btn pull-right\" id=\"sign-out\">Sign out</button>\n  <h2>Please select contest</h2>\n\n  <table class=\"table table-hover\">\n    <thead>\n      <th>Contest</th>\n      <th>Start date</th>\n      <th></th>\n    </thead>\n    <tbody>\n      ";
  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </tbody>     \n  </table>\n</div>\n";
  return buffer;});
templates['layout-center.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<div class=\"container\" id=\"main\">\n</div>\n";});
templates['layout-navbar.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<div class=\"navbar\">\n  <div class=\"navbar-inner\">\n    <div class=\"container\">\n      <a class=\"brand\" nohref=\"\" id=\"contest-welcome\">Web Programmig Contest</a>\n      <div class=\"navbar-content\">\n\n        <ul class=\"nav\" id=\"navigation\">\n          <li class=\"divider-vertical hidden-phone\"></li>\n          <li class=\"dropdown\">\n            <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" id=\"problems\">\n              <i class=\"icon-th-large\"></i>\n              Problems\n              <span class=\"caret\"></span>\n            </a>\n            <ul class=\"dropdown-menu\" id=\"problems-list\"></ul>\n          </li>\n          <li><a id=\"status\"><i class=\"icon-info-sign\"></i> Status</a></li>\n          <li><a id=\"ranking\"><i class=\"icon-th-list\"></i> Ranking</a></li>\n        </ul>\n\n        <ul class=\"nav pull-right\">\n          <li class=\"dropdown\">\n            <a class=\"dropdown-toggle\" data-toggle=\"dropdown\" nohref=\"\">\n              <i class=\"icon-user\"></i>\n              Signed in as <b id=\"user-name\"></b>\n              <span class=\"caret\"></span>\n            </a>\n            <ul class=\"dropdown-menu\">  \n              <li><a id=\"messages\"><i class=\"icon-envelope\"></i> Messages</a></li>  \n              <li><a id=\"settings\"><i class=\"icon-wrench\"></i> Settings</a></li>  \n              <li class=\"divider\"></li>\n              <li><a id=\"exit-contest-area\"><i class=\"icon-arrow-left\"></i> Exit contest area</li>\n              <li><a id=\"sign-out\"><i class=\"icon-off\"></i> Sign out</a></li>  \n            </ul>  \n          </li>\n        </ul>\n\n      </div>\n   </div>\n  </div>\n</div>\n\n<div class=\"container-fluid\" id=\"main\"></div>\n";});
templates['messages.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<h1>Messages</h1>\n\n\n";});
templates['problem.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, foundHelper, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1, foundHelper;
  buffer += "\n      <div class=\"row-fluid\">\n        <div class=\"span6\">\n          <h4>Input</h4>\n          <pre>";
  foundHelper = helpers.input;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.input; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</pre>\n        </div>\n        <div class=\"span6\">\n          <h4>Output</h4>\n          <pre>";
  foundHelper = helpers.output;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.output; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</pre>\n        </div>\n      </div>\n    ";
  return buffer;}

  buffer += "\n\n<div class=\"fixed-height-container\"> \n\n  <div class=\"\" id=\"problem-description\">\n    <h1>";
  foundHelper = helpers.name;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.name; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</h1>\n    <p>";
  foundHelper = helpers.description;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.description; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</p>\n    <h2>Input specification</h2>\n    <p>";
  foundHelper = helpers.input_specification;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.input_specification; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</p>\n    <h2>Output specification</h2>\n    <p>";
  foundHelper = helpers.output_specification;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.output_specification; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</p>\n    <h2>Example testcases</h2>\n    ";
  stack1 = depth0.testcases;
  stack1 = helpers.each.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    ";
  foundHelper = helpers.testcases_explanation;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.testcases_explanation; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "\n  </div>\n\n  <div id=\"coding-panel\">\n    <div class=\"tabbable\">\n      <ul class=\"nav nav-tabs\">\n        <li class=\"active\"><a href=\"#tab-code\" data-toggle=\"tab\">Code</a></li>\n        <li><a href=\"#tab-tests\" data-toggle=\"tab\">Tests</a></li>\n        <li><a href=\"#tab-submit\" data-toggle=\"tab\">Submit</a></li>\n        <li><a href=\"#tab-my-submissions\" data-toggle=\"tab\">My submissions</a></li>\n      </ul>\n      <div class=\"tab-content\">\n        <div class=\"tab-pane active\" id=\"tab-code\">\n\n          <div id=\"code-editor-container\">\n            <textarea id=\"codemirror\"></textarea>\n            <div class=\"\" id=\"code-toolbar\">\n              <div class=\"btn-toolbar\">\n                  <button class=\"btn\"><i class=\"icon-hdd\"></i> Save</button>\n                  <button class=\"btn\"><i class=\"icon-cog\"></i> Compile</button>\n                  <button class=\"btn\"><i class=\"icon-check\"></i> Test</button>\n                  <button class=\"btn\"><i class=\"icon-upload\"></i> Submit</button>\n              </div>\n            </div>\n          </div>\n          <pre id=\"code-messages-container\">Compilation messages will appear here\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\nLorem ipsum dolor sit amet turpis cursus magna. Vestibulum ornare velit rutrum ligula, elementum et, varius in, ipsum. Nunc turpis. Pellentesque ac lacus. Integer erat volutpat. Vestibulum tortor vehicula dolor lorem, pellentesque facilisis. In hac habitasse platea dictumst. Quisque eu lectus elit, pulvinar sed, ornare eu, odio. Mauris eget dolor auctor odio\n          </pre> \n\n        </div>\n\n        <div class=\"tab-pane\" id=\"tab-tests\">\n\n          <div class=\"container-fluid\">\n            <div class=\"row-fluid\">\n\n              <div class=\"btn-toolbar\">\n                <div class=\"btn-group\">\n                  <button class=\"btn btn-primary\">New</button>\n                </div>\n                <div class=\"btn-group\">\n                  <button class=\"btn btn-success\">Run all</button>\n                  <button class=\"btn btn-danger\">Run failed</button>\n                </div>\n              </div>\n\n              <table class=\"table\">\n                <thead>\n                  <tr>\n                    <th>No</th>\n                    <th>Input</th>\n                    <th>Expected output</th>\n                    <th>Actions</th>\n                    <th>Output</th>\n                    <th>Status</th>\n                  </tr>\n                </thead>\n                <tbody>\n                  <tr>\n                    <td>#1</td>\n                    <td><span class=\"input-medium uneditable-input\">2 5 7 3</span></td>\n                    <td><span class=\"input-medium uneditable-input\">2 3</span></td>\n                    <td>\n                      <button class=\"btn btn-success\"><i class=\"icon-play-circle\"></i></button>\n                      <button class=\"btn btn-danger\"><i class=\"icon-trash\"></i></button>\n                    </td>\n                    <td><span class=\"input-medium uneditable-input\">2 1</span></td>\n                    <td><span class=\"label label-success\">Passed</span></td>\n                  </tr>\n                  <tr>\n                    <td>#2</td>\n                    <td><span class=\"input-medium uneditable-input\">28 7 62 31 423 212</span></td>\n                    <td><span class=\"input-medium uneditable-input\">24 23</span></td>\n                    <td>\n                      <button class=\"btn btn-success\"><i class=\"icon-play-circle\"></i></button>\n                      <button class=\"btn btn-danger\"><i class=\"icon-trash\"></i></button>\n                    </td>\n                    <td><span class=\"input-medium uneditable-input\">233 33 3 3 3 3 331</span></td>\n                    <td><span class=\"label label-success\">Passed</span></td>\n                  </tr>\n                  <tr>\n                    <td>#3</td>\n                    <td><span class=\"input-medium uneditable-input\">21 2 3 4 5</span></td>\n                    <td><span class=\"input-medium uneditable-input\">2 459 239 48 434 5</span></td>\n                    <td>\n                      <button class=\"btn btn-success\"><i class=\"icon-play-circle\"></i></button>\n                      <button class=\"btn btn-danger\"><i class=\"icon-trash\"></i></button>\n                    </td>\n                    <td><span class=\"input-medium uneditable-input\">2 1</span></td>\n                    <td><span class=\"label label-success\">Passed</span></td>\n                  </tr>\n                  <tr>\n                    <td>#4</td>\n                    <td><span class=\"input-medium uneditable-input\">2444 444 444</span></td>\n                    <td><span class=\"input-medium uneditable-input\">2 444 45 543 656</span></td>\n                    <td>\n                      <button class=\"btn btn-success\"><i class=\"icon-play-circle\"></i></button>\n                      <button class=\"btn btn-danger\"><i class=\"icon-trash\"></i></button>\n                    </td>\n                    <td><span class=\"input-medium uneditable-input\">2 1 9 8 34 234 33</span></td>\n                    <td><span class=\"label label-success\">Passed</span></td>\n                  </tr>\n\n                </tbody>\n              </table>\n            </div>\n          </div>\n\n        </div>\n\n        <div class=\"tab-pane\" id=\"tab-submit\">\n\n          <div class=\"container-fluid\">\n            <div class=\"row-fluid\">\n              <form class=\"form-horizontal\">\n                <fieldset>\n                  <legend>Submit from a file</legend>\n                  <div class=\"alert alert-error\" id=\"submit-error\" style=\"display: none;\">\n                    <strong>Error!</strong> <br />\n                    File not submitted! You have to select proper programming language.\n                  </div>\n                  <div class=\"control-group\">\n                    <label class=\"control-label\" for=\"file\">Select a file</label>\n                    <div class=\"controls\">\n                      <input type=\"file\" class=\"input-file\" id=\"file\" />\n                    </div>\n                  </div>\n                  <div class=\"control-group\">\n                    <label class=\"control-label\" for=\"language\">Programming language</label>\n                    <div class=\"controls\">\n                      <select id=\"language\">\n                        <option value=\"0\">Detect automatically</option>\n                        <optgroup label=\"C\">\n                          <option value=\"1\">gcc 4.7.2</option>\n                          <option value=\"2\">clang 3.1</option>\n                        </optgroup>\n                        <optgroup label=\"C++\">\n                          <option value=\"3\">g++ 4.7.2</option>\n                          <option value=\"4\">clang++ 3.1</option>\n                        </optgroup>\n                        <optgroup label=\"Java\">\n                          <option value=\"5\">OpenJDK 1.7.0_09</option>\n                          <option value=\"6\">Oracle JDK 1.7.0_11</option>\n                        </optgroup>\n                        <optgroup label=\"Python\">\n                          <option value=\"7\">python 2.7</option>\n                          <option value=\"8\">python 3.2</option>\n                        </optgroup>\n                      </select>\n                    </div>\n                  </div>\n                  <div class=\"control-group\">\n                    <div class=\"controls\">\n                      <label class=\"checkbox\" for=\"load-to-editor\">\n                        <input type=\"checkbox\" id=\"load-to-editor\" value=\"true\" />\n                        Load to code editor\n                      </label>\n                    </div>\n                  </div>\n                  <div class=\"form-actions\">\n                    <button type=\"button\" class=\"btn btn-primary btn-large\" id=\"submit\">\n                      <i class=\"icon-upload\"></i>\n                      Submit\n                    </button>\n                  </div>\n                </fieldset>\n              </form> \n            </div>\n          </div>\n\n        </div>\n\n        <div class=\"tab-pane\" id=\"tab-my-submissions\">\n\n          <div class=\"container-fluid\">\n            <div class=\"row-fluid\">\n              <h2>My submissions</h2>\n\n            </div>\n          </div>\n\n        </div>\n\n     </div>\n    </div>\n  </div>\n\n</div>\n";
  return buffer;});
templates['ranking.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<h1>Ranking</h1>\n\n\n";});
templates['settings.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<h1>Settings</h1>\n\n\n";});
templates['sign-in.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<form class=\"form-signin well\">\n  <h2>Please sign in</h2>\n  <div class=\"alert alert-error\" id=\"sign-in-error\" style=\"display: none;\">\n    <strong>Error!</strong> <br /> You have typed wrong credentials!\n  </div>\n  <input type=\"text\" class=\"input-block-level\" placeholder=\"E-mail address\" id=\"email\">\n  <input type=\"password\" class=\"input-block-level\" placeholder=\"Password\" id=\"password\">\n  <button class=\"btn btn-large btn-primary\" type=\"button\" data-loading-text=\"Signing in...\"  id=\"sign-in\">Sign in</button>\n</form>\n";});
templates['status.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  


  return "<h1>Status</h1>\n\n\n";});
templates['welcome.tmpl'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1, foundHelper;
  buffer += "\n        <li><b>";
  foundHelper = helpers.start;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.start; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</b> - ";
  foundHelper = helpers.content;
  if (foundHelper) { stack1 = foundHelper.call(depth0, {hash:{}}); }
  else { stack1 = depth0.content; stack1 = typeof stack1 === functionType ? stack1() : stack1; }
  buffer += escapeExpression(stack1) + "</li>\n      ";
  return buffer;}

  buffer += "<h1>Welcome</h2>\n\n<div class=\"row-fluid\">\n  <p>\n    Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.\n  </p>\n</div>\n\n<div class=\"row-fluid\">\n  <h2>Agenda</h2>\n  <div class=\"span3\">\n    <ul>\n      ";
  stack1 = depth0.agenda;
  stack1 = helpers.each.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += " \n    </ul>\n  </div>\n\n  <div class=\"span8 hidden-phone\">\n    <div id=\"timeline\"></div>\n  </div>\n</div>\n\n<div class=\"row-fluid\">\n  <h2>Contest rules</h2>\n  <p>\n    Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.\n  </p>\n  <p>\n    Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.\n  </p>\n  <p>\n    Lorem ipsum dolor sit amet enim. Etiam ullamcorper. Suspendisse a pellentesque dui, non felis. Maecenas malesuada elit lectus felis, malesuada ultricies. Curabitur et ligula. Ut molestie a, ultricies porta urna. Vestibulum commodo volutpat a, convallis ac, laoreet enim. Phasellus fermentum in, dolor. Pellentesque facilisis. Nulla imperdiet sit amet magna. Vestibulum dapibus, mauris nec malesuada fames ac turpis velit, rhoncus eu, luctus et interdum adipiscing wisi. Aliquam erat ac ipsum. Integer aliquam purus. Quisque lorem tortor fringilla sed, vestibulum id, eleifend justo vel bibendum sapien massa ac turpis faucibus orci luctus non, consectetuer lobortis quis, varius in, purus. Integer ultrices posuere cubilia Curae, Nulla ipsum dolor lacus, suscipit adipiscing. Cum sociis natoque penatibus et ultrices volutpat. Nullam wisi ultricies a, gravida vitae, dapibus risus ante sodales lectus blandit eu, tempor diam pede cursus vitae, ultricies eu, faucibus quis, porttitor eros cursus lectus, pellentesque eget, bibendum a, gravida ullamcorper quam. Nullam viverra consectetuer. Quisque cursus et, porttitor risus. Aliquam sem. In hendrerit nulla quam nunc, accumsan congue. Lorem ipsum primis in nibh vel risus. Sed vel lectus. Ut sagittis, ipsum dolor quam.\n  </p>\n</div>\n";
  return buffer;});
})();