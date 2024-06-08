
LATEX = pdflatex

BUILD_DIR = build
DOC_DIR = doc
CHAPTERS_DIR = $(BUILD_DIR)/chapters

PDF = $(BUILD_DIR)/main.pdf
TEX_FILES = $(shell find $(DOC_DIR) -type f -name '*.tex')


all: $(PDF)

$(BUILD_DIR):
	@echo Creating: $@
	@mkdir -p $@

$(CHAPTERS_DIR):
	@echo Creating: $@
	@mkdir -p $@

# It recompiles two times to update also the table of contents
$(BUILD_DIR)/main.pdf: $(TEX_FILES) | $(BUILD_DIR) $(CHAPTERS_DIR)
	@echo Compiling: $(TEX_FILES)  -o $@
	@cd $(DOC_DIR) && $(LATEX) -output-directory=../$(BUILD_DIR) $(notdir $<) \
		       && $(LATEX) -output-directory=../$(BUILD_DIR) $(notdir $<)

clean: 
	rm -rvf $(BUILD_DIR)

show: all
	xdg-open $(PDF)

