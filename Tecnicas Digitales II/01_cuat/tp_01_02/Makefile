#####################################################################
# AUTHOR INFORMATION 												#
#####################################################################
# AUTHOR: Agustin martinez
# DATE: 27/05/24
# VERSION: 2.0

#####################################################################
# APP NAME 															#
#####################################################################
APP=baremetal_start

#####################################################################
# COMPILER AND ARGUMENTS 											#
#####################################################################
#toolchain
CHAIN=arm-none-eabi
# falgs del compilador
CFLAGS=-std=gnu99 -Wall -mcpu=cortex-a8
#Linker
LD=memmap.ld

#####################################################################
# DIRECTORY TREE, SOURCES, OBJECTS 									#
#####################################################################
CURRENT_LOCATION := $(shell pwd)
OBJ_DIR :=obj
PROC_DIR :=proc
BIN_DIR :=bin
INC_DIR :=inc
SYS_DIR :=sys
KERNEL_DIR :=kernel
CORE_DIR :=core
LST_DIR :=bin
##CORE_DIR: Aca van los archivos del procesador (los de assembler)
##KERNEL_DIR: Aca van los archivos del kernel (tareas y archicos de C#)
#Lista de archivos necesarios para el proyecto
ASM_FILES = $(wildcard *.s)
HEADER_FILES = $(wildcard *.h)

CORE_ASM_F = $(wildcard $(CORE_DIR)/*.s)
OBJ_ASM_F = $(CORE_ASM_F:$(CORE_DIR)/%.s=$(OBJ_DIR)/%.o)

PROG_ASM_F = $(wildcard $(PROC_DIR)/*.c)
OBJ_PROG_F = $(PROG_ASM_F:$(PROC_DIR)/%.c=$(OBJ_DIR)/%.o)

KERNEL_F = $(wildcard $(KERNEL_DIR)/*.c)
OBJ_KERNEL_F = $(KERNEL_F:$(KERNEL_DIR)/%.c=$(OBJ_DIR)/%.o)
#####################################################################
# Debugguer y Emulacion			 									#
#####################################################################
#placa a emular en la maquina virtual de QEMU
BOARD=realview-pb-a8
#otras placas posibles a emular descomentar la que se quiera usar
#BOARD=mcimx6ul-evk
#BOARD=vexpress-a15
# para ver el listado completo usar el comando:
# qemu-system-arm -M help | grep Cortex-A
# se puede usar cualquiera lo que cambia es el vector de reset en la emualcion
# tener en cuenta esto para modificar el linker script acorde

#falgs para el QEMU
PORT=12345
VMFLGS= -M $(BOARD) -m 32M -no-reboot -nographic -monitor telnet:127.0.0.1:$(PORT),server,nowait
# motor de maquina virtual a utilizar
VME=qemu-system-arm

CC=ddd
CCFLGS=--debugger

TEXT_FILE=.gdbinit
#####################################################################
# EXECUTABLE FINAL FILE 											#
#####################################################################
EXEF=$(BIN_DIR)/$(APP).bin

#####################################################################
# MAKE TARGETS					 									#
#####################################################################
all: $(EXEF) $(OBJ_DIR)/$(APP).elf


#Si no tengo el binario ejecutable
$(EXEF): $(OBJ_DIR)/$(APP).elf
	@echo "Creando Ejecutable"
	$(CHAIN)-objcopy -O binary $< $@


#Si no tengo el .elf de mi proyecto
$(OBJ_DIR)/$(APP).elf: $(OBJ_ASM_F) $(OBJ_KERNEL_F) $(OBJ_PROG_F) | $(OBJ_DIR)
#Creo el .elf y el .map
	@echo ""
	@echo "Linkeando ... "
	$(CHAIN)-ld -T $(LD) $(OBJ_DIR)/*.o -o $(OBJ_DIR)/$(APP).elf -Map $(LST_DIR)/$(APP).map
	@echo "Linkeo finalizado!!"
	@echo ""
#Creo el .lst
	@echo "Generando archivos de información: mapa de memoria y símbolos"
	readelf -a $(OBJ_DIR)/$(APP).elf > $(LST_DIR)/$(APP)_elf.txt
	$(CHAIN)-objdump -D $(OBJ_DIR)/$(APP).elf > $(LST_DIR)/$(APP).lst


##Creacion de todos los archivos objeto necesarios
$(OBJ_DIR)/%.o: $(CORE_DIR)/%.s | $(OBJ_DIR)				
##Creo el .o ($@) en base al .s ($<) y de paso me hago el lst.
	@echo ""
	@echo "Ensamblando $(basename $(notdir $@)) ..."
	$(CHAIN)-as -g $< -o $@ -a > $(LST_DIR)/$(basename $(notdir $@)).lst

##Creacion de todos los archivos objeto en lenguaje C
$(OBJ_DIR)/%.o: $(KERNEL_DIR)/%.c
	@echo ""
	@echo "Compilando $(basename $(notdir $@)) ..."
	$(CHAIN)-gcc -g -O3 $(CFLAGS) -c $< -o $@

##Creacion de todos los archivos objeto en lenguaje C
$(OBJ_DIR)/%.o: $(PROC_DIR)/%.c
	@echo ""
	@echo "Compilando $(basename $(notdir $@)) ..."
	$(CHAIN)-gcc -g -O3 $(CFLAGS) -c $< -o $@

##Creacion de las carpetas para objetos
$(OBJ_DIR):
	@echo ""
	@echo "Creando arbol de directorios ..."	
	mkdir -p $(BIN_DIR)							
	mkdir -p $(OBJ_DIR)
	mkdir -p $(PROC_DIR)
	mkdir -p $(LST_DIR)
	mkdir -p $(SYS_DIR)
	mkdir -p $(INC_DIR)
	@echo "Arbol de directorios creado "	

order: 
	@echo ""
	@echo "Ordenando Proyecto ..."	
	mkdir -p $(BIN_DIR)							
	mkdir -p $(OBJ_DIR)
	mkdir -p $(PROC_DIR)
	mkdir -p $(LST_DIR)
	mkdir -p $(SYS_DIR)
	@if [ -n "$(ASM_FILES)" ]; then \
		mkdir -p $(CORE_DIR);	\
		mv $(ASM_FILES) $(CORE_DIR); \
	fi

	@if [ -n "$(HEADER_FILES)" ]; then \
		mkdir -p $(INC_DIR);	\
		mv $(HEADER_FILES) $(INC_DIR); \
	fi
clean:
	rm -rf $(OBJ_DIR)/*.o
	rm -rf $(OBJ_DIR)/*.elf
	rm -rf $(OBJ_DIR)/*.txt
	rm -rf $(BIN_DIR)/*.bin
	rm -rf $(LST_DIR)/*.lst
	rm -rf $(LST_DIR)/*.txt
	rm -rf $(LST_DIR)/*.map


#Empieza a simular con qemu a la placa.
run:
# Estos echo generan el .gdbinit en la posicion actual.
#	echo "add-auto-load-safe-path $(shell pwd)" > $(HOME)/$(TEXT_FILE)
#	echo "set architecture arm\ntarget remote localhost:2159" > $(shell pwd)/$(TEXT_FILE)
	
# Estos echo generan el .gdbinit en "Documentos". Si ya los tenes creados, es innecesario. Siempre ponen lo mismo
#	echo "add-auto-load-safe-path $(HOME)/Documentos" > $(HOME)/$(TEXT_FILE)
#	echo "set architecture arm\ntarget remote localhost:2159" > $(HOME)/Documentos/$(TEXT_FILE)
	$(VME) $(VMFLGS) -kernel $(EXEF) -S -gdb tcp::2159


#Abre el gdb. Este comando debe ejecutarse donde se encuentra el .gdbinit. 
debug:
# Este comando ejecuta el debugger desde documentos
	$(shell cd $(HOME)/Documentos && $(CC) $(CCFLGS) gdb-multiarch $(CURRENT_LOCATION)/$(OBJ_DIR)/$(APP).elf)
# ESte comando ejecuta el debugger desde mi posicion actual
#	$(CC) $(CCFLGS) gdb-multiarch $(OBJ_DIR)/$(APP).elf


#Ejecuta ambas instrucciones en simultaneo, lo que abre el ddd y pone a simular en qemu. GUARDA. cuando la use me dejo un PID qemu en el aire weon
run&debug:
# Estos echo generan el .gdbinit en la posicion actual.
#	echo "add-auto-load-safe-path $(shell pwd)" > $(HOME)/$(TEXT_FILE)
#	echo "set architecture arm\ntarget remote localhost:2159" > $(shell pwd)/$(TEXT_FILE)
	
	$(VME) $(VMFLGS) -kernel $(EXEF) -S -gdb tcp::2159 & $(CC) $(CCFLGS) gdb-multiarch $(OBJ_DIR)/$(APP).elf

rebuild: clean order all

.PHONY: all clean order run debug rebuild

