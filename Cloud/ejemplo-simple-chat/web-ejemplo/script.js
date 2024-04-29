document.addEventListener('DOMContentLoaded', function() {
    var messages = document.getElementById('messages');
    var sendButton = document.getElementById('sendButton');

    sendButton.addEventListener('click', function() {
        var userId = document.getElementById('user_id').value;
        var message = document.getElementById('message').value;

        // Crea un nuevo elemento de mensaje y lo añade a la lista de mensajes
        var messageElement = document.createElement('div');
        messageElement.textContent = userId + ': ' + message;
        messages.appendChild(messageElement);

        // Limpia los campos de entrada
        document.getElementById('user_id').value = '';
        document.getElementById('message').value = '';
    });
});
