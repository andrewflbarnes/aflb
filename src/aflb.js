document.addEventListener("DOMContentLoaded", function(event) {
  document.getElementById("theme-switch").onclick = () => {
    const themeEl = document.getElementById("theme");
    const theme = themeEl.className.toLowerCase();
    themeEl.className = theme === "dark" ? "" : "dark";
  }
})

function submitContact() {
  let formInputs = document.getElementById('contact-form').getElementsByTagName('textarea');
  let formInputsCount = formInputs.length

  const jsonData = {}
  
  for (let i = 0; i < formInputsCount; i++) {
    const name = formInputs[i].attributes.name.value
    const value = formInputs[i].value
    console.log(`${i}: ${name}=${value}`)
    jsonData[name] = value;
  }
  console.log(jsonData)

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
    // $("#contact-modal").modal('toggle')
    // triggerStatusModal("Request submitted", "For anything else please contact Andrew directly at ")
  }).catch(function(error) {
    // $("#contact-modal").modal('toggle')
    triggerStatusModal("Something went wrong :(", "Please contact Andrew directly at ")
    console.error(error)
  })
}
function triggerStatusModal(label, text) {
  // $('#status-modal-label').text(label)
  // $('#status-modal-text').text(text)
  // $('#status-modal').modal('toggle')
  console.log(`${label}: ${text}`)
}