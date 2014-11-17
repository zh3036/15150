# hw06
# Handout version 
# Writeup version 
# Library version 

HANDINURL := http://unofficial.fish.ics.cs.cmu.edu/officialSubmit.rb

.PHONY: all run clean submit
all: hw06-handin.tgz

# This Makefile gets handed in too as part of a just-in-case
# paper trail so that, if issues arise, we can tell what
# version of the handout you were working with. Be sure to
# stay on top of email and Piazza announcements so you'll
# know if we have to issue an emergency post-release fix!
hw06-handin.tgz: funvec.sml hw06.pdf listvec.sml matrix.sml sparsevec.sml test-all.sml util.sml 
	tar -czf hw06-handin.tgz Makefile $^

# Do not call 'make run' as a student for a non-modular assignment
run: sources.cm
	mkdir make-run-backup
	echo " end" > suff.txt
	for file in `ls *.sml`; do cp $$file make-run-backup
		f=`echo $$file | sed 's/\(.*\)\..*/\1/'` && fstr=`echo $$f | sed 's/\(.\)\(.*\)/\U\1\E\2/'` && fsig=`echo $$f | sed 's/\(.*\)/\U\1/'` && echo "structure $$fstr : $$fsig = struct " > pref.txt && grep -q 'structure\|functor' $$file || (cat pref.txt $$file suff.txt >> cat.txt && mv cat.txt $$file); done
	rm -f pref.txt suff.txt
	sml -m sources.cm
	mv -f make-run-backup/* .
	rmdir make-run-backup

clean:
	rm -f hw06-handin.tgz
	rm -Rf .cm

# "I accidentally submitted old LaTeX..."  Don't be that guy.
%.pdf: %.tex
	@echo '$@ is older than $<'
	@echo -n 'Would you like to run pdflatex? [Y/n] '
	@read ANS; if [ -z "$$ANS" -o "$$ANS" = y -o "$$ANS" = Y ]; then echo pdflatex $<; pdflatex $<; fi

# Submit your solution to autolab
submit: hw06-handin.tgz
	hostname | grep 'qatar\.cmu\.edu\|andrew\.cmu\.edu\|cs\.cmu\.edu' || { echo "You're not on a CMU machine!"; exit 1; }
	cp hw06-handin.tgz `wget -q -O- "$(HANDINURL)?course=15150q-f14&user=$(USER)&assessment=hw06"`
	wget -q -O- "$(HANDINURL)?course=15150q-f14&user=$(USER)&assessment=hw06&submit=hw06-handin.tgz" > grep 'Submission received' || echo "Submission Uploaded, make sure you check your submission on the autolab webpage"
