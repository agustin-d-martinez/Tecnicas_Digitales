int suma_c ( int a , int b );

__attribute__((section(".text"))) int suma_c ( int a , int b )       //Le digo que esto va en la secciòn text.
{
    int c;              //Como creo variables uso la pila (stack)
    c = a + b;
    return c ;
}
