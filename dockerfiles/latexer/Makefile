# Build the docker and add it :

setup:
	sudo docker build -t latexer .
	xhost +local:docker

run:
	sudo docker run -it --rm \
    		-v "$PWD":/project \
    		-w /project \
    		--net=host \
    		-e DISPLAY=$DISPLAY \
    		-v /tmp/.X11-unix:/tmp/.X11-unix \
    		latexer
