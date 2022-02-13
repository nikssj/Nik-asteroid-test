
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://nikssj.dev">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Prueba técnica para Asteroid Techs.</h3>

  <p align="center">
    ABM de incidentes hecho en Flutter v2.0.5
    <br /> <br />
    <a href="https://drive.google.com/file/d/1bECkczM8-IVokGYCaInzmt9HNcCDc8hj/view?usp=sharing">Descargar APK para Android</a>
    <br />
    <a href="https://drive.google.com/file/d/1agSN5i1AZ-JPXQ5i420YoXjYWwSidvih/view?usp=sharing">Descargar GoogleServices.json</a>
    <br />
     <br />
      <br />
  <b>Datos de prueba </b>
      <br />
      <b>User:</b> asteroid@tech.com
       <br />
       <b>Password:</b> 123456
        <br />
  </p>
</p>



<!-- ABOUT THE PROJECT -->
## Acerca del proyecto


Prueba técnica para Asteroid Technologies. El proyecto consiste en un ABM (Alta, Baja, Modificación) de incidentes. Posee un sistema de autenticación y base de datos, ambos alojados en Firebase. Además, permite acceder a funciones nativas como cargar fotos desde la galería y cámara.  


### Puntos importantes a considerar:
* Diseños responsive a distintos tamaños de dispositivos (Only mobile en orientación vertical)
* Patrón de arquitectura MVC aplicando Provider como State Management
* [BETA: Asteroid in the web!](https://nik-asteroid-test.web.app) A modo demostrativo, se deployó una versión PWA del proyecto <b>para ser ejecutada en celulares</b> (Faltan retoques, por ej:<b> No se puede subir fotos vía web</b>)


## Acerca del desarrollo

El proyecto se desarrolló con la última versión Stable disponible de Flutter.

* [Flutter v2.0.5](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_2.0.5-stable.zip)


<!-- ACKNOWLEDGEMENTS -->
### Paquetes interesantes utilizados en el proyecto
* [Provider](https://pub.dev/packages/provider)
* [Animate do](https://pub.dev/packages/animate_do)
* [Firebase core](https://pub.dev/packages/firebase_core)
* [Firebase auth](https://pub.dev/packages/firebase_auth)
* [Get](https://pub.dev/packages/get)



<!-- GETTING STARTED -->

## Pre-requisitos

Descargar la versión v2.0.5 Stable de Flutter

* [Flutter v2.0.5](https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_2.0.5-stable.zip)

Seguir las instrucciones de instalación en su página oficial

* [Instrucciones de instalación](https://flutter.dev/docs/get-started/install)


### Ejecución del proyecto


1. Clonar el repositorio
   ```sh
   git clone https://github.com/nikssj/nik-asteroid-test
   ```
2. Ejecutar el comando flutter pub get para descargar las dependencias del proyecto
   ```sh
   flutter pub get
   ```
3. Ejecutar el proyecto. En caso de usar VSCODE, se puede ejecutar presionando F5, conectando previamente un dispositivo Android con modo USB Debugger activado.



<!-- Screenshots -->
## Screenshots


### Login
[![Login Gif][gif-login]](https://nikssj.dev)

### Creación de incidente
[![Creacion Gif][gif-creacion]](https://nikssj.dev)

### Búsqueda y borrado de incidente
[![Borrado Gif][gif-borrado]](https://nikssj.dev)

### BETA: [Asteroid in the web!](https://nik-asteroid-test.web.app)
[![Web Gif][gif-web]](https://nik-asteroid-test.web.app)


<!-- CONTACT -->
## Contacto

Nicolás Aybar - [Portfolio](https://nikssj.dev) - naybar.dev@gmail.com



<!-- MARKDOWN LINKS & IMAGES -->
[linkedin-url]: https://linkedin.com/in/nikssj
[gif-login]: images/gif/login_gif.gif
[gif-creacion]: images/gif/creacion_gif.gif
[gif-borrado]: images/gif/borrado_gif.gif
[gif-web]: images/gif/web_gif.gif

