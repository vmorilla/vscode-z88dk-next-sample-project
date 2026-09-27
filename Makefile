
SUBDIRS := src

CSPECT := cspect
CSPECT_FLAGS := -debug -50  #-rewind #-threaded 


.PHONY: all $(SUBDIRS) clean run

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

run: all
	$(CSPECT) $(CSPECT_FLAGS) build/main.nex

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done