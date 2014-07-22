class window.Sale
  @ACTION = 'POST'

  @items = []

  @url: ->
    "/sales/"

  @form_data: ->
    console.log "Sale form_data"
    data = {}
    data.date = $('#sale #date').val()
    data.remark = $('#sale #remark').val()
    data.payment = $('#sale #payment').val()
    data.items = @items
    return { sale: data }

  @post: =>
    post_url = "#{@url()}"
    data = JSON.stringify @form_data()
    #data = @form_data()
    console.log "post_url #{post_url} #{data}"
    request = $.ajax 
      url: post_url, 
      type: 'POST',
      data: data,
      contentType: 'application/json'
      success: (result) =>
        info = result
        alert "Sale Id: #{info.id}"
        $.mobile.changePage "#main"

    request.fail (jqXHR, textStatus) =>
      alert JSON.parse(jqXHR.responseText).msg

  @reset: ->
    $('#sale #update_div').hide()
    $('#sale #sale_id').val ""
    $('#sale #date').val ""
    $('#sale #payment').val ""
    $('#sale #remark').val ""
    @reset_items()
    @refresh_items()

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
      alert "Sale Id: #{info.id}"
      $.mobile.changePage "#main"
    request.fail (jqXHR, textStatus) =>
      alert jqXHR.responseText

  @display_data: (data) =>
    if @ACTION == 'PUT'
      $('#sale #sale_id').val data.id
      $('#sale #date').val data.date
      $('#sale #payment').val data.payment
      $('#sale #remark').val data.remark
      $.mobile.changePage "#sale"
      for item in data.items
        @add_item 
          clothing: item.clothing,
          unit_price: item.unit_price
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
      @display_total_for_info(data.items)

  @display_total: =>
    total = @calc_total(@items)
    $("#sale #total").html "Total: $#{total}"

  @display_total_for_info: (items) =>
    total = @calc_total(items)
    $("#sale_info #total").html "$#{total}"

  @calc_total: (items) =>
    total = 0
    for item in items
      total += parseFloat(item.unit_price)
    return total

  @add_item: (item) =>
    @items.push item
    console.log "after add_item #{JSON.stringify @items, null, 2}"
    @display_item @items.length - 1
    @display_total()

  @delete_item: (index) ->
    console.log "delete_item: " + @items.length
    @items.splice index, 1
    console.log "after delete_item #{JSON.stringify @items, null, 2}"
    @refresh_items()
    
  @reset_items: ->
    @items.length = 0

  @display_item: (index) ->
    console.log "display_item: #{index}"
    item = @items[index]
    console.log "display_item: #{JSON.stringify item, null, 2}" 
    console.log "length: " + $("#sale #items li").length
    clothing = "Clothing ID: " + item.clothing
    unit_price = "Unit Price: $" + item.unit_price
    img_url = DropboxClient.client.thumbnailUrl item.img_link, {size: 'l'}
    console.log "#{img_url}"
    input = $("<li></li>").html(
      "<a href=\"#\">
       <img src=\"#{img_url}\">
       <h5> #{clothing} </h5> 
       <p class=\"topic\"><strong> #{unit_price} </strong></p> 
       <a href=\"#\" class=\"delete\" data-icon=\"delete\">Delete</a>")
    input.addClass "cls_item"
    $("#sale #items").append input
    $("#sale #items").listview "refresh"
    console.log "Sales.prototype.display_item: done"

  @refresh_items: ->
    $("#sale .cls_item").remove()
    i = 0

    while i < @items.length
      @display_item i
      ++i

    @display_total()
    return

$ ->
  console.log 'init ui_sales'
  $.extend jQuery.mobile.datebox.prototype.options, {
    'overrideDateFormat': '%Y-%m-%d',
    'overrideHeaderFormat': '%Y-%m-%d'
  }

  $("#main_sale").click ->
    $.mobile.changePage "#sale_main_dialog"

  $("#sale_main_dialog #amend_btn").click ->
    Sale.ACTION = 'PUT'
    Sale.reset()
    $.mobile.changePage "#sale_id_dialog"

  $("#sale_main_dialog #query_btn").click ->
    Sale.ACTION = 'GET'
    Sale.reset()
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

  $("#sale #add_btn").click ->
    console.log "sale: add_btn"
    $.mobile.changePage "#sale_dialog"
    $("#sale_dialog #clothing_id").val ""
    $("#sale_dialog #unit_cost").val "0.0"

  $("#sale_id_dialog #ok_btn").click ->
    id = $("#sale_id_dialog #sale_id").val()
    console.log "id #{id}"
    if id
      ret = Sale.get id
    else
      alert "Missing id"

  $("#sale_dialog #ok_btn").click ->
    valid = $("#sale_dialog #input_form")[0].checkValidity()
    console.log "sale_dialog: ok_btn click " + valid
    if valid
      clothing = $("#sale_dialog #clothing_id").val()
      unit_price = $("#sale_dialog #unit_cost").val()
      Clothing.get_cb clothing, (result) =>
        console.log "Clothing.get_cb #{JSON.stringify result, null, 2}"
        Sale.add_item 
          clothing: clothing,
          unit_price: unit_price
          img_link: result.img_link
        $(".ui-dialog").dialog "close"
        console.log "sale ok close dialog"


  $("#sale").on "click", ".delete", ->
    console.log "delete position: " + $(this).parent().index()
    Sale.delete_item $(this).parent().index()

  $("#sale_id_dialog").on "pagebeforeshow", ->
    console.log "sale_id_dialog pagebeforeshow"
    $("#sale_id_dialog #sale_id").val ""
