// Despliegue manual:
// var API_ENDPOINT = "https://3qceox1tef.execute-api.eu-west-1.amazonaws.com/dev/";

var API_ENDPOINT = "${ApiEndpoint}";

//AJAX POST REQUEST
document.getElementById("savemessage").onclick = function(){
  var currentDate = new Date();
  var formattedDate = currentDate.toLocaleString('es-ES', { month: 'long', day: 'numeric', year: 'numeric' });
  var inputData = {
    "user": $('#user').val(),
    "message": $('#msg').val(),
    "date": formattedDate
  };
  $.ajax({
    url: API_ENDPOINT,
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

//AJAX GET REQUEST 
document.getElementById("getmessages").onclick = function(){  
  $.ajax({
    url: API_ENDPOINT,
    type: 'GET',
    contentType: 'application/json; charset=utf-8',
    success: function (response) {
      $("#showMessages").empty();
      jQuery.each(response, function (i, data) {
        var messageCardHtml = '<div class="messageCard">' +
          '<div class="messageContent">' + data["msg"] + '</div>' +
          '<div class="messageDetail">From: ' + data["user"] + ' ' + ' el ' + data["date"] + '</div>' +
          '</div>';
        $("#showMessages").append(messageCardHtml);
      });
    },
    error: function () {
      alert("error");
    }
  });
}
