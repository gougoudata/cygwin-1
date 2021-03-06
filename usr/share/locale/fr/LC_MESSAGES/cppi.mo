��    >        S   �      H  S  I  /   �  �   �  �   �  �   n  w   -	     �	     �	  Z  �	  �   ,  ,   �  5     �   U     4  0   H     y     �     �     �  +   �  {     "   �  4   �  8   �     "  ,   @  ,   m  ,   �  '   �  -   �        (   >  (   g     �     �     �     �  ?   �          &     ;     R  1   g     �  ;   �  3   �  /      +   P  '   |  #   �     �     �                     1  $   R     w  �   �     P     c  �  o  �    :   �  �   �  �   �  �   �  l   w     �       �  #  �     5   �  ?   "  �   b     R  :   p  (   �  &   �  0   �  -   ,   2   Z   |   �   '   
!  =   2!  A   p!     �!  6   �!  =   "  6   F"  .   }"  7   �"  (   �"  /   #  /   =#  %   m#  %   �#     �#     �#  S   �#     $     )$  #   A$     e$  7   ~$     �$  ;   �$  1   %  -   :%  )   h%  %   �%  !   �%     �%     �%     &     "&  '   '&  0   O&  7   �&     �&  �   �&     �'     �'              '       
   2      .   =   ,              5       6                 4                (             $      "                                0       #       >                !   -   1   3           +                    8   &   <       /   ;             )       	   :   7       %   9   *        
  -a, --ansi             when checking, fail if text follows #else or #endif
  -c, --check            set exit code, but don't produce any output
  -l, --list-files-only  don't generate diagnostics about indentation;
                         print to stdout only the names of files that
                         are not properly indented
 
A pragma directive may have its `#' indented.
 
Indent the C preprocessor directives in FILE to reflect their nesting
and ensure that there is exactly one space character between each #if,
#elif, #define directive and the following token, and write the result
 
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

 
NOTE: your shell may have its own version of %s, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.
 
Note that --ansi without --check does not correct the problem of
non-ANSI text following #else and #endif directives.
 
Report bugs to <%s>.
 
Report bugs to: %s
 
The exit code will be one of these:
  0  all directives properly indented
  1  some cpp directive(s) improperly indented, or
     text follows #else/#endif (enabled with --check --ansi), or
     a double-quoted string is longer than the specified maximum
  2  #if/#endif mismatch, EOF in comment or string
  3  file (e.g. open/read/write) error
 
With the -c option, don't write to stdout.  Instead, check the
indentation of the specified files giving diagnostics for preprocessor
lines that aren't properly indented or are otherwise invalid.
       --help     display this help and exit
       --version  output version information and exit
   -m, --max-string-length=LENGTH
                         fail if there is a double-quoted string longer
                         than LENGTH;  if LENGTH is 0 (the default),
                         then there is no limit
 %s home page: <%s>
 %s home page: <http://www.gnu.org/software/%s/>
 %s%s argument '%s' too large %s: invalid option -- '%c'
 %s: line %d: EOF in comment %s: line %d: EOF in string %s: line %d: found #%s without matching #if %s: line %d: not properly formatted;
there must be exactly one SPACE character after each
#if, #elif, and #define directive %s: line %d: not properly indented %s: line %d: string (%lu) longer than maximum of %lu %s: line %d: text following `#%s' violates ANSI standard %s: line %d: unterminated #%s %s: option '%c%s' doesn't allow an argument
 %s: option '%s' is ambiguous; possibilities: %s: option '--%s' doesn't allow an argument
 %s: option '--%s' requires an argument
 %s: option '-W %s' doesn't allow an argument
 %s: option '-W %s' is ambiguous
 %s: option '-W %s' requires an argument
 %s: option requires an argument -- '%c'
 %s: unrecognized option '%c%s'
 %s: unrecognized option '--%s'
 ' (C) General help using GNU software: <http://www.gnu.org/gethelp/>
 Packaged by %s
 Packaged by %s (%s)
 Report %s bugs to: %s
 Unknown system error Usage: %s [FILE]
  or:  %s -c [OPTION] [FILE]...
 Written by %s and %s.
 Written by %s, %s, %s,
%s, %s, %s, %s,
%s, %s, and others.
 Written by %s, %s, %s,
%s, %s, %s, %s,
%s, and %s.
 Written by %s, %s, %s,
%s, %s, %s, %s,
and %s.
 Written by %s, %s, %s,
%s, %s, %s, and %s.
 Written by %s, %s, %s,
%s, %s, and %s.
 Written by %s, %s, %s,
%s, and %s.
 Written by %s, %s, %s,
and %s.
 Written by %s, %s, and %s.
 Written by %s.
 ` invalid %s%s argument '%s' invalid maximum string length %s invalid suffix in %s%s argument '%s' memory exhausted to standard output.  The number of spaces between the `#' and the following
directive must correspond to the level of nesting of that directive.
With no FILE, or when FILE is -, read standard input.
 too many arguments write error Project-Id-Version: GNU cppi 1.17
Report-Msgid-Bugs-To: bug-cppi@gnu.org
POT-Creation-Date: 2013-03-16 12:06-0700
PO-Revision-Date: 2012-08-08 21:23+0200
Last-Translator: Frédéric Marchal <fmarchal@perso.be>
Language-Team: French <traduc@traduc.org>
Language: fr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms:  nplurals=2; plural=(n > 1);
X-Generator: Lokalize 1.4
 
  -a, --ansi             durant la vérification, échoue si du texte suit #else ou #endif
  -c, --check            retourne un code d'erreur mais ne produit pas de sortie
  -l, --list-files-only  ne retourne pas de diagnostique à propos de l'indentation;
                         affiche uniquement sur stdout les noms des fichiers qui
                         ne sont pas correctement indentés
 
Une directive pragma peut avoir sont « # » indenté.
 
Indente les directives du préprocesseur C dans FICHIER pour refléter leur
imbrication et assure qu'il y a exactement une espace entre chaque #if,
#elif, #define et l'élément suivant et écrit le résultat
 
Licence GPLv3+: GNU GPL version 3 ou ultérieure <http://gnu.org/licenses/gpl.html>.
Ceci est un logiciel libre : vous êtes libre de le modifier et de le redistribuer.
Il n'y a PAS de GARANTIE, dans les limites permises par la loi.

 
NOTE : votre shell peut avoir sa propre version de %s, qui prend habituellement
le pas sur la version décrite ici. Voyez la documentation de votre shell
pour plus de détails à propos des options supportées.
 
Notez que --ansi sans --check ne corrige pas le problème des
textes non-ANSI qui suivent #else et #endif.
 
Signalez les erreurs à <%s>.
 
Signalez les erreurs à : %s
 
Le code de retour peut être une de ces valeurs:
  0  toutes les directives sont correctement indentées
  1  quelques directives cpp ne sont pas correctement indentées, ou
     du texte suit #else/#endif (activé avec --check --ansi), ou
     on a trouvé une chaîne entre guillemets plus longue que
     le maximum spécifié
  2  #if/#endif non appariés, fin de fichier dans un commentaire
     ou une chaîne de caractères
  3  erreur de fichier (par exemple ouverture/lecture/écriture)
 
Avec l'option -c, aucune sortie n'est envoyée sur stdout. À la place,
on vérifie l'indentation des fichiers pour diagnostiquer les lignes du
préprocesseur qui ne sont pas correctement indentées ou erronées.
       --help     affiche cet aide-mémoire et quitte
       --version  affiche les informations de version et quitte
   -m, --max-string-length=LONGUEUR
                         échoue si il a chaîne entre guillemets plus longue
                         que LONGUEUR; si LONGUEUR est 0 (par défaut),
                         alors il n'y a pas de limite
 Page principale de %s : <%s>
 Page principale de %s : <http://www.gnu.org/software/%s/>
 paramètre de %s%s « %s » trop grand %s: option inacceptable -- « %c »
 %s: ligne %d: fin de fichier dans un commentaire %s: ligne %d: fin de fichier dans une chaîne %s: ligne %d: rencontre #%s sans #if correspondant %s: ligne %d: pas correctement formaté;
il doit y avoir exactement une ESPACE après chaque
directive #if, #elif et #define %s: ligne %d: pas correctement indenté %s: ligne %d: chaîne (%lu) plus longue que le maximum à %lu %s: ligne %d: le texte qui suit «#%s» enfreint le standard ANSI %s: ligne %d: #%s pas terminé %s: l'option « %c%s » n'accepte pas de paramètre
 %s: l'option « %s » est ambiguë; les possibilités sont: %s: l'option « --%s » n'accepte pas de paramètre
 %s: l'option « --%s » exige un paramètre
 %s: l'option « -W %s » n'accepte pas de paramètre
 %s: l'option « -W %s » est ambiguë
 %s: l'option « -W %s » exige un paramètre
 %s: l'option exige un paramètre -- « %c »
 %s: option « %c%s » non reconnue
 %s: option « --%s » non reconnue
  » (C) Aide générale sur l'utilisation de logiciels GNU : <http://www.gnu.org/gethelp/>
 Empaqueté par %s
 Empaqueté par %s (%s)
 Signalez les erreurs de %s à : %s
 erreur système inconnue Usage: %s [FICHIER]
  ou : %s -c [OPTION] [FICHIER]...
 Écrit par %s et %s.
 Écrit par %s, %s, %s,
%s, %s, %s, %s,
%s, %s et d'autres.
 Écrit par %s, %s, %s,
%s, %s, %s, %s,
%s et %s.
 Écrit par %s, %s, %s,
%s, %s, %s, %s
et %s.
 Écrit par %s, %s, %s,
%s, %s, %s et %s.
 Écrit par %s, %s, %s,
%s, %s et %s.
 Écrit par %s, %s, %s,
%s et %s.
 Écrit par %s, %s, %s
et %s.
 Écrit par %s, %s et %s.
 Écrit par %s.
 «  paramètre %s%s inacceptable « %s » longueur maximum d'une chaîne inacceptable : %s suffixe inacceptable dans le paramètre %s%s « %s » pas assez de mémoire sur la sortie standard. Le nombre d'espaces entre le « # » et la directive
qui le suit doit correspondre au niveau d'imbrication de la directive.
Sans FICHIER, ou quand FICHIER est -, lit l'entrée standard.
 Trop de paramètres erreur d'écriture 