class window.Clothing
  @ACTION = 'POST'

  @url: ->
    "/clothings/"

  @form_data: ->
    console.log "clothing form_data"
    data = {}
    data.date = $('#clothing #date').val()
    data.desc = $('#clothing #desc').val()
    data.unit_price = $('#clothing #unit_price').val()
    #parseFloat($('#clothing #unit_price').val())
    return { clothing: data }

  @post: =>
    post_url = "#{@url()}"
    data = JSON.stringify @form_data()
    #data = @form_data()
    console.log "post_url #{post_url} #{data}"
    # request = $.post post_url, data, (result) =>
    #   info = result
    #   alert "Repair Id: #{info.id}"
    #   $.mobile.changePage "#main"
    request = $.ajax 
      url: post_url, 
      type: 'POST',
      data: data,
      contentType: 'application/json'
      success: (result) =>
        info = result
        alert "Clothing Id: #{info.id}"
        $.mobile.changePage "#main"

    request.fail (jqXHR, textStatus) =>
      alert JSON.parse(jqXHR.responseText).msg

  @reset: ->
    $('#clothing #update_div').hide()
    $('#clothing #clothing_id').val ""
    $('#clothing #date').val ""
    $('#clothing #desc').val ""
    $('#clothing #unit_price').val "0.0"

  @get: (input) =>
    $('#clothing #update_div').show()
    $('#clothing .input').hide()
    console.log "get_clothing: #{input}"
    get_url = "#{@url()}#{input}/"

    request = $.get get_url, (result) => 
      # data = JSON.parse result
      console.log "data #{JSON.stringify result, null, 2}"
      @display_data result

    request.fail (jqXHR, textStatus) =>
      alert jqXHR.responseText
      $.mobile.changePage "#main"

  @put: (input) =>
    put_url = "#{@url()}#{input}/"
    data = JSON.stringify @form_data()
    console.log "put_url #{put_url} #{data}"
    request = $.ajax(
      type: "PUT"
      url: put_url
      data: data
      contentType: 'application/json'
    )
    request.done (result) =>
      info = result
      alert "Clothing Id: #{info.id}"
      $.mobile.changePage "#main"
    request.fail (jqXHR, textStatus) =>
      alert jqXHR.responseText

  @display_data: (data) =>
    if @ACTION == 'PUT'
      $.mobile.changePage "#clothing"
      $('#clothing #clothing_id').val data.id
      $('#clothing #date').val data.date
      $('#clothing #desc').val data.desc
      $('#clothing #unit_price').val data.unit_price
    else if @ACTION == 'GET'
      $.mobile.changePage "#clothing_info"
      $('#clothing_info #clothing_id').html data.id
      $('#clothing_info #date').html data.date
      $('#clothing_info #desc').html data.desc
      $('#clothing_info #unit_price').html data.unit_price
      $("#clothing_info #img_id").attr( "title", "Photo by Kelly Clark" );
      $("#clothing_info #img_id").attr("src", "")

      img_url = DropboxClient.client.thumbnailUrl "/worldcup.jpeg", {size: 'l'}
      console.log ("#{img_url}")
      $("#clothing_info #img_id").attr("src", img_url)

$ ->
  console.log 'change data format'
  $.extend jQuery.mobile.datebox.prototype.options, {
    'overrideDateFormat': '%Y-%m-%d',
    'overrideHeaderFormat': '%Y-%m-%d'
  }

  $("#main_clothing").click ->
    $.mobile.changePage "#clothing_main_dialog"

  $("#clothing_main_dialog #amend_btn").click ->
    Clothing.ACTION = 'PUT'
    $.mobile.changePage "#clothing_id_dialog"

  $("#clothing_main_dialog #query_btn").click ->
    Clothing.ACTION = 'GET'
    $.mobile.changePage "#clothing_id_dialog"

  $("#clothing_main_dialog #new_btn").click ->
    Clothing.ACTION = 'POST'
    Clothing.reset()
    current_date = new Date()
    $("#clothing #date").val "#{current_date.getFullYear()}-#{current_date.getMonth()+1}-#{current_date.getDate()}"
    $.mobile.changePage "#clothing"

  $("#clothing #submit_btn").click ->
    console.log "clothing: submit_btn"
    id = $('#clothing #clothing_id').val()
    if id is ""
      Clothing.post()
    else
      Clothing.put(id)

  $("#clothing_id_dialog #ok_btn").click ->
    id = $("#clothing_id_dialog #clothing_id").val()
    console.log "id #{id}"
    if id
      ret = Clothing.get id
    else
      alert "Missing id"

  $("#clothing_id_dialog").on "pagebeforeshow", ->
    console.log "clothing_id_dialog pagebeforeshow"
    $("#clothing_id_dialog #clothing_id").val ""