jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip(placement: "bottom")
  $('.carousel').carousel()
  $('#subnav').scrollspy()
  $(".chzn-select").chosen()
  $('#myModal1').modal()
  $('.nav-tabs').button()
  $('#myModal2').modal()
  $('#myModal3').modal()
  $('.dropdown-toggle').dropdown()
  $("#myTab a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('#myTab a:first').tab('show')
  $("#myTab2 a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('#myTab2 a:first').tab('show')
  $("#myTab3 a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('#myTab3 a:first').tab('show')
  $("#myTab4 a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('#myTab4 a:first').tab('show')
  $("#myTab5 a").click (e) ->
    e.preventDefault()
    $(this).tab "show"
  $('#myTab5 a:first').tab('show')
  $('.jpicker').jPicker()