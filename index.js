/* Compiled by kdc on Mon Jul 29 2013 07:13:26 GMT+0000 (UTC) */
(function() {
/* KDAPP STARTS */
/* BLOCK STARTS: /home/stefanbc/Applications/TerminalShortcuts.kdapp/index.coffee */
var MainView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

MainView = (function(_super) {
  __extends(MainView, _super);

  function MainView() {
    var apacheTab, apacheView, button_1, button_2, button_3, button_4, button_5, button_6, miscTab, miscView, phpTab, phpView,
      _this = this;
    MainView.__super__.constructor.apply(this, arguments);
    this.header = new KDHeaderView({
      type: "big",
      title: "Terminal Shortcuts"
    });
    this.terminal = new WebTermView({
      delegate: this,
      cssClass: "webterm",
      advancedSettings: false
    });
    this.terminal.on("WebTermConnected", function(remote) {
      _this.remote = remote;
      if (command) {
        return _this.runCommand(command);
      }
    });
    this.button_clear = new KDButtonView({
      title: "Clear Terminal",
      callback: function() {
        var command;
        command = "clear";
        return _this.runCommand(command);
      }
    });
    this.button_large = new KDOnOffSwitch({
      defaultValue: true,
      title: "Small terminal",
      size: "medium",
      cssClass: "terminal-switch",
      callback: function(state) {
        if (state) {
          return _this.TabView.show(_this.terminal.unsetClass("terminal-large"));
        } else {
          return _this.TabView.hide(_this.terminal.setClass("terminal-large"));
        }
      }
    });
    button_1 = new KDButtonView({
      title: "Restart Apache Server",
      callback: function() {
        var command;
        command = "sudo service apache2 restart";
        return _this.runCommand(command);
      }
    });
    button_2 = new KDButtonView({
      title: "Apache Error Log",
      callback: function() {
        var command;
        command = "sudo tail -f /var/log/apache2/error.log";
        _this.runCommand(command);
        return _this.terminal.terminal.setFocused();
      }
    });
    button_3 = new KDButtonView({
      title: "Edit Apache Config",
      callback: function() {
        var command;
        command = "sudo nano /etc/apache2/sites-enabled/default";
        return _this.runCommand(command);
      }
    });
    button_4 = new KDButtonView({
      title: "Enable mod_rewrite",
      callback: function() {
        var command;
        command = "sudo a2enmod rewrite";
        return _this.runCommand(command);
      }
    });
    button_5 = new KDButtonView({
      title: "Enable mail() function",
      callback: function() {
        var command;
        command = "sudo apt-get install sendmail; sudo sendmailconfig";
        return _this.runCommand(command);
      }
    });
    button_6 = new KDButtonView({
      title: "Check Syslog",
      callback: function() {
        var command;
        command = "sudo tail -f /var/log/syslog";
        return _this.runCommand(command);
      }
    });
    this.TabView = new KDTabView({
      cssClass: "tabs",
      hideHandleCloseIcons: true
    });
    this.TabView.addPane(apacheTab = new KDTabPaneView({
      name: "Apache",
      cssClass: "apache-tab"
    }));
    this.TabView.addPane(phpTab = new KDTabPaneView({
      name: "PHP",
      cssClass: "php-tab"
    }));
    this.TabView.addPane(miscTab = new KDTabPaneView({
      name: "Misc",
      cssClass: "misc-tab"
    }));
    apacheTab.addSubView(apacheView = new KDView({
      cssClass: "apache-tab-wrapper",
      partial: "<div class='tab-header'>Common Apache shortcuts.</div>"
    }));
    apacheView.addSubView(button_1);
    apacheView.addSubView(button_2);
    apacheView.addSubView(button_3);
    apacheView.addSubView(button_4);
    phpTab.addSubView(phpView = new KDView({
      cssClass: "php-tab-wrapper",
      partial: "<div class='tab-header'>Common PHP shortcuts.</div>"
    }));
    phpView.addSubView(button_5);
    miscTab.addSubView(miscView = new KDView({
      cssClass: "misc-tab-wrapper",
      partial: "<div class='tab-header'>Misc shortcuts.e</div>"
    }));
    miscView.addSubView(button_6);
    this.TabView.showPaneByIndex(0);
  }

  MainView.prototype.runCommand = function(command) {
    var _this = this;
    if (!command) {
      return;
    }
    if (this.remote) {
      return this.remote.input("" + command + "\n");
    }
    if (!this.remote && !this.triedAgain) {
      return this.utils.wait(2000, function() {
        _this.runCommand(command);
        return _this.triedAgain = true;
      });
    }
  };

  MainView.prototype.pistachio = function() {
    return "<header>\n    {{> this.header}}\n    <div class=\"spacer\">\n        If you are not familiar with the Terminal interface you can use this common shortcuts to get the results you want.<br>\n        <i>For suggestions and bug reports you can PM <a href=\"/stefanbc\">@stefanbc</a> or open up an issue on <a href=\"https://github.com/stefanbc/TerminalShortcuts.kdapp/issues\" target=\"_blank\">Github</a>.</i>\n    </div>\n</header>\n<div class=\"content-wrapper\">\n    <div class=\"left\">\n        <div class=\"spacer\">\n            <i class=\"notification\">Each shortcut needs root access.</i>\n        </div>\n        {{> this.TabView}}\n    </div>\n    <div class=\"right\">\n        <div class=\"clear_button\">\n            {{> this.button_large}} {{> this.button_clear}}\n        </div>\n        <div class=\"terminal-wrapper\">\n            {{> this.terminal}}\n        </div>\n    </div>\n</div>";
  };

  MainView.prototype.viewAppended = function() {
    return this.setTemplate(this.pistachio());
  };

  appView.addSubView(new MainView({
    cssClass: "wrapper"
  }));

  return MainView;

})(JView);

/* KDAPP ENDS */
}).call();