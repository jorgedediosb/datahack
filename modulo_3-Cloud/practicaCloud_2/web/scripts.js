//var API_ENDPOINT;
var API_ENDPOINT = "https://${ApiGatewayRestApi}.execute-api.${AWS::Region}.amazonaws.com/${self:provider.stage}"

fetch('/api-url')
  .then(response => response.json())
  .then(data => {
    API_ENDPOINT = data.apiUrl;

  })
  .catch(error => {
    console.error('Error al obtener la URL de la API:', error);
  });

function saveMessage() {
  var inputData = {
    "user": $('#user').val(),
    "message": $('#msg').val()
  };

  $.ajax({
    url: API_ENDPOINT + "/insert-message",
    type: 'POST',
    data: JSON.stringify(inputData),
    contentType: 'application/json; charset=utf-8',
    success: function (response) {
      document.getElementById("messageSaved").innerHTML = "Mensaje enviado!";
      $('#user').val('');
      $('#msg').val('');
    },
    error: function () {
      alert("Error al enviar el mensaje!");
    }
  });
}

function getMessages() {
  fetch(API_ENDPOINT + "/get-messages")
    .then(response => response.json())
    .then(data => {
      var messagesHTML = "<h2>Mensajes:</h2><ul>";
      data.forEach(message => {
        messagesHTML += "<li><strong>Usuario:</strong> " + message.user + "<br><strong>Mensaje:</strong> " + message.message + "</li>";
      });
      messagesHTML += "</ul>";
      document.getElementById("showMessages").innerHTML = messagesHTML;
    })
    .catch(error => {
      console.error('Error al obtener los mensajes:', error);
    });
}
