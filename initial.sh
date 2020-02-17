#!/bin/bash

npm install
npm uninstall  angular-cli @angular/cli
npm cache clean --force
npm install @angular/cli@8.3.24
npm install --save-dev @angular/cli@8.3.24
npm i --save-dev karma-phantomjs-launcher

