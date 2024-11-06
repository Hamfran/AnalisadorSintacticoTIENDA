package codigo;

import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens

// Definición de patrones
espacio = [ \t\r\n]+
numero_entero = [0-9]+
numero_decimal = [0-9]+\.[0-9]{2}
letra = [a-zA-ZáéíóúÁÉÍÓÚñÑ]
nombre = ({letra}+)([ ]{letra}+)
codigo_postal = [0-9]{5}
seccion = \([0-9]{1,2};[ ]?[0-9]{1,2}\)
precio = [0-9]+(\.[0-9]{2})?

%{
 public String lexeme;
%}
%%

{espacio} {/* Ignorar */}
"//".* {/* Ignorar */}
{nombre} {lexeme=yytext(); return NombreComprador; }
{codigo_postal} {lexeme=yytext(); return CodigoPostal; }
{seccion} {lexeme=yytext(); return Ubicacion; }
{numero_entero} {lexeme=yytext(); return Cantidad; }
{numero_decimal} {lexeme=yytext(); return Precio; }
\"[^\"]*\" {lexeme=yytext(); return DescripcionArticulo; }
"-" {lexeme=yytext(); return Guion; }
. {lexeme=yytext(); return ERROR;}
