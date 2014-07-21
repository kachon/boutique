# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  console.log 'boutique main!??!'

  $("#main #logout_btn").click ->
    console.log 'logout btn clicked'

    DropboxClient.client.signOff() 

    token = $("meta[name='csrf-token']").attr("content")
    console.log "token #{token}"

    request = $.ajax 
      url: "/users/sign_out", 
      type: 'DELETE',
      headers:
        "X-CSRF-Token": token,
      contentType: 'application/json'
      success: (result) =>
        alert "Sign out successful"
        #$.mobile.changePage "#main"
        window.location.href = "/boutique_main/home"
