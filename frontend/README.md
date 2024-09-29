# Frontend

Jest to nieminifikowany kot cześci frontendowej aplikacji, napisany w Reactcie. Powinien być on po zbudowaniu hostowany na S3.

## Wymagania
* nodejs 14
* npm 6

## Ścieżka do API

URL API znajduje się w pliku App.js. Należy tą ścieżkę zastąpić ścieżką swojego stage w API Gateway.

## Pobranie zależności

Aby zbudować kod, najpierw trzeba pobrać niezbędne zależności. Aby to zrobic, należy uruchomić komendę `npm install`.

## Budowanie kodu

Aby wybudować aplikację, należy uruchomić komendę `npm run build`. Następnie stworzone pliki z katalogu `build` można umieścić w wiaderku S3.
