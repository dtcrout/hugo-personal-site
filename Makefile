# META ]------------------------------------------------------------------------
help:
	@echo "theme				Make theme directory and clone theme to directory."
	@echo "local				Serve site locally in debug mode."
	@echo "build				Make site files."
	@echo "clean				Remove artifacts and standardize repo."

# CORE ]------------------------------------------------------------------------
theme:
	mkdir -p themes && cd themes && git clone https://github.com/dtcrout/hugo-theme-basic.git

local:
	hugo server -D

build:
	hugo -t hugo-theme-basic

clean:
	rm -rf public
