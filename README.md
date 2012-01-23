# Environment for Mac OS X Terminal.app

## Requirements

- Mac OS X 10.6 (Snow Leopard)
- MacPorts 1.8+
- Visor or TerminalColours

## Installation of required MacPorts packages

To get this done is pretty simple, once you have MacPorts set up correctly
(if you can type man port and get a manual page you’re ready), just run
the following command:

sudo port -vu install coreutils +with_default_names

After that make sure you've got git installed. If you need to install it,
run:

sudo port -vu install git-core
