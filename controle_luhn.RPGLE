     h nomain

     dVerif_Luhn       PR              N
     d a_Nombre_Luhn              32768A   OPTIONS(*VARSIZE) CONST


     dCalcul           PR             6  0
     d a_Nombre_Luhn              32768A   OPTIONS(*VARSIZE) CONST

     d a_longueur               e      5i 0

     D*--------------------------------------------------
     D* Procedure name: parite
     D* Purpose:        Déterminer si un nombre est pair ou impair
     D* Returns:
     D* Parameter:      a_nombre => Nombre dont on vérifie la parité
     D*--------------------------------------------------
     Dparite           PR              N
     D  a_nombre                      6P 0 value

     pVerif_Luhn       b                   Export
     dVerif_Luhn       PI              N
     dg_nbre_luhn                 32768A   OPTIONS(*VARSIZE) CONST

     d g_longueur      s              5i 0
     d g_valid         s              1  0
     d g_luhn          s               N
     d g_Nombre_Luhn   s             20A   Varying
      /free
       g_Nombre_Luhn=%trim(g_nbre_luhn);
       g_longueur=%len(%trim(g_Nombre_Luhn));
       g_valid=%rem( calcul(g_Nombre_Luhn:g_longueur):10);
       If g_valid=0;
         g_Luhn=*on;
       Else;
         g_Luhn=*off;
       ENDIF;
       Return g_Luhn;
      /end-free

     pVerif_Luhn       e

     pcalcul           b
     dCalcul           PI             6  0
     d l_Nombre_Luhn              32768A   OPTIONS(*VARSIZE) CONST
     d l_longueur                     5i 0

     d l_pos           s              5i 0
     d l_total         s              6  0
     d l_ajout         s              2  0

      /free

       FOR l_pos = l_longueur DOWNTO 1;
       // Le corps de la boucle va ici
         l_ajout=%dec(%subst(l_Nombre_Luhn:l_pos:1):2:0);
         if parite(l_pos);
           l_ajout=l_ajout*2;
           if l_ajout>9;
             l_ajout=l_ajout-9;
           ENDIF;
         ENDIF;
         l_total=l_total+l_ajout;
       ENDFOR;

       return l_total;
      /end-free

     pcalcul           e


     P*--------------------------------------------------
     P* Procedure name: parite
     P* Purpose:        Déterminer di un nombre est pair ou impair
     P* Returns:
     P* Parameter:      a_nombre => Nombre dont on vérifie la parité
     P*--------------------------------------------------
     P parite          B
     D parite          PI              N
     D  l_nombre                      6P 0 value


     D* Local fields
     D l_reste         s              1  0
     d l_pair          s               N   inz(*off)

      /FREE

        l_reste= %rem( l_nombre:2);
        if l_reste=0;
          l_pair=*on;
        ENDIF;

        RETURN l_pair;

      /END-FREE
     P parite          E
 
