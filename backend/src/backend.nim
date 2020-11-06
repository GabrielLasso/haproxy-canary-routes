import prologue
import os
import strutils

let
  port = parseInt(getEnv("port","8888"))
  settings = newSettings(
    port = Port(port)
  )

proc home(ctx: Context) {.async.} =
  resp "Hello from port " & $port

proc app1(ctx: Context) {.async.} =
  resp "app1 from port " & $port

proc app2(ctx: Context) {.async.} =
  resp "app2 from port " & $port

let app = newApp(settings = settings)
app.get("/", home)
app.get("/app1", app1)
app.get("/app2", app2)

echo "Running from port " & $port

app.run()
