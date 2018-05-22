$ ->
  modal_holder_selector = "#modal-holder"

  $(document).on "click", "[data-behavior='modal']", ->
    $('body').modalmanager('loading')
    location = $(this).attr("href")
    $.get location, (data)->
      $(modal_holder_selector).html(data).find(".modal").modal("show")
    false

  $(document).on "ajax:success", "[data-behavior='modal-form']", (event, data, status, xhr) ->
    # make sure this event is observered by document and not by dom node itself.
    url = xhr.getResponseHeader("Location")
    # Navigates to given location header in http response or closes the modal handler.
    if url
      window.location = url
    else
      # FUTURE TODO: make sure only the modal which was called last will be destroyed.
      $(".modal").modal("hide")
    false