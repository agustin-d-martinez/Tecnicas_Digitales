.extern _start

.global _reset_vector

.code 32                            // Indico que mi còdigo es de 32
.section .text_reset_vector  

_reset_vector:
    B   _start
.end
