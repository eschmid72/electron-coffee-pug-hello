electron = require 'electron'
app = electron.app
BrowserWindow = electron.BrowserWindow


pug = require('electron-pug') {pretty: false}

# supporting coffee-script within .pug files
coffee = require 'coffee-script'
filters = require('pug').filters
filters.coffee = (code) ->
  coffee.compile code

win = null

createWindow = () ->
  win = new BrowserWindow {width: 800, height: 600}
  win.loadURL "file://#{__dirname}/index.pug"
  win.webContents.openDevTools()
  win.on 'closed', () ->
    win = null

app.on 'ready', createWindow

app.on 'window-all-closed', () ->
  if process.platform != 'darwin'
    app.quit()

app.on 'activate', () ->
  if win == null
    createWindow()
