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
    return res.text()
  }).then(function(res) {
    if (!resOk) {
      throw new Error(`Failed to process contact request: HTTP ${resStatus} - ${res}`)
    }
    $("#contact-modal").modal('toggle')
    triggerStatusModal("Request submitted", "For anything else please contact Andrew directly at ")
  }).catch(function(error) {
    $("#contact-modal").modal('toggle')
    triggerStatusModal("Something went wrong :(", "Please contact Andrew directly at ")
    console.error(error)
  })
}
function triggerStatusModal(label, text) {
  $('#status-modal-label').text(label)
  $('#status-modal-text').text(text)
  $('#status-modal').modal('toggle')
}