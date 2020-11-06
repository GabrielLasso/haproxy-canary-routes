# HA Proxy example

## Backends
The backend is a simple web server written in Nim, you can compile and run them through docker by running `cd backend && ./runServers.sh`.

They can be accessed via ports 1111, 2222, 3333 or 4444.

They contain routes `/`, `/app1` and `/app2` and the response tell you from which port you are acessing.

## HA Proxy
The configuration files are located in `haproxy/` folder, so to run the haproxy, run `cd haproxy && haproxy -f .`.

There are 2 HTTP backends that can be accessed via port 8080:
- The first, called canary, which receive requests whose path begins with one of the lines of the file `haproxy/canary.acl` (by default is just `/app1`)
- The second is the main, and receive all other requests.

And there is an extra TCP backend that can be accessed via port 9000. This are used to communicate with the haproxy process using the [runtime API](https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/).

## Changing the canary apps
If you want to change the canary apps without changind the file `haproxy/canary.acl` and restarting the process, you can use the runtime API.

To add `/app2` to canary, create a TCP connection to `localhost:9000` and run `add acl #1 /app2`, or use socat to that:
```bash
echo "add acl #0 /app2" | socat stdio tcp4-connect:localhost:9000
```

To remove `/app1` from canary, you can similarlly run:
```bash
echo "del acl #0 /app1" | socat stdio tcp4-connect:localhost:9000
```

## Useful links
- https://www.haproxy.com/blog/the-four-essential-sections-of-an-haproxy-configuration/
- https://www.haproxy.com/blog/introduction-to-haproxy-acls/
- https://www.haproxy.com/blog/dynamic-configuration-haproxy-runtime-api/

