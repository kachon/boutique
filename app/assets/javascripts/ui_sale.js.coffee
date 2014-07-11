class window.Sale
  @ACTION = 'POST'

  @url: ->
    "/sales/"

  # @form_data: ->
  #   console.log "sale form_data"
  #   data = {}
  #   data.date = $('#clothing #date').val()
  #   data.desc = $('#clothing #desc').val()
  #   data.unit_price = $('#clothing #unit_price').val()
  #   #parseFloat($('#clothing #unit_price').val())
  #   return { clothing: data }

  # @post: =>
  #   post_url = "#{@url()}"
  #   data = JSON.stringify @form_data()
  #   #data = @form_data()
  #   console.log "post_url #{post_url} #{data}"
  #   # request = $.post post_url, data, (result) =>
  #   #   info = result
  #   #   alert "Repair Id: #{info.id}"
  #   #   $.mobile.changePage "#main"
  #   request = $.ajax 
  #     url: post_url, 
  #     type: 'POST',
  #     data: data,
  #     contentType: 'application/json'
  #     success: (result) =>
  #       info = result
  #       alert "Clothing Id: #{info.id}"
  #       $.mobile.changePage "#main"

  #   request.fail (jqXHR, textStatus) =>
  #     alert JSON.parse(jqXHR.responseText).msg

  @reset: ->
    $('#sale #update_div').hide()
    $('#sale #sale_id').val ""
    $('#sale #date').val ""
    $('#sale #payment').val ""
    $('#sale #remark').val ""

  @get: (input) =>
    $('#sale #update_div').show()
    $('#sale .input').hide()
    console.log "get_sale: #{input}"
    get_url = "#{@url()}#{input}/"

    request = $.get get_url, (result) => 
      # data = JSON.parse result
      console.log "data #{JSON.stringify result, null, 2}"
      @display_data result

    request.fail (jqXHR, textStatus) =>
      alert jqXHR.responseText
      $.mobile.changePage "#main"

  # @put: (input) =>
  #   put_url = "#{@url()}#{input}/"
  #   data = JSON.stringify @form_data()
  #   console.log "put_url #{put_url} #{data}"
  #   request = $.ajax(
  #     type: "PUT"
  #     url: put_url
  #     data: data
  #     contentType: 'application/json'
  #   )
  #   request.done (result) =>
  #     info = result
  #     alert "Clothing Id: #{info.id}"
  #     $.mobile.changePage "#main"
  #   request.fail (jqXHR, textStatus) =>
  #     alert jqXHR.responseText

  @display_data: (data) =>
    if @ACTION == 'PUT'
      $('#sale #sale_id').val data.id
      $('#sale #date').val data.date
      $('#sale #payment').val data.payment
      $('#sale #remark').val data.remark
      $.mobile.changePage "#sale"
    else if @ACTION == 'GET'
      $.mobile.changePage "#sale_info"
      $("#sale_info .item").remove()
      $('#sale_info #sale_id').html data.id
      $('#sale_info #date').html data.date
      $('#sale_info #payment').html data.payment
      $('#sale_info #remark').html data.remark

      for item in data.items
        input = $("<li data-icon='false'></li>").html \
          """
            <a href=\"#\">
              <h5>Clothing Id: #{item.clothing}</h5>
              <p class=\"topic\"><strong>Desc: #{item.clothing_desc}</strong></p>
              <p class=\"topic\"><strong>Unit Price: #{item.unit_price}</strong></p>
            </a>
          """
        input.addClass "item"
        $("#sale_info #items").append input

      $("#sale_info .collapsible").trigger "collapse"
      $("#sale_info #items").listview "refresh"


$ ->
  console.log 'change data format'
  $.extend jQuery.mobile.datebox.prototype.options, {
    'overrideDateFormat': '%Y-%m-%d',
    'overrideHeaderFormat': '%Y-%m-%d'
  }

  $("#main_sale").click ->
    $.mobile.changePage "#sale_main_dialog"

  $("#sale_main_dialog #amend_btn").click ->
    Sale.ACTION = 'PUT'
    $.mobile.changePage "#sale_id_dialog"

  $("#sale_main_dialog #query_btn").click ->
    Sale.ACTION = 'GET'
    $.mobile.changePage "#sale_id_dialog"

  $("#sale_main_dialog #new_btn").click ->
    Sale.ACTION = 'POST'
    Sale.reset()
    current_date = new Date()
    $("#sale #date").val "#{current_date.getFullYear()}-#{current_date.getMonth()+1}-#{current_date.getDate()}"
    $.mobile.changePage "#sale"

  $("#sale #submit_btn").click ->
    console.log "sale: submit_btn"
    id = $('#sale #sale_id').val()
    if id is ""
      Sale.post()
    else
      Sale.put(id)

  $("#sale_id_dialog #ok_btn").click ->
    id = $("#sale_id_dialog #sale_id").val()
    console.log "id #{id}"
    if id
      ret = Sale.get id
    else
      alert "Missing id"