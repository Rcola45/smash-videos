# Deals with search bar functionality
$(document).ready ->
  # Used when searching the characters#index page
  characterSearchCallback = (searchValue) ->
    $.post(
      url: '/characters',
      data: { search: searchValue }
    )

  runCallbackFunction = (localThis) ->
    callbackDataAttr = 'callbackFunc'
    # Runs the function whose name is defined in data(callbackAttrData) on the search input
    eval("#{$(localThis).data(callbackDataAttr)}('#{localThis.value}')")

  $(document).on 'submit', '.search-bar input', ->
    if $(this).data('searchType') == 'onSubmit'
      runCallbackFunction(this)

  $(document).on 'keyup', '.search-bar input', ->
    if $(this).data('searchType') == 'live'
      runCallbackFunction(this)
