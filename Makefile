all: src doc FORCE

src: FORCE
	make -C src/

doc: FORCE
	make -C doc/


clean: FORCE
	make -C src/ clean
	make -C doc/ clean

dist: clean
	tar -cz ../hedeep > ../hedeep.tgz

FORCE:


