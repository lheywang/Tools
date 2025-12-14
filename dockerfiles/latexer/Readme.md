# LaTeXer

This dockerfile build an latex rendering image, based on Texlive/2024-historic release.
It only add some nice tools and some prebuilt templates.

It bundle different tools :
- Texlive 2024
- Inkscape
- Ghostscript
- Evince

As mentionned, it includes some latex templates, hosted on git.
You may found a resume template, as well as other for ieee publications nor master thesis.
You can create a new project, based on any of theses by just copying them !

The command is quite easy :

> cp -r /tools/templates/[name of the template] .

This image is also baked with some utility scripts : To update the tlmgr packages as well as
the templates !

Just run 

> sh /tools/scripts/package-update.sh

> sh /tools/scripts/template-update.sh

And the config files (placed on the same location, are designated as [name]-db.txt) will be loaded.
Each config file contain one git link / one package name, and they will be cloned / pulled / installed / updated !

Theses steps are done when building the image, and can be runned at any time ! And, since they're on the path, you don't even need to be on the correct location, just type :

> template-update.sh

or

> package-update.sh

And, that's good ! Wait and the operations are done !

To install it, run 

> make setup

It'll build the docker and install it on your system. 
The image is approx. 6.7 GB in size.
Then, you can run 

> make run

To open the docker, or, if you add this line into your bashrc :

> alias latexer="sudo docker run -it --rm -v \"$PWD\":/project -w /project --net=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix latexer"

To make it available from anywhere.

In any cases, the command will set the docker into your actual folder, and thus can be used anywhere, as a standalone tool.
