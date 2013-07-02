/* Compiled by kdc on Tue Jul 02 2013 08:29:27 GMT+0000 (UTC) */
(function() {
/* KDAPP STARTS */
/* BLOCK STARTS: /home/stefanbc/Applications/TerminalShortcuts.kdapp/index.coffee */
var MainView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

MainView = (function(_super) {
  __extends(MainView, _super);

  function MainView() {
    var _this = this;
    MainView.__super__.constructor.apply(this, arguments);
    this.header = new KDHeaderView({
      type: "big",
      title: "Terminal Shortcuts"
    });
    this.subtitle_1 = new KDHeaderView({
      type: "medium",
      title: "Apache Shortcuts"
    });
    this.subtitle_2 = new KDHeaderView({
      type: "medium",
      title: "PHP"
    });
    this.terminal = new WebTermView({
      delegate: this,
      cssClass: "webterm"
    });
    this.terminal.on("WebTermConnected", function(remote) {
      _this.remote = remote;
      if (command) {
        return _this.runCommand(command);
      }
    });
    this.button_1 = new KDButtonView({
      title: "Apache Error Log",
      callback: function() {
        var command;
        command = "sudo tail -f /var/log/apache2/error.log";
        return _this.runCommand(command);
      }
    });
    this.button_2 = new KDButtonView({
      title: "Edit Apache Config",
      callback: function() {
        var command;
        command = "sudo nano /etc/apache2/sites-enabled/default";
        return _this.runCommand(command);
      }
    });
    this.button_3 = new KDButtonView({
      title: "Enable mod_rewrite",
      callback: function() {
        var command;
        command = "sudo a2enmod rewrite";
        return _this.runCommand(command);
      }
    });
    this.button_4 = new KDButtonView({
      title: "Enable mail() function",
      callback: function() {
        var command;
        command = "sudo apt-get install sendmail; sudo sendmailconfig";
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
    return "{{> this.header}}\n<br>\nYou can use the following common shortcuts. <i>For each shortcut you need root access.</i>\n<br><br>\n<div class=\"content-wrapper\">\n    <div class=\"left\">\n        {{> this.subtitle_1}}\n        <br><br>\n        {{> this.button_1}}\n        {{> this.button_2}}\n        {{> this.button_3}}\n        <br><br>\n        {{> this.subtitle_2}}\n        <br><br>\n        {{> this.button_4}}\n    </div>\n    <div class=\"right\">\n        <div class=\"clear_button\">\n            {{> this.button_clear}}\n        </div>\n        {{> this.terminal}}\n    </div>\n</div>";
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