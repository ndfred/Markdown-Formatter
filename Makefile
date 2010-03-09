# Transform Markdown format files into HTML

# Change this to suit your Markdown files extension
EXTENSION := mdown

tools := Markdown.pl SmartyPants.pl
objects := $(subst .$(EXTENSION),.html,$(wildcard *.$(EXTENSION)))
rtf_objects := $(subst .$(EXTENSION),.rtf,$(wildcard *.$(EXTENSION)))

.PHONY : clean distclean all allrtf

all : $(objects)
allrtf: $(rtf_objects)

Markdown.pl :
	curl "http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip" > archive.zip
	unzip -jo archive.zip
	rm archive.zip License.text "Markdown Readme.text"

SmartyPants.pl :
	curl "http://daringfireball.net/projects/downloads/SmartyPants_1.5.1.zip" > archive.zip
	unzip -jo archive.zip
	rm archive.zip "SmartyPants Readme.txt"

%.html : %.$(EXTENSION) $(tools)
	perl Markdown.pl $< | perl SmartyPants.pl > $@

# Output to RTF to check spelling
# This only work on Mac OS X
%.rtf : %.html
	textutil -convert rtf $< -output $@

clean :
	rm -f $(objects) $(rtf_objects)

distclean : clean
	rm -f $(tools)
