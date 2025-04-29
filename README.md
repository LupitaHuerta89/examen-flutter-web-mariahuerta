<h1>📚 Examen Desarrollador - Flutter Web + Node.js</h1>
✨ Descripción
Este proyecto es una aplicación web desarrollada en Flutter Web con un backend simulado en Node.js.
El objetivo es gestionar usuarios, colaboradores, empleados, archivos y servicios de publicaciones, cumpliendo con todos los requerimientos del examen práctico.

La app incluye login, registro, gestión de colaboradores, carga de archivos, consumo de un servicio externo, y recuperación de contraseña.

<h3>🚀 Funcionalidades Principales</h3>
Autenticación: Registro e inicio de sesión de usuarios con validaciones.

Recuperación de contraseña: Cambio de contraseña por RFC y correo.

Carga de archivos: Permite subir archivos y mostrarlos en una tabla.

Gestión de Colaboradores: Registrar, editar y eliminar colaboradores.

Empleados: Buscar empleados por nombre, RFC o CURP.

Servicios de publicaciones: Consultar, crear, editar y eliminar publicaciones usando API externa (JSONPlaceholder).

Navegación intuitiva: Menú lateral disponible en todas las vistas.

Interfaz responsiva: Estilos modernos y adaptables a dispositivos.

<h3>🛠️ Tecnologías Utilizadas </h3>
Frontend: Flutter Web

Backend: Node.js 20.x

Framework adicional: HTTP para consumo de servicios web

Diseño: Material Design (propio de Flutter)


<h3>⚙️ Instalación y Configuración</h3>
Clonar el repositorio:

bash
Copiar
git clone https://github.com/tu-usuario/examen-flutter-web.git
cd examen-flutter-web
Instalar Flutter:

Descarga Flutter desde: https://docs.flutter.dev/get-started/install

Asegúrate de tener Flutter Web habilitado:

bash
Copiar
flutter devices
Instalar dependencias:

bash
Copiar
flutter pub get
Levantar el backend simulado (opcional):

Ir a la carpeta de backend (Node.js) si se requiere para el registro de usuarios.

Instalar dependencias:

bash
Copiar
npm install
Ejecutar:

bash
Copiar
npm start
Correr Flutter Web:

bash
Copiar
flutter run -d chrome

<h3>📋 Estructura del Proyecto</h3>
bash
Copiar
/lib
  /models           → Modelos de datos (User, Collaborator, Repositorios)
  /screens          → Pantallas principales (Login, Registro, Home, Empleados, Colaboradores, Publicaciones)
  /widgets          → Widgets reutilizables (Menú lateral)
main.dart           → Configuración principal de rutas y tema

<h3>🎯 Requisitos Especiales Cubiertos</h3>
Validaciones estrictas en formularios.

RFC validado por estructura y longitud.

Prevención de duplicidad de correo y RFC.

Manejo correcto de estado para colaboradores.

Integración de servicios externos (jsonplaceholder.typicode.com).

Actualización de contraseña mediante RFC + correo.

<h3>📢 Notas Importantes</h3>
La persistencia de datos en servicios como JSONPlaceholder es temporal y no se almacena realmente en un servidor.

La aplicación está desarrollada y optimizada para ejecutarse en navegador (Chrome preferentemente).

<h3>👩‍💻 Autor</h3>
Tu nombre: María Guadalupe Huerta Reséndiz

Correo: guadalupehr.itic19@gmail.com
