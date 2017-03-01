CLASS_PATH = .:z80cpu/z80core.jar:diablo630/Diablo630Embedded.jar

JAVAS = $(wildcard *.java)
CLASSES = $(subst .java,.class,$(JAVAS))

all: z80cpu/z80core.jar diablo630/Diablo630Embedded.jar $(CLASSES)

%.class: %.java
	javac -source 1.7 -target 1.7 -cp $(CLASS_PATH) $?

run:
	java -cp $(CLASS_PATH) VirtualKaypro

VirtualKaypro.jar: all temp
	echo "Main-Class: VirtualKaypro" >Manifest.txt
	jar -cmf Manifest.txt VirtualKaypro.jar *.class \
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

jar: VirtualKaypro.jar

src:
	cd ..; tar -czf kaypro84/vkaypro.tgz kaypro84/Makefile \
		kaypro84/*.java \
		kaypro84/*.rom \
		kaypro84/*.ttf \
		kaypro84/*.wav

www: __FRC__
	rsync -Wuv www/*.* durgadas.com:/http/durgadas.com/sims/kaypro
	rsync -rWuv www/downloads/. durgadas.com:/http/durgadas.com/sebhc/kaypro/.
	rsync -rWuv ../disks/. durgadas.com:/http/durgadas.com/sebhc/kaypro/disks/.
	rsync -rWuv ../configs/. durgadas.com:/http/durgadas.com/sebhc/kaypro/configs/.

ship:
	rsync -Wuv *.jar vkaypro.tgz z80cpu/z80cpu.tgz diablo630/diablo630.tgz \
		durgadas.com:/http/durgadas.com/sebhc/kaypro

__FRC__:
