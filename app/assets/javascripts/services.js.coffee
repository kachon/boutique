class DropboxService
  constructor: (@client) ->
    console.log "dropbox service ctor"
    console.log "href #{window.location.href}" 
    
    @client = new Dropbox.Client({ key: "uonyr25yyc5c53z" })
    @client.authenticate (err, client) =>
      console.log "dropbox authenticate return #{err} #{JSON.stringify client, null, 2}"
      if (err)
        alert("Failed to authenticate dropbox #{err}")
        window.location.reload()
      else
        @client.getAccountInfo (error, accountInfo) ->
          if error
            console.log( "#{error}")
            return
          console.log ("#{JSON.stringify accountInfo}") 

window.dropboxService = new DropboxService()
