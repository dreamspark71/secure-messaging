


function connect() 
    {
        //alert('connect');
        var username = document.getElementById("username").value;
        document.getElementById("user").innerHTML = username;
            //create a new instance of the websocket
            ws = new WebSocket("ws://" + document.location.host + "/secure-messaging/chat/" + username);
        
            var log = document.getElementById("log");
            log.innerHTML += username + " has been connected!!!" + "\n";
        
            
        ws.onmessage = function(event) 
        {
            var log = document.getElementById("log");
            console.log(event.data);
            var message = JSON.parse(event.data);
            
            text = message.content;
            
            document.getElementById("decrtext").value = text;

            log.innerHTML += message.from + " : " + message.content + "\n";
            
        };
    }

    function send()
    {

        var content = document.getElementById("encrtext").value;
        var to = document.getElementById("to").value;
        
        var json = JSON.stringify({
            "to":to,
            "content":content,
        });

        ws.send(json);
        log.innerHTML += "Me : " + content + "\n";
        
    }
    
    
