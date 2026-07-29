LATEXMK ?= latexmk
LATEXMK_FLAGS ?= -g -xelatex -interaction=nonstopmode -halt-on-error -file-line-error

BUILD_DIR := build
DIST_DIR := dist

VERSIONS := zh_CN/default zh_CN/internet zh_CN/state-owned zh_CN/hpc zh_CN/zte en_US/default
VERSION_TARGETS := $(subst /,-,$(VERSIONS))
PDFS := $(addprefix $(DIST_DIR)/,$(addsuffix .pdf,$(VERSION_TARGETS)))

TEX_DEPS := $(shell find src content versions -type f -name '*.tex' 2>/dev/null)
TEX_DEPS += resume.cls fontawesome.sty linespacing_fix.sty
TEX_DEPS += zh_CN-Adobefonts_external.sty zh_CN-Adobefonts_internal.sty

.PHONY: all pdf clean distclean list zh_CN en en_US internet state-owned soe hpc zte $(VERSION_TARGETS)

all: pdf

pdf: $(PDFS)

list:
	@printf '%s\n' $(VERSIONS)

zh_CN: zh_CN-default
en en_US: en_US-default
internet: zh_CN-internet
state-owned soe: zh_CN-state-owned
hpc: zh_CN-hpc
zte: zh_CN-zte

$(DIST_DIR) $(BUILD_DIR):
	mkdir -p $@

define BUILD_RESUME
$(DIST_DIR)/$(subst /,-,$(1)).pdf: versions/$(1).tex $(TEX_DEPS) | $(DIST_DIR) $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/$(subst /,-,$(1))
	$(LATEXMK) $(LATEXMK_FLAGS) -outdir=$(BUILD_DIR)/$(subst /,-,$(1)) -jobname=$(subst /,-,$(1)) versions/$(1).tex
	cp $(BUILD_DIR)/$(subst /,-,$(1))/$(subst /,-,$(1)).pdf $$@

$(subst /,-,$(1)): $(DIST_DIR)/$(subst /,-,$(1)).pdf
endef

$(foreach version,$(VERSIONS),$(eval $(call BUILD_RESUME,$(version))))

clean:
	rm -rf $(BUILD_DIR)
	find . -maxdepth 1 -type f \( -name '*.aux' -o -name '*.bbl' -o -name '*.blg' -o -name '*.fdb_latexmk' -o -name '*.fls' -o -name '*.log' -o -name '*.out' -o -name '*.synctex.gz' -o -name '*.xdv' \) -delete
	if [ -d "$(DIST_DIR)" ]; then find $(DIST_DIR) -maxdepth 1 -type f \( -name '*.aux' -o -name '*.bbl' -o -name '*.blg' -o -name '*.fdb_latexmk' -o -name '*.fls' -o -name '*.log' -o -name '*.out' -o -name '*.synctex.gz' -o -name '*.xdv' \) -delete; fi

distclean: clean
	rm -rf $(DIST_DIR)
