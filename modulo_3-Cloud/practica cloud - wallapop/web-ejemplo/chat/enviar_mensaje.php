<?php
// Verificar si se ha enviado el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recuperar el mensaje del formulario
    $mensaje = $_POST["mensaje"];

    // Aquí podrías agregar código adicional para validar y procesar el mensaje, como enviar un correo electrónico al anunciante, guardar el mensaje en una base de datos, etc.

    // Ejemplo: enviar un correo electrónico al anunciante
    $destinatario = "correo@anunciante.com";
    $asunto = "Nuevo mensaje de Wallapop";
    $cuerpoMensaje = "Has recibido un nuevo mensaje:\n\n$mensaje";
    $cabeceras = "From: tu_correo@tu_dominio.com";

    // Enviar el correo electrónico
    if (mail($destinatario, $asunto, $cuerpoMensaje, $cabeceras)) {
        echo "Mensaje enviado con éxito. ¡Gracias por contactar al anunciante!";
    } else {
        echo "Error al enviar el mensaje. Por favor, inténtalo de nuevo más tarde.";
    }
} else {
    // Si se intenta acceder directamente al archivo PHP sin enviar el formulario, redirigir a la página de inicio
    header("Location: index.html");
    exit;
}
?>
