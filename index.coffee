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
        
        @terminal = new WebTermView
            delegate : @
            cssClass : "webterm"
            
        @terminal.on "WebTermConnected", (@remote) =>
            @runCommand command if command
          
        @button_1 = new KDButtonView
            title      : "Apache Error Log"
            callback   : =>
                command = "sudo tail -f /var/log/apache2/error.log"
                @runCommand command
                
        @button_2 = new KDButtonView
            title      : "Edit Apache Config"
            callback   : =>
                command = "sudo nano /etc/apache2/sites-enabled/default"
                @runCommand command
        
        @button_3 = new KDButtonView
            title      : "Enable mod_rewrite"
            callback   : =>
                command = "sudo a2enmod rewrite"
                @runCommand command
    
        @button_4 = new KDButtonView
            title       : "Enable mail() function"
            callback    : =>
                command = "sudo apt-get install sendmail; sudo sendmailconfig"
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
        <br>
        You can use the following common shortcuts.
        <br><br>
        <div class="content-wrapper">
            <div class="left">
                {{> @subtitle_1}}
                <br><br>
                {{> @button_1}}
                {{> @button_2}}
                {{> @button_3}}
                <br><br>
                {{> @subtitle_2}}
                <br><br>
                {{> @button_4}}
            </div>
            <div class="right">
                {{> @terminal}}
            </div>
        </div>
        """
    viewAppended: ->
        @setTemplate do @pistachio
    
    appView.addSubView new MainView
        cssClass: "wrapper"