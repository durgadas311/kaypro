CLASS_PATH = .:z80cpu/z80core.jar:diablo630/Diablo630Embedded.jar

JAVAS = $(wildcard *.java)
CLASSES = $(subst .java,.class,$(JAVAS))

all: z80cpu/z80core.jar diablo630/Diablo630Embedded.jar $(CLASSES)

%.class: %.java
	javac -cp $(CLASS_PATH) $?

run:
	java -cp $(CLASS_PATH) VirtualKaypro84

VirtualKaypro84.jar: all temp
	echo "Main-Class: VirtualKaypro84" >Manifest.txt
	jar -cmf Manifest.txt VirtualKaypro84.jar *.class \
		*.rom *.ttf *.wav \
		-C temp .
	rm -rf temp

temp: __FRC__
	mkdir -p temp
	rm -rf temp/*
	cd temp; jar -xf ../z80cpu/z80core.jar
	rm -rf temp/META-INF
	cd temp; jar -xf ../diablo630/Diablo630Embedded.jar
	rm -rf temp/META-INF

z80cpu/z80core.jar:
	make -C z80cpu z80core.jar

diablo630/Diablo630Embedded.jar:
	make -C diablo630 Diablo630Embedded.jar

src:
	cd ..; tar -czf kaypro84/v89.tgz kaypro84/Makefile \
		kaypro84/README kaypro84/INSTALL \
		kaypro84/*.java \
		kaypro84/*.rom \
		kaypro84/*.ttf \
		kaypro84/*.wav \
		kaypro84/www/*.*

__FRC__:
