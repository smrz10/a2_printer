Implementación del method_missing
==========

Si, el descubrimiento de "method_missing", me ha llevado a ver una técnica que "realiza" magia, no me ha gustado que se realizan llamadas a código que "no" existe. Creo que mi solución, lo ha llevado al extremo, con la intención de separar el código "real" de las llamadas al resto de clases, obligadas a realizarse así para no variar el código existente.

He llevado todos los colaboradores a un nuevo objeto, Collaborators. Él, se encargará crear, instanciar, los colaboradores, a2_printer ya no instancia ninguno de ellos, y de buscar, como si fuese un proxy, cada llamada a función realizada sobre a2_printer, y que no sea una función propia de a2_printer, entre los diferentes colaboradores instanciados. 

Mi intención era, que solo fuese necesario, para crear un nuevo colaborador, definirlo en el constructor del nuevo objeto, pero no he conseguido que la función obtain_collaborators, obtenga las variable de instancia a través de "instance_variables" ( el comentario del código queda ahí para hacer constar que no debe dejarse así ), obligándome a crear el array de forma manual.

Del nuevo objeto Collaborators, hereda a2_printer, para usar la implementación de la función method_missing en el momento que el sistema comience a buscar la función llamada en la cadena de objetos.

Uno de los objetivos de mi solución, era conseguir que ninguno de los colaboradores fuese consciente, que fuese independiente, de esta implementación. También deseaba que el impacto en a2_printer fuera el mínimo. En a2_printer, el código necesario para realizar la implementación, se limita a 2 líneas, la declaración de herencia sobre el padre Collaborators y la llamada al constructor del "padre", desde el propio constructor de a2_printer.

Problemas
------ 

Además de la perdida de claridad ya comentada, esta implementación, en general, creo que el method_missing, es muy crítica con los nombres, si existe el mismo método en más de un colaborador, no sabes a cual se llamará, o lo sabes pero llamará al incorrecto. Este problema me hizo llevar los métodos reset, de los colaboradores, a un nivel de visualización privado, creando un método más explícito en sus interfaces públicos. 

Otro problema que he visto, ya más de mi solución, es que, al trasladar los colaboradores fuera de a2_printer, hay por lo menos dos llamadas desde a2_printer que se ven delegadas a través de method_missing, en vez de una llamada directa al objeto. Queda sucio de esa manera, creo que puede ser una mala práctica, que extiende el uso del method_missing más allá de lo que se debería.



Es evidente que este recurso, con la pega de la eliminación de claridad al código, ayuda mucho a la hora de hacer refactors a nuevos objetos sin tocar el código existente.







A2 Printer
==========

A small library for working with cheap thermal "A2" printers, such as those available from Adafruit and Sparkfun.

Simple example
------

    serial_connection = SerialConnection.new("/dev/serial")
    printer = A2Printer.new(serial_connection)

    printer.begin
    printer.println("Hello world!")
    printer.feed
    printer.bold_on
    printer.println("BOOM!")
    printer.bold_off


Writing to a file
--------

This can be useful if you're going to use some other mechanism to send the bytes to the printer

    commands_file = File.open("serial_commands.data", "w")
    printer = A2Printer.new(commands_file)
    printer.begin
    printer.println("Hello world!")

    # etc ...

    commands_file.close
