class window.DropboxClient
  @client = null

  @init: ->
    console.log 'init dropbox'
    @client = new Dropbox.Client({ key: "uonyr25yyc5c53z" })

    @client.authenticate (err, client) =>
      if (err)
        alert error
      else
        console.log ("login here!!!")
        @client = client

$ ->
  DropboxClient.init()
  # console.log 'dropbox'
  # client = new Dropbox.Client({ key: "uonyr25yyc5c53z" })

  # client.authenticate (err, client) ->
  #   if (err)
  #     alert error
  #     return
  #   else
  #     console.log ("login here!!!")
  #     # client.getAccountInfo {}, (error, accountInfo, obj) ->
  #     #   console.log ("after getting account info ")
  #     #   console.log ("#{JSON.stringify accountInfo, null, 2}")
  #     # client.readdir "/", {}, (error, strs, stat, stats) ->
  #     #   console.log ("after readdir ")
  #     #   console.log ("#{JSON.stringify strs, null, 2}")
  #     xhr = client.thumbnailUrl "/worldcup.jpeg", {size: 'l'}
  #     console.log ("#{xhr}")
  #     # url = xhr
  #     # $('#target').append("<img src=\"#{url}\" alt=\"my image\"/>");