$ ->
  modal_holder_selector = "#modal-holder"

  $(document).on "click", "[data-behavior='modal']", ->
    $('body').modalmanager('loading')
    location = $(this).attr("href")
    $.get location, (data)->
      $(modal_holder_selector).html(data).find(".modal").modal("show")
    false

  $(document).on "ajax:success", "[data-behavior='modal-form']", (event, data, status, xhr) ->
 
      # FUTURE TODO: make sure only the modal which was called last will be destroyed.
      $(".modal").modal("hide")
