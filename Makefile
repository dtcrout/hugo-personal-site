# META ]------------------------------------------------------------------------
.PHONY: help
help:
	@echo "theme				Make theme directory and clone theme to directory."
	@echo "local				Serve site locally in debug mode."
	@echo "build				Make site files."
	@echo "clean				Remove artifacts and standardize repo."

THEME_REPO = "https://github.com/dtcrout/hugo-theme-basic.git"

# CORE ]------------------------------------------------------------------------
.PHONY: theme
theme:
	mkdir -p themes && \
	cd themes && \
	git clone $(THEME_REPO)

.PHONY: local
local:
	hugo server -D

.PHONY: build
build:
	hugo -t hugo-theme-basic

.PHONY: public
clean:
	rm -rf public
