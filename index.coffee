# Terminal Shortcuts app

class MainView extends JView
    constructor:->
        super
        
        # Header
        @header = new KDHeaderView
            type: "big"
            title: "Terminal Shortcuts"
        
        # The terminal
        @terminal = new WebTermView
            delegate : @
            cssClass : "webterm"
            advancedSettings: no
            
        @terminal.on "WebTermConnected", (@remote) =>
            #@runCommand command if command
            
        @button_clear = new KDButtonView
            title       : "Clear Terminal"
            callback    : =>
                command = "clear"
                @runCommand command
        
        @button_large = new KDOnOffSwitch
            defaultValue  : on
            title         : "Small terminal"
            size          : "medium"
            cssClass      : "terminal-switch"
            callback      : (state) =>
                if state 
                then @TabView.show @terminal.unsetClass "terminal-large"
                else @TabView.hide @terminal.setClass "terminal-large"
                
        # Apache buttons
        button_1 = new KDButtonView
            title      : "Restart Apache Server"
            callback   : =>
                command = "sudo service apache2 restart"
                @runCommand command
                
        button_2 = new KDButtonView
            title      : "Apache Error Log"
            callback   : =>
                command = "sudo tail -f /var/log/apache2/error.log"
                @runCommand command
                
        button_3 = new KDButtonView
            title      : "Edit Apache Config"
            callback   : =>
                command = "sudo nano /etc/apache2/sites-enabled/default"
                @runCommand command
        
        button_4 = new KDButtonView
            title      : "Enable mod_rewrite"
            callback   : =>
                command = "sudo a2enmod rewrite"
                @runCommand command
        
        # PHP buttons
        button_5 = new KDButtonView
            title       : "Enable mail() function"
            callback    : =>
                command = "sudo apt-get install sendmail; sudo sendmailconfig"
                @runCommand command
        
        # Misc buttons
        button_6 = new KDButtonView
            title       : "Check Syslog"
            callback    : =>
                command = "sudo tail -f /var/log/syslog"
                @runCommand command  
        
        # Tabs view    
        @TabView = new KDTabView
            cssClass      : "tabs"
            hideHandleCloseIcons : yes
        
        @TabView.addPane apacheTab = new KDTabPaneView
            name          : "Apache"
            cssClass      : "apache-tab"
        
        @TabView.addPane phpTab = new KDTabPaneView
            name          : "PHP"
            cssClass      : "php-tab"
        
        @TabView.addPane miscTab = new KDTabPaneView
            name          : "Misc"
            cssClass      : "misc-tab"
        
        apacheTab.addSubView apacheView = new KDView
            cssClass      : "apache-tab-wrapper"
            partial       : "<div class='tab-header'>Common Apache shortcuts.</div>"
        
        apacheView.addSubView button_1
        apacheView.addSubView button_2
        apacheView.addSubView button_3
        apacheView.addSubView button_4
        
        phpTab.addSubView phpView = new KDView
            cssClass      : "php-tab-wrapper"
            partial       : "<div class='tab-header'>Common PHP shortcuts.</div>"
            
        phpView.addSubView button_5
        
        miscTab.addSubView miscView = new KDView
            cssClass      : "misc-tab-wrapper"
            partial       : "<div class='tab-header'>Misc shortcuts.e</div>"
        
        miscView.addSubView button_6
            
        @TabView.showPaneByIndex 0
                
    runCommand: (command) ->
        return unless command 
        if @remote
          @remote.input "#{command}\n"
          @terminal.click()
        
    pistachio:->
        """
        <header>
            {{> @header}}
            <div class="spacer">
                If you are not familiar with the Terminal interface you can use this common shortcuts to get the results you want.<br>
                <i>For suggestions and bug reports you can PM <a href="/stefanbc">@stefanbc</a> or open up an issue on <a href="https://github.com/stefanbc/TerminalShortcuts.kdapp/issues" target="_blank">Github</a>.</i>
            </div>
        </header>
        <div class="content-wrapper">
            <div class="left">
                <div class="spacer">
                    <i class="notification">Each shortcut needs root access.</i>
                </div>
                {{> @TabView}}
            </div>
            <div class="right">
                <div class="clear_button">
                    {{> @button_large}} {{> @button_clear}}
                </div>
                <div class="terminal-wrapper">
                    {{> @terminal}}
                </div>
            </div>
        </div>
        """
    viewAppended: ->
        @setTemplate do @pistachio
    
    appView.addSubView new MainView
        cssClass: "wrapper"