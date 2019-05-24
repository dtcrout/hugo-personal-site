default:
	mkdir -p themes && cd themes && git clone https://github.com/siegerts/hugo-theme-basic.git

test:
	hugo server -D

build:
	hugo -t hugo-theme-basic

clean:
	rm -rf public
