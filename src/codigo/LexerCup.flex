package codigo;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char

// Definición de patrones
espacio = [ \t\r\n]+
numero_entero = [0-9]+
numero_decimal = [0-9]+\.[0-9]{2}
letra = [a-zA-ZáéíóúÁÉÍÓÚñÑ]
nombre = {letra}({letra}|[" "])*
codigo_postal = [0-9]{5}
seccion = \([0-9]{1,2};[ ]?[0-9]{1,2}\)

%{
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Espacios en blanco */
{espacio} {/* Ignorar */}

/* Comentarios */
"//".* {/* Ignorar */}

/* Tokens definidos */
{nombre} { return new Symbol(sym.NombreComprador, yychar, yyline, yytext()); }
{codigo_postal} { return new Symbol(sym.CodigoPostal, yychar, yyline, yytext()); }
{seccion} { return new Symbol(sym.Ubicacion, yychar, yyline, yytext()); }
{numero_entero} { return new Symbol(sym.Cantidad, yychar, yyline, yytext()); }
{numero_entero}(\.[0-9]{2})? { return new Symbol(sym.Precio, yychar, yyline, yytext()); }
\"[^\"]*\" { return new Symbol(sym.DescripcionArticulo, yychar, yyline, yytext()); }
"-" { return new Symbol(sym.Guion, yychar, yyline, yytext()); }
. { return new Symbol(sym.ERROR, yychar, yyline, yytext()); }
