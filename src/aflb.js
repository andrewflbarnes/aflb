function submitContact() {
  var formData = $("#contact-form").serializeArray();

  var jsonData = {}
  formData.forEach(function(entry) {
    jsonData[entry.name] = entry.value
  })

  var resOk = false
  var resStatus = 0
  fetch('{{API_URL}}/v1/contact', {
    method: 'POST',
    body: JSON.stringify(jsonData),
    headers: {
      'content-type': 'application/json'
    }
  }).then(function(res) {
    resOk = res.ok
    resStatus = res.status
    return res.json()
  }).then(function(res) {
    if (!resOk) {
      throw new Error(`Unable to submit contact (${resStatus}): ${JSON.stringify(res)}`)
    }
    $("#contact-modal").modal('toggle')
    console.log(res)
  }).catch(function(error) {
    // TODO
    // $('.error-text').text(error)
    // $('#error-modal').modal('toggle')
    console.error(error)
  })

}