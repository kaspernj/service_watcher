$ ->
  $("select#locale").change ->
    form = $(this).parent("form").first()
    form.submit()
