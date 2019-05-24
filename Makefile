# META ]------------------------------------------------------------------------
help:
	@echo "default				Make theme directory and clone theme to directory."
	@echo "latest				Serve site locally in debug mode."
	@echo "build				Make site files."
	@echo "clean				Remove artifacts and standardize repo."

# CORE ]------------------------------------------------------------------------
default:
	mkdir -p themes && cd themes && git clone https://github.com/siegerts/hugo-theme-basic.git

test:
	hugo server -D

build:
	hugo -t hugo-theme-basic

clean:
	rm -rf public
