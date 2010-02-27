# Transform Markdown format .text files into HTML

TOOLS := Markdown.pl SmartyPants.pl
OBJECTS := $(subst .text,.html,$(wildcard *.text))

.PHONY : clean distclean

all : $(OBJECTS)

Markdown.pl :
	curl "http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip" > archive.zip
	unzip -jo archive.zip
	rm archive.zip License.text "Markdown Readme.text"

SmartyPants.pl :
	curl "http://daringfireball.net/projects/downloads/SmartyPants_1.5.1.zip" > archive.zip
	unzip -jo archive.zip
	rm archive.zip "SmartyPants Readme.txt"

%.html : %.text $(TOOLS)
	perl Markdown.pl $< | perl SmartyPants.pl >> $@

clean :
	rm -f $(OBJECTS)

distclean : clean
	rm -f $(TOOLS)
