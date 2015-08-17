include ../Makefile.builtem

include t2t_docsys/Makefile.include

.PHONY: all doc install
all: doc
doc: manual.txt manual.html readme.txt readme_md.md
install: doc
	$(call cp,manual.txt,../MANUAL)
	$(call cp,manual.html,../MANUAL.html)
	$(call cp,readme.txt,../README)
	$(call cp,readme_md.md,../README.md)

%.html: %.t2t $(wildcard *.t2t)
	$(call t2t_docsys_html,$@,$<,manual)

%.txt: %.t2t $(wildcard *.t2t)
	$(call t2t_docsys_txt,$@,$<,manual)

%.md: %.t2t $(wildcard *.t2t)
	$(call t2t_docsys_md,$@,$<,manual)

%.pdf: %.t2t $(wildcard *.t2t)
	$(call t2t_docsys_pdf,$@,$<,manual)

.PHONY: clean
clean:
	@$(call rm,$(T2T_DOCSYS_OUTPUT_WILDCARDS))
