var App,Glue,Gui,LocalStorage,UseCase,__hasProp={}.hasOwnProperty,__bind=function(a,b){return function(){return a.apply(b,arguments)}};_.defaults(this,{Before:function(a,b,c){return YouAreDaBomb(a,b).before(c)},BeforeAnyCallback:function(a,b,c){return YouAreDaBomb(a,b).beforeAnyCallback(c)},After:function(a,b,c){return YouAreDaBomb(a,b).after(c)},Around:function(a,b,c){return YouAreDaBomb(a,b).around(c)},AfterAll:function(a,b,c){var d,e,f,g;g=[];for(e=0,f=b.length;e<f;e++)d=b[e],g.push(After(a,d,c));return g},LogAll:function(a,b){var c,d,e;e=[];for(c in a){if(!__hasProp.call(a,c))continue;d=a[c],_.isFunction(d)?e.push(function(c){return Before(a,c,function(){return console.log("calling: "+b+"::"+c)})}(c)):e.push(void 0)}return e},AutoBind:function(a,b){var c,d,e;e=[];for(c in a)d=a[c],_.isFunction(d)?e.push(function(c){if(c.endsWith("Clicked")&&b[c.remove("Clicked")])return After(a,c,function(a){return b[c.remove("Clicked")](a)})}(c)):e.push(void 0);return e}}),App=function(){function a(){var a,b,c,d;d=new UseCase,b=new Gui,c=new LocalStorage("webcontest"),a=new Glue(d,b,c),d.start()}return a}(),$(function(){return new App}),Glue=function(){function a(a,b,c){var d=this;this.useCase=a,this.gui=b,this.storage=c,AutoBind(this.gui,this.useCase),LogAll(this.useCase,"UseCase"),LogAll(this.gui,"Gui"),LogAll(this.storage,"Storage"),After(this.useCase,"start",this.gui.start),After(this.gui,"signIn",function(a){return d.storage.signIn(a)}),After(this.storage,"signInResponse",function(a){return d.useCase.signIn(a)}),After(this.useCase,"signInError",this.gui.signInError),After(this.useCase,"signOut",this.gui.signOut),After(this.useCase,"loadContestList",function(){return d.gui.showContestList(d.useCase.contest_list)}),After(this.useCase,"openContest",function(a){return d.storage.getContest(a)}),After(this.storage,"contestResponse",function(a){return d.useCase.loadContest(a)}),Before(this.useCase,"loadContest",function(a){return d.gui.showContestArea(d.useCase.user,a)}),After(this.useCase,"contestWelcome",function(){return d.gui.showContestWelcome(d.useCase.contest)}),After(this.useCase,"problem",function(a){return d.gui.showProblem(d.useCase.getProblem(a),d.useCase.user)}),After(this.useCase,"status",function(){return d.gui.showStatus([])}),After(this.useCase,"ranking",function(){return d.gui.showRanking({})}),After(this.useCase,"messages",function(){return d.gui.showMessages([])}),After(this.useCase,"settings",function(){return d.gui.showSettingsForm({})})}return a}(),UseCase=function(){function a(){this.codeChanged=__bind(this.codeChanged,this),this.initCodeView=__bind(this.initCodeView,this),this.signOut=__bind(this.signOut,this),this.exitContestArea=__bind(this.exitContestArea,this),this.settings=__bind(this.settings,this),this.messages=__bind(this.messages,this),this.ranking=__bind(this.ranking,this),this.status=__bind(this.status,this),this.getProblem=__bind(this.getProblem,this),this.problem=__bind(this.problem,this),this.contestWelcome=__bind(this.contestWelcome,this),this.loadContest=__bind(this.loadContest,this),this.openContest=__bind(this.openContest,this),this.loadContestList=__bind(this.loadContestList,this),this.signInError=__bind(this.signInError,this),this.signIn=__bind(this.signIn,this),this.start=__bind(this.start,this),this.user={},this.contest_list=[],this.contest={}}return a.prototype.start=function(){},a.prototype.signIn=function(a){return a?(this.user=a.user,this.contest_list=a.contest_list,this.loadContestList()):this.signInError()},a.prototype.signInError=function(){},a.prototype.loadContestList=function(){},a.prototype.openContest=function(a){},a.prototype.loadContest=function(a){return this.contest=a,this.contestWelcome()},a.prototype.contestWelcome=function(){},a.prototype.problem=function(a){},a.prototype.getProblem=function(a){return this.contest.problems.find({id:a})},a.prototype.status=function(){},a.prototype.ranking=function(){},a.prototype.messages=function(){},a.prototype.settings=function(){},a.prototype.exitContestArea=function(){return this.loadContestList()},a.prototype.signOut=function(){},a.prototype.initCodeView=function(){},a.prototype.codeChanged=function(a){},a}(),Gui=function(){function a(){this.signOut=__bind(this.signOut,this),this.showSettingsForm=__bind(this.showSettingsForm,this),this.showMessages=__bind(this.showMessages,this),this.showRanking=__bind(this.showRanking,this),this.showStatus=__bind(this.showStatus,this),this.codeChanged=__bind(this.codeChanged,this),this._saveCodeCallback=__bind(this._saveCodeCallback,this),this._initCodeView=__bind(this._initCodeView,this),this._resizeFixedHeightContainer=__bind(this._resizeFixedHeightContainer,this),this._initProblemPageLayout=__bind(this._initProblemPageLayout,this),this.showProblem=__bind(this.showProblem,this),this._initTimeline=__bind(this._initTimeline,this),this.showContestWelcome=__bind(this.showContestWelcome,this),this.signOutClicked=__bind(this.signOutClicked,this),this.exitContestAreaClicked=__bind(this.exitContestAreaClicked,this),this.settingsClicked=__bind(this.settingsClicked,this),this.messagesClicked=__bind(this.messagesClicked,this),this.rankingClicked=__bind(this.rankingClicked,this),this.statusClicked=__bind(this.statusClicked,this),this.problemClicked=__bind(this.problemClicked,this),this.contestWelcomeClicked=__bind(this.contestWelcomeClicked,this),this._setActiveNavMenuItem=__bind(this._setActiveNavMenuItem,this),this._loadProblemsMenu=__bind(this._loadProblemsMenu,this),this.showContestArea=__bind(this.showContestArea,this),this.openContestClicked=__bind(this.openContestClicked,this),this.registerForContestClicked=__bind(this.registerForContestClicked,this),this.showContestList=__bind(this.showContestList,this),this.signInError=__bind(this.signInError,this),this.signIn=__bind(this.signIn,this),this.signInFired=__bind(this.signInFired,this),this.showSignInForm=__bind(this.showSignInForm,this),this.start=__bind(this.start,this),this._setLayout=__bind(this._setLayout,this),this._render=__bind(this._render,this),this.saveCodeEvery=15,this.fadeInTimeout=200}return a.prototype._render=function(a,b,c){var d;return console.log("template = "+a),a=Handlebars.templates[a],d=a(c),$(b).hide().html(d).fadeIn(200)},a.prototype._setLayout=function(a){return this._render("layout-"+a+".tmpl","body",{})},a.prototype.start=function(){return this.showSignInForm()},a.prototype.showSignInForm=function(){var a=this;return this._setLayout("center"),this._render("sign-in.tmpl","#main",{}),$("#sign-in").click(function(){return a.signInFired()}),$("#email").enterKey(function(){return a.signInFired()}),$("#password").enterKey(function(){return a.signInFired()})},a.prototype.signInFired=function(){var a;return a={email:$("#email").val(),password:$("#password").val()},this.signIn(a)},a.prototype.signIn=function(a){return $("#sign-in").off("click").addClass("disabled").text("Signing in..."),$("#sign-in-error").hide("fast")},a.prototype.signInError=function(){var a=this;return $("#sign-in-error").show("fast"),$("#sign-in").removeClass("disabled").text("Sign in").click(function(){return a.signInFired()})},a.prototype.showContestList=function(a){var b=this;return this._setLayout("center"),console.log(a),this._render("contest-list.tmpl","#main",a),$(".register-for-contest").click(function(a){return b.registerForContestClicked($(a).attr("id"))}),$(".open-contest").click(function(a){return b.openContestClicked($(a).attr("id"))}),$("#sign-out").click(function(){return b.signOutClicked()})},a.prototype.registerForContestClicked=function(a){},a.prototype.openContestClicked=function(a){return $(".open-contest").off("click").addClass("disabled").text("Loading...")},a.prototype.showContestArea=function(a,b){var c=this;return console.log(b),this._setLayout("navbar"),$("#contest-welcome").text(b.name),$("#user-name").text(a.name),this._loadProblemsMenu(b.problems),$("#contest-welcome").click(function(){return c.contestWelcomeClicked()}),$("#status").click(function(){return c.statusClicked()}),$("#ranking").click(function(){return c.rankingClicked()}),$("#messages").click(function(){return c.messagesClicked()}),$("#settings").click(function(){return c.settingsClicked()}),$("#exit-contest-area").click(function(){return c.exitContestAreaClicked()}),$("#sign-out").click(function(){return c.signOutClicked()})},a.prototype._loadProblemsMenu=function(a){var b=this;return a.each(function(a){var c;return c=$("<a>").attr("id",a.id).text(a.name).click(function(c){return b.problemClicked(a.id)}),$("ul#problems-list").append($("<li>").append(c))})},a.prototype._setActiveNavMenuItem=function(a){$("ul#navigation li").removeClass("active");if(a!=="")return $("#"+a).parent().addClass("active")},a.prototype.contestWelcomeClicked=function(){return this._setActiveNavMenuItem("")},a.prototype.problemClicked=function(a){return this._setActiveNavMenuItem("problems")},a.prototype.statusClicked=function(){return this._setActiveNavMenuItem("status")},a.prototype.rankingClicked=function(){return this._setActiveNavMenuItem("ranking")},a.prototype.messagesClicked=function(){return this._setActiveNavMenuItem("")},a.prototype.settingsClicked=function(){return this._setActiveNavMenuItem("")},a.prototype.exitContestAreaClicked=function(){},a.prototype.signOutClicked=function(){},a.prototype.showContestWelcome=function(a){return this._render("welcome.tmpl","#main",a),this._initTimeline(a.agenda)},a.prototype._initTimeline=function(a){var b,c,d,e,f,g,h=this;return f=a.map(function(a){return{start:Date.create(a.start),content:'<span class="badge badge-info">'+a.content+"</span>"}}),b=f.map(function(a){return a.start}),d=Date.create(b.min()),c=Date.create(b.max()),g={start:d.rewind({hours:1}),end:c.rewind({hours:-2}),width:"100%",style:"dot",zoomable:!1,selectable:!1,moveable:!1,showMajorLabels:!1,showCurrentTime:!0},e=new links.Timeline(document.getElementById("timeline")),e.draw(f,g),e.setCurrentTime(Date.create("2012-12-24 16:05:22")),$(window).on("resize",function(){return e.redraw()})},a.prototype.showProblem=function(a,b){var c=this;return this._render("problem.tmpl","#main",a),this._resizeFixedHeightContainer(),this._initProblemPageLayout(),$(window).on("resize",function(){return c._resizeFixedHeightContainer()}),this._initCodeView(b.code_template)},a.prototype._initProblemPageLayout=function(){return $(".fixed-height-container").layout({applyDefaultStyles:!1,livePaneResizing:!0,slidable:!1,center__paneSelector:"#problem-description",east__paneSelector:"#coding-panel",east__size:.5,east__minSize:380,east__maxSize:.8}),$("#tab-code").layout({applyDefaultStyles:!1,livePaneResizing:!0,slidable:!1,center__paneSelector:"#code-editor-container",south__paneSelector:"#code-messages-container",south__size:.25,south__minSize:.1,south__maxSize:.9,south__initClosed:!0})},a.prototype._resizeFixedHeightContainer=function(){return $(".fixed-height-container").height(window.innerHeight-$(".navbar").height()-40),$(".tab-content").height($("#coding-panel").height()-$("#coding-panel .nav-tabs").height()-1)},a.prototype._initCodeView=function(a){var b,c;return c={mode:"text/x-c++src",theme:"monokai",lineNumbers:!0,indentUnit:4},b=document.getElementById("codemirror"),this.cm=CodeMirror.fromTextArea(b,c),this.cm.setValue(a),this.cm.markClean(),setTimeout(this._saveCodeCallback,this.saveCodeEvery*1e3)},a.prototype._saveCodeCallback=function(){return this.cm.isClean()||this.codeChanged(this.cm.getValue()),this.cm.markClean(),setTimeout(this._saveCodeCallback,this.saveCodeEvery*1e3)},a.prototype.codeChanged=function(a){},a.prototype.showStatus=function(a){return this._render("status.tmpl","#main",a)},a.prototype.showRanking=function(a){return this._render("ranking.tmpl","#main",a)},a.prototype.showMessages=function(a){return this._render("messages.tmpl","#main",a)},a.prototype.showSettingsForm=function(a){return this._render("settings.tmpl","#main",a)},a.prototype.signOut=function(){return this.start()},a}(),LocalStorage=function(){function a(a){this.namespace=a,this.contestResponse=__bind(this.contestResponse,this),this.getContest=__bind(this.getContest,this),this.signInResponse=__bind(this.signInResponse,this),this.signIn=__bind(this.signIn,this),this.getCode=__bind(this.getCode,this),this.setCode=__bind(this.setCode,this),this.flush=__bind(this.flush,this),this.remove=__bind(this.remove,this),this.get=__bind(this.get,this),this.set=__bind(this.set,this)}return a.prototype.set=function(a,b){return $.jStorage.set(""+this.namespace+"/"+a,b)},a.prototype.get=function(a){return $.jStorage.get(""+this.namespace+"/"+a)},a.prototype.remove=function(a){return $.jStorage.deleteKey(""+this.namespace+"/"+a)},a.prototype.flush=function(){var a,b,c,d,e;d=$.jStorage.index(),e=[];for(b=0,c=d.length;b<c;b++)a=d[b],a.match("^"+this.namespace)?e.push($.jStorage.deleteKey(a)):e.push(void 0);return e},a.prototype.setCode=function(a){return this.set("code",a)},a.prototype.getCode=function(){return this.get("code")||'#include<iostream>\nusing namespace std;\n\nint main() {\n    cout << "Hello World!" << endl;\n    return 0;\n}'},a.prototype.signIn=function(a){var b,c=this;return a.email===""&&a.password===""?(b={user:{name:"Piotr Krzemiński",email:"pio.krzeminski@gmail.com",language:"c++",code_template:'/*\n * Piotr Krzemiński\n * Web Programming Contest demo (2012-12-24)\n * Problem easy\n */\n\n#include <cstdio>\n#include <cstring>\n#include <algorithm>\n#include <functional>\n\nusing namespace std;\n\nint T, C, R, max_d = 0;\nbool BOARD[1000][1000];\nbool VISITED[1000][1000];\nchar line[1001];\npair<int, int> start;\n\nint dfs(int row, int col)\n{\n    if(row < 0 || row >= R || col < 0 || col >= C) return 0;\n    if(VISITED[row][col]) return 0;\n    if(!BOARD[row][col]) return 0;\n    VISITED[row][col] = true;\n\n    int t[4];\n    t[0] = dfs(row, col - 1);\n    t[1] = dfs(row - 1, col);\n    t[2] = dfs(row, col + 1);\n    t[3] = dfs(row + 1, col);\n\n    partial_sort(t, t + 2, t + 4, greater<int>());\n\n    if(t[0] + t[1] + 1 > max_d)\n        max_d = t[0] + t[1] + 1;\n\n    return 1 + t[0];\n}\n\nint main()\n{\n    scanf("%d", &T);\n\n    while(T--)\n    {\n        memset(BOARD, 0, 1000000);\n        memset(VISITED, 0, 1000000);\n        max_d = 0;\n        scanf("%d %d\\n", &C, &R);\n        for(int r = 0; r < R; ++r)\n        {\n            scanf("%s\\n", line);\n            for(int c = 0; c < C; ++c)\n            {\n                BOARD[r][c] = (line[c] != \'#\');\n                if(BOARD[r][c])\n                {\n                    start.first = r;\n                    start.second = c;\n                }\n            }\n        }\n        max_d = max(max_d, dfs(start.first, start.second));\n        printf("Maximum rope length is %d.\\n", max_d - 1);\n    }\n\n    return 0;\n}'},contest_list:[{id:"1",name:"NSN Programming Open (Qualification Round I)",date:"27.06.2013 17:00",registered:!0,active:!0},{id:"2",name:"NSN AlgoMatch C++ #1",date:"15.07.2013 19:00",registered:!0,active:!1},{id:"3",name:"NSN AlgoMatch C++ #2",date:"31.07.2013",registered:!1},{id:"4",name:"NSN Programming Open (Qualification round II)",date:"08.08.2013",registered:!1},{id:"5",name:"NSN AlgoMatch C++ #3",date:"19.08.2013",registered:!1},{id:"6",name:"NSN AlgoMatch C++ #4",date:"28.08.2013",registered:!1},{id:"7",name:"NSN Programming Open Finals",date:"05.09.2013",registered:!1}]},setTimeout(function(){return c.signInResponse(b)},100)):setTimeout(function(){return c.signInResponse(!1)},600)},a.prototype.signInResponse=function(a){},a.prototype.getContest=function(a){var b,c=this;return b={id:"1",name:"Web Programming Contest demo",agenda:[{start:"2012-12-24 13:00:00",content:"Registration end"},{start:"2012-12-24 13:10:00",content:"Trial round start"},{start:"2012-12-24 14:00:00",content:"Trial round end"},{start:"2012-12-24 14:10:00",content:"Main round start"},{start:"2012-12-24 17:40:00",content:"Main round end"},{start:"2012-12-24 17:00:00",content:"Ranking freeze"},{start:"2012-12-24 18:00:00",content:"Results publish"}],problems:[{id:"1",name:"Problem easy",limits:{time:"2.0",memory:"64",sourceCode:"10240"},description:"Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",input_specification:"Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",output_specification:"Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie. Nulla eget nisl. Nam feugiat, quam nibh sit amet, libero. Sed vel pulvinar nonummy nunc eu quam. Phasellus blandit, quam. Integer tristique velit, fermentum imperdiet ut, sapien. Curabitur quam accumsan dictum, laoreet a, massa. Maecenas vehicula, dui nulla, egestas.",testcases:[{input:"5\n4 7 2 9 0",output:"0 9"},{input:"10\n1 2 5 9 231232 4324 3214 5435 3 545",output:"1 231232"},{input:"5\n7\n2\n7\n4\n8\n8\n8\n",output:"1232\n12323\n76\n8\n2\n"}],testcases_explanation:"Lorem ipsum dolor sit amet nunc vel quam. Maecenas fermentum pellentesque quis, lorem. Pellentesque quam sed orci sit amet, nonummy lacinia eros cursus quis, placerat eget, aliquam vitae, vulputate luctus. Sed accumsan faucibus. Maecenas quam porta ut, metus. Morbi tincidunt. Nullam justo at nunc sollicitudin leo sit amet, consectetuer tincidunt wisi accumsan lectus semper aliquam arcu. Suspendisse egestas ac, vehicula ut, diam. Fusce iaculis, diam pede tortor a odio leo, pretium sit amet, felis. Nulla iaculis leo, aliquet feugiat sit amet leo. Suspendisse pede. In vitae odio et magnis dis parturient montes, nascetur ridiculus mus. Nunc ut malesuada ultricies urna quis wisi. Donec lectus vulputate fringilla. Morbi nisl tristique sodales. Vivamus justo. Phasellus sagittis porta, metus tellus, imperdiet orci luctus et velit in nunc. Vestibulum quam. Curabitur sit amet sapien pede bibendum ac, felis. Duis blandit lectus. Vestibulum turpis vulputate molestie."},{id:"2",name:"Stones in my passway"},{id:"3",name:"Brilliant room"},{id:"4",name:"Driving towards the daylight"},{id:"5",name:"Planet Welfare"},{id:"6",name:"Gem"}]},setTimeout(function(){return c.contestResponse(b)},800)},a.prototype.contestResponse=function(a){},a}()