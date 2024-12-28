/*
    Definiciones necesarias: formato de salida, arquitectura y punto de entrada
*/
OUTPUT_FORMAT("elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_reset_vector)


/*
    Definiciones de simbolos necesarias 
*/
_PUBLIC_RAM_INIT = 0x70010000;
_PUBLIC_STACK_INIT = 0x70020000;

/*
    Definiciòn del mapa de memoria
*/
MEMORY
{
    public_ram : org = _PUBLIC_RAM_INIT, len = 0x1000
    public_stack : org = _PUBLIC_STACK_INIT, len = 0x1000
}
/*
    Definicion de las secciones
*/
SECTIONS
{
    . = _PUBLIC_RAM_INIT;
    .text : {
        *(.text_reset_vector)
        *(.text_startup)
        *(.text*)
        } > public_ram
    
    .data : { *(.data*) }> public_ram

    .bss : {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss*)
        __bss_end__ = .;
        } > public_ram
}