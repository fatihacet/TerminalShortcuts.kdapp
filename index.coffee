# Terminal Shortcuts app

class MainView extends JView
    constructor:->
        super
        @header = new KDHeaderView
            type: "big"
            title: "Terminal Shortcuts"
            
        @subtitle_1 = new KDHeaderView
            type: "medium"
            title: "Apache Shortcuts"
            
        @subtitle_2 = new KDHeaderView
            type: "medium"
            title: "PHP"
        
        @subtitle_3 = new KDHeaderView
            type: "medium"
            title: "Misc"
        
        @terminal = new WebTermView
            delegate : @
            cssClass : "webterm"
            
        @terminal.on "WebTermConnected", (@remote) =>
            @runCommand command if command

        @button_1 = new KDButtonView
            title      : "Restart Apache Server"
            callback   : =>
                command = "sudo service apache2 restart"
                @runCommand command

        @button_2 = new KDButtonView
            title      : "Apache Error Log"
            callback   : =>
                command = "sudo tail -f /var/log/apache2/error.log"
                @runCommand command
                
        @button_3 = new KDButtonView
            title      : "Edit Apache Config"
            callback   : =>
                command = "sudo nano /etc/apache2/sites-enabled/default"
                @runCommand command
        
        @button_4 = new KDButtonView
            title      : "Enable mod_rewrite"
            callback   : =>
                command = "sudo a2enmod rewrite"
                @runCommand command
    
        @button_5 = new KDButtonView
            title       : "Enable mail() function"
            callback    : =>
                command = "sudo apt-get install sendmail; sudo sendmailconfig"
                @runCommand command
        
        @button_6 = new KDButtonView
            title       : "Check Syslog"
            callback    : =>
                command = "sudo tail -f /var/log/syslog"
                @runCommand command
        
        #@button_large = new KDOnOffSwitch
            #defaultValue  : off
            #title         : "Full with terminal"
            #size          : "medium"
            #cssClass      : "terminal-switch"
             #callback      : (state) ->
                 #if state                

        @button_clear = new KDButtonView
            title       : "Clear Terminal"
            callback    : =>
                command = "clear"
                @runCommand command 
                
    runCommand: (command) ->
        return unless command 
        return @remote.input "#{command}\n" if @remote
        
        if not @remote and not @triedAgain
          @utils.wait 2000, =>
            @runCommand command
            @triedAgain = yes
        
    pistachio:->
        """
        {{> @header}}
        <div class="spacer">
            You can use the following common shortcuts. For suggestions and bug reports you can PM <a href="/stefanbc">@stefanbc</a> or open up an issue on <a href="https://github.com/stefanbc/TerminalShortcuts.kdapp/issues" target="_blank">Github</a>.
        </div>
        <div class="content-wrapper">
            <div class="left">
                <div class="spacer">
                    <i class="notification">Each shortcut needs root access.</i>
                </div>
                {{> @subtitle_1}}
                <br><br>
                {{> @button_1}}
                {{> @button_2}}
                {{> @button_3}}
                <br><br>
                {{> @button_4}}
                <br><br>
                {{> @subtitle_2}}
                <br><br>
                {{> @button_5}}
                <br><br>
                {{> @subtitle_3}}
                <br><br>
                {{> @button_6}}
            </div>
            <div class="right">
                <div class="clear_button">
                    {{> @button_clear}}
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