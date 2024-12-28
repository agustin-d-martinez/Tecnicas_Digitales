.global _UND_handler
.global _SVC_handler
.global _Prefetch_handler
.global _Abort_handler
.global _IRQ_handler
.global _FIQ_handler

.code 32                            // Indico que mi còdigo es de 32
.section .text_handler    

_UND_handler:
    B   .
_SVC_handler:
    B   .
_Prefetch_handler:
    B   .
_Abort_handler:
    B   .
_IRQ_handler:
    B   .
_FIQ_handler:
    B   .
.end
