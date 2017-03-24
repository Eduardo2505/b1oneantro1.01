/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.impresion1;

/**
 *
 * @author Eduardo
 */
public class TiketImprimir {

    public String ImprimirComanda(String mesero, String clave, String idMesa, String idComanda, String fechaAc, String horaAc, String tipo, String autoriza, String Obs, String res, String ita, String concian) {

        StringBuffer resultado = new StringBuffer("");
        String cabecera = "**\n\n\t      B1ONE\n"
                + "\t    COPIA\n**BARRA PEDIDO** \n";
        String cabeceracopia = "**\n\n\t ** CAJA PEDIDO **\n"
                + "**No es valido para barra** \n";
        String cabeceracopiaITA = "**\n\n\t\n COPIA\n**COCINA PEDIDO**\n"
                + "* \n";
        resultado.append(""
                + "Mesero:\n"
                + "" + mesero + "\n"
                + "Clave: 	"
                + "" + clave + "\n"
                + "	\n"
                + "Cuenta:  " + idMesa + " 	\n"
                + "Comanda: " + idComanda + " 	\n"
                + "FECHA: 	" + fechaAc + " 	\n"
                + "HORA: 	" + horaAc + " 	\n"
                + "TIPO: "
                + "" + tipo + "\n");


        if (!tipo.equals("VENTA")) {
            resultado.append("Autorización:\n"
                    + "" + autoriza + ""
                    + "\nDescripción:\n"
                    + "" + Obs + "");
        }


        resultado.append("	\n"
                + "	"
                + "Producto	Cantidad\n");
        resultado.append(res + "\n\n");

        String original = cabecera + resultado.toString() + "\n\n\n" + CortarHoja();
        String copia = cabeceracopia + resultado.toString() + "\n\n\n" + CortarHoja();
        String copiaITA = cabeceracopiaITA + resultado.toString() + "\n\n\n" + CortarHoja();
        //Ticket ti = new Ticket(original + copia);
        // ti.print();
        String tiket = "";
        if (ita.equals("Activo") && concian.equals("Activo")) {
            tiket = original + copia + copiaITA;
        } else if (concian.equals("Activo")) {
            tiket = copiaITA + copia;
        } else {
            tiket = original + copia;

        }



        System.out.println(tiket);

        return tiket;

    }

    public String ImprimirComandaCancelad(String mesero, String clave, String idMesa, String idComanda, String fechaAc, String horaAc, String tipo, String autoriza, String Obs, String res) {

        StringBuffer resultado = new StringBuffer("");
        String cabecera = "**\n\n\t      B1ONE\n"
                + "\t    CANCELACION\n";
        String cabeceracopia = "**\n\n\t **COMANDA**\n"
                + "**No es valido para barra** \n";
        resultado.append(""
                + "Mesero:\n"
                + "" + mesero + "\n"
                + "Clave: 	"
                + "" + clave + "\n"
                + "	\n"
                + "Cuenta:  " + idMesa + " 	\n"
                + "Comanda: " + idComanda + " 	\n"
                + "Autorización: " + autoriza + " 	\n"
                + "Descripción: " + Obs + " 	\n"
                + "FECHA: 	" + fechaAc + " 	\n"
                + "HORA: 	" + horaAc + " 	\n"
                + "TIPO: "
                + "" + tipo + "\n");




        resultado.append("	\n"
                + "	"
                + "Producto	Cantidad\n");
        resultado.append(res + "\n\n");

        String original = cabecera + resultado.toString() + "\n\n\n" + CortarHoja();

        Ticket ti = new Ticket(original);
        // ti.print();
        String tiket = original;


        //   System.out.println(tiket);

        return tiket;

    }

    public String Imprimirtiket(String mesero, String clave, int posicion, String idMesa, int per, String fechaAc, String horaAc, String subto, String ste, float sumatotal, String re) {

        StringBuffer resultado = new StringBuffer("");


        String valo = "  **  \n\n                B1ONE \n"
                + "  Niza 19 Col. Juárez Del. Cuauhtémoc\n"
                + "            MÉXICO, D. F.\n"
                + "           TEL. 41 69 18 20\n"
                + "          RFC: OPR1403115F3\n"
                + "Mesero:		\n"
                + "" + mesero + "\n"
                + "	\n"
                + "Clave: "
                + "" + clave + "\n"
                + "	\n"
                + "Mesa: 	"
                + "" + posicion + "\n"
                + "	\n"
                + "Cuenta: 	" + idMesa + " 	\n"
                + "Personas Aprox: 	" + per + "	\n"
                + "FECHA: 	" + fechaAc + " 	\n"
                + "HORA: 	" + horaAc + " 	\n"
                + "	\n";

        resultado.append(valo);

        resultado.append(re);
        String su = "	_________________\n"
                + "Subtotal:   	   $ " + subto + "\n"
                + "IVA 16%:	   $ " + ste + "\n"
                + "	___________________\n"
                + "TOTAL:	    $ " + sumatotal + "\n\n\n"
                + "           PROPINA NO INCLUIDA\n"
                + "         PROPINA NO OBLIGATORIA\n"
                + "          RESERVA PARA NO COVER\n"
                + "             Y PROMOCIONES\n"
                + "            b1onerestobar.mx\n"
                + "            Tel. 41 69 18 20\n\n\n\n\n\n\n" + CortarHoja();
        resultado.append(su);

        System.out.println(resultado.toString());

        return resultado.toString();
    }

    public static String CortarHoja() {
        return (char) 27 + "m";
    }

    public static void main(String[] args) {
        TiketImprimir dao = new TiketImprimir();
        // dao.Imprimirtiket();

    }
}
