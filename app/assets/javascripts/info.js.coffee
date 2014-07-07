class window.Info

  @show_info: ->
    console.log "show info"

$ ->
  $("#info_btn").click ->
    console.log "info button click"
    Info.show_info()