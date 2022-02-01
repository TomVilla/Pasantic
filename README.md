# Pasantic.- Es un app que permite a estudiantes universitarios la búsqueda y postulación a pasantías, para aplicar sus conocimientos en problemas reales de un empresa.
Documentación API\
Servicio 1\
Listar todas las pasantías disponibles.\
Ruta\
localhost:3000/practices/all\
Funcionamiento\
Lista en el frontend todas las pasantías disponibles, no recibe ningún parámetro y retorna un JSON con las pasantías que están en la base de datos.\
Servicio 2\
Listar todas las pasantías disponibles por su ID.\
Ruta\
localhost:3000/practices/findone/:id\
Funcionamiento\
Usada en la clase de favoritos del frontend para pedir información, se recibe un id, y retorna json con toda la información.\
Servicio 3\
Listar pasantías por palabra clave\
Ruta\
localhost:3000/practices/keyword/:keyword\
Funcionamiento\
Lista todas las pasantías por la palabra clave, recibe como parámetro una palabra clave desde el frontend y retorna un json con la información de las pasantías.\
Servicio 4\
Listar toda la información del perfil\
Ruta\
localhost:3000/profile\
Funcionamiento\
El frontend requiere información de los estudiantes. para eso pide a la base de datos en el backend con el query adecuado y así devuelve un json con la información.\
Servicio 5\
Lista todas las pasantías favoritas de los estudiantes.\
Ruta\
localhost:3000/practices/fav/all\
Funcionamiento\
Desde el frontend requiere las pasantías favoritas del estudiante, por eso desde el backend con el inicio de sesión adecuado ya pide con el query la información desde la base de datos.\

Servicio 6\
Lista información de las pasantías favoritas del estudiante.\
Ruta\
localhost:3000/practices/fav/ver/:id\
Funcionamiento\
Para presentar la información de las pasantías que están en favoritos pide en el backend la información de las pasantías enviando como parámetro el id y retorna un json.\
Servicio 7\
Agregar una pasantía a favoritos\
Ruta\
localhost:3000/practices/fav/add/:id\
Funcionamiento\
Agrega una pasantía a la tabla favoritos para eso se envía desde el front la id de la pasantía seleccionada, y retorna un json indicando que la información se guardó en la base de datos.\
Servicio 8\
Borrar una pasantía de favoritos\
Ruta\
localhost:3000/practices/fav/delete/:id\
Funcionamiento\
Se borra una pasantía de la base de datos, para eso se recibe la id de la pasantía seleccionada desde el frontend. y retorna un json con la pasantía eliminada.\
Servicio 9\
Listar las pasantías postuladas por el estudiante.\
Ruta\
localhost:3000/practices/post/all\
Funcionamiento\
Se lista todas las pasantías que postuló el estudiante en el frontend, para eso se pide desde el backend la información de todas las pasantías, y retorna un json de la selección en la base de datos.\
Servicio 10\
Listar información pasantías por el id\
Ruta\
localhost:3000/practices/post/ver/:id\
Funcionamiento\
Para detallar la información de cada pasantía se envía como parámetro el id, y retorna un json.\
Servicio 11\
Postular pasantías\
Ruta\
localhost:3000/practices/post/add/:id\
Funcionamiento \
Al momento de postular a las pasantías mostradas en el frontend, se le envía al backend la imagen de la id de la pasantía seleccionada. Y retorna un json afirmando que se guardó en la base de datos.\
Servicio 12\
Eliminar una postulación\
Ruta\
localhost:3000/practices/post/delete/:id\
Funcionamiento\
Para eliminar la pasantía se le envía backend la id de la postulación, y se procede a ejecutar el query. Retorna un json con la postulación eliminada.\
Servicio 13\
Registrarse\
Ruta\
localhost:3000/signup\
Funcionamiento\
Recibe los datos del formulario del backend y procede a hacer la ejecución de passport.js para guardar la información en la base de datos. Y retorna un json siendo true or false.\
Servicio 14\
Iniciar sesión\
Ruta\
localhost:3000/signin\
Funcionamiento\
Recoge los datos del formulario del backend y valida con passport.js si existe el usuario o no en la base de datos. Y retorno un json siendo true or false según el contexto.\


