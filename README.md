# nebula-netns
Slack [Nebula](https://github.com/slackhq/nebula) is a cool overlay networking
tool. However, it was originally not meant as container networking tool;
while running Nebula within containers is possible, this interacts very
poorly with Docker/Podman bridge/NAT networks.

But what if you could run Nebula on host, while still providing networking to
containers? `nebula-netns` aims to do just that by temporarily entering Linux
network namespaces to create TUN devices inside them.

## Installation
Both `nebula-netns` and the supplementary `container-nebula.sh` are available
at Github releases. Just copy them wherever you want to and add executable bits,
and you're good to go!

Alternatively, you can also build it locally:
```sh
go build
```

## Usage
For most part, `nebula-netns` works exactly like Nebula. Consult the
[official documentation](https://nebula.defined.net/docs/) first, if you're
not yet familiar with it.

The only additional parameter is `-netns <path>`. When given, the TUN device and route
table changes are performed in the target namespace. For example, to start Nebula:

```sh
nebula-netns -config /path/to/config.yml -netns /path/to/netns
```

If you happen to be working with Podman, the script `container-nebula.sh` can
automatically fetch a container's netns path and launch Nebula into it. Example:

```sh
export NEBULA_NETNS_BINARY="/path/to/nebula-netns"
container-nebula.sh container-name
```

## License
MIT. Parts of the code have been adapted from upstream Nebula, rest of which
are pulled as Go mod dependency.