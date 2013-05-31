%%
%% DO NOT EDIT
%%
%% This is plainhtmldate.bst, edited from plainhtml.bst by plainhtmldate.sed
%%
%% plainhtml.bst
%%
%% Part of bibhtml, version 2.0.1, released 2009 November 2
%% Hg node 6ca3807543d6.
%% See <http://purl.org/nxg/dist/bibhtml>
%%
%% Copyright 1999, 2005, 2006, 2009, Norman Gray <norman@astro.gla.ac.uk>
%%
%% This is a modification of a modification!
%%
%%% Modification of BibTeX style file /usr/local/texlive/2008/texmf-dist/bibtex/bst/base/plain.bst
%%% ... by urlbst, version 0.6-4 (marked with "% urlbst")
%%% See <http://purl.org/nxg/dist/urlbst>
%%% Added webpage entry type, and url and lastchecked fields.
%%% Added eprint support.
%%% Added DOI support.
%%% Added PUBMED support.
%%% Added hyperref support.
%%% Original headers follow...
ENTRY
{ address
author
booktitle
chapter
edition
editor
howpublished
institution
journal
key
month
note
number
organization
pages
publisher
school
series
title
type
volume
year
eprint % urlbst
doi % urlbst
pubmed % urlbst
url % urlbst
lastchecked % urlbst
}
{}
{ label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block doiform }
STRINGS { urlintro eprinturl eprintprefix doiprefix doiurl pubmedprefix pubmedurl openinlinelink closeinlinelink } % urlbst...
INTEGERS { inlinelinks makeinlinelink addeprints adddoiresolver addpubmedresolver }
FUNCTION {init.urlbst.variables}
{
"Available from: " 'urlintro := % prefix before URL
"http://arxiv.org/abs/" 'eprinturl := % prefix to make URL from eprint ref
"arXiv:" 'eprintprefix := % text prefix printed before eprint ref
"http://dx.doi.org/" 'doiurl := % prefix to make URL from DOI
"doi:" 'doiprefix :=      % text prefix printed before DOI ref
"http://www.ncbi.nlm.nih.gov/pubmed/" 'pubmedurl := % prefix to make URL from PUBMED
"PMID:" 'pubmedprefix :=      % text prefix printed before PUBMED ref
#1 'addeprints :=         % 0=no eprints; 1=include eprints
#1 'adddoiresolver :=     % 0=no DOI resolver; 1=include it
#1 'addpubmedresolver :=     % 0=no PUBMED resolver; 1=include it
#1 'inlinelinks :=        % 0=URLs explicit; 1=URLs attached to titles
#1 'doiform :=            % 0=simple, but can produce invalid HTML; 1=needs post-processing
#0 'makeinlinelink :=     % state variable managed by possibly.setup.inlinelink
"" 'openinlinelink :=     % ditto
"" 'closeinlinelink :=    % ditto
}
INTEGERS { 
bracket.state
outside.brackets
open.brackets
within.brackets
close.brackets
close.first.block
}
FUNCTION {init.state.consts}
{ #0 'outside.brackets := % urlbst
#1 'open.brackets :=
#2 'within.brackets :=
#3 'close.brackets :=
#0 'before.all :=
#1 'mid.sentence :=
#2 'after.sentence :=
#3 'after.block :=
#0 'close.first.block :=
}
STRINGS { s t }
FUNCTION {output.nonnull.original}
{ 's :=
output.state mid.sentence =
{ ", " * write$ }
{ output.state after.block =
{ add.period$ write$
close.first.block
{ "</a></dt>" write$ newline$ "<dd>" write$
#0 'close.first.block := }
{ newline$ }
if$
}
{ output.state before.all =
'write$
{ add.period$ " " * write$ }
if$
}
if$
mid.sentence 'output.state :=
}
if$
s
}
FUNCTION {possibly.setup.inlinelink}
{ makeinlinelink
{ "<a href=" quote$ * url * quote$ * ">" * 'openinlinelink :=
"</a>" 'closeinlinelink :=
#0 'makeinlinelink := }
'skip$
if$ % makeinlinelink
}
FUNCTION {add.inlinelink}
{ openinlinelink empty$
'skip$
{ openinlinelink swap$ * closeinlinelink *
"" 'openinlinelink :=
}
if$
}
FUNCTION {output.nonnull}
{ % Save the thing we've been asked to output
's :=
bracket.state close.brackets =
{ "]" *
outside.brackets 'bracket.state :=
}
'skip$
if$
bracket.state outside.brackets =
{ % We're outside all brackets -- this is the normal situation.
s
add.inlinelink
output.nonnull.original % invoke the original output.nonnull
}
{ % Still in brackets.  Add open-bracket or (continuation) comma, add the
bracket.state open.brackets =
{ " [" * }
{ ", " * } % bracket.state will be within.brackets
if$ 
s * 
close.brackets 'bracket.state :=
}
if$
}
FUNCTION {inbrackets}
{ bracket.state close.brackets =
{ within.brackets 'bracket.state := } % reset the state: not open nor closed
{ open.brackets 'bracket.state := }
if$
}
FUNCTION {format.lastchecked}
{ lastchecked empty$
{ "" }
{ inbrackets "cited " lastchecked * }
if$
}
FUNCTION {output}
{ duplicate$ empty$
'pop$
'output.nonnull
if$
}
FUNCTION {output.check}
{ 't :=
duplicate$ empty$
{ pop$ "empty " t * " in " * cite$ * warning$ }
'output.nonnull
if$
}
FUNCTION {output.bibitem.original}
{ newline$
"<dt><a name='" write$
cite$ write$
"'>[" cite$ * "] " * write$
#1 'close.first.block :=
newline$
""
before.all 'output.state :=
}
FUNCTION {fin.entry.original}
{ add.period$ "</dd>" *
write$
newline$
}
FUNCTION {new.block}
{ output.state before.all =
'skip$
{ after.block 'output.state := }
if$
}
FUNCTION {new.sentence}
{ output.state after.block =
'skip$
{ output.state before.all =
'skip$
{ after.sentence 'output.state := }
if$
}
if$
}
FUNCTION {not}
{   { #0 }
{ #1 }
if$
}
FUNCTION {and}
{   'skip$
{ pop$ #0 }
if$
}
FUNCTION {or}
{   { pop$ #1 }
'skip$
if$
}
FUNCTION {new.block.checka}
{ empty$
'skip$
'new.block
if$
}
FUNCTION {new.block.checkb}
{ empty$
swap$ empty$
and
'skip$
'new.block
if$
}
FUNCTION {new.sentence.checka}
{ empty$
'skip$
'new.sentence
if$
}
FUNCTION {new.sentence.checkb}
{ empty$
swap$ empty$
and
'skip$
'new.sentence
if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
{ pop$ "" }
'skip$
if$
}
FUNCTION {emphasize}
{ duplicate$ empty$
{ pop$ "" }
{ "<em>" swap$ * "</em>" * }
if$
}
INTEGERS { nameptr namesleft numnames }
FUNCTION {format.names}
{ 's :=
#1 'nameptr :=
s num.names$ 'numnames :=
numnames 'namesleft :=
{ namesleft #0 > }
{ s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
nameptr #1 >
{ namesleft #1 >
{ ", " * t * }
{ numnames #2 >
{ "," * }
'skip$
if$
t "others" =
{ " et~al." * }
{ " and " * t * }
if$
}
if$
}
't
if$
nameptr #1 + 'nameptr :=
namesleft #1 - 'namesleft :=
}
while$
}
FUNCTION {format.authors}
{ author empty$
{ "" }
{ author format.names }
if$
}
FUNCTION {format.editors}
{ editor empty$
{ "" }
{ editor format.names
editor num.names$ #1 >
{ ", editors" * }
{ ", editor" * }
if$
}
if$
}
FUNCTION {format.title}
{ title empty$
{ "" }
{ title "t" change.case$ }
if$
}
FUNCTION {n.dashify}
{ 't :=
""
{ t empty$ not }
{ t #1 #1 substring$ "-" =
{ t #1 #2 substring$ "--" = not
{ "--" *
t #2 global.max$ substring$ 't :=
}
{   { t #1 #1 substring$ "-" = }
{ "-" *
t #2 global.max$ substring$ 't :=
}
while$
}
if$
}
{ t #1 #1 substring$ *
t #2 global.max$ substring$ 't :=
}
if$
}
while$
}
FUNCTION {format.date}
{ year empty$
{ month empty$
{ "" }
{ "there's a month but no year in " cite$ * warning$
month
}
if$
}
{ month empty$
'year
{ month " " * year * }
if$
}
if$
}
FUNCTION {format.btitle}
{ title emphasize
}
FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
{ "~" }
{ " " }
if$
swap$ * *
}
FUNCTION {either.or.check}
{ empty$
'pop$
{ "can't use both " swap$ * " fields in " * cite$ * warning$ }
if$
}
FUNCTION {format.bvolume}
{ volume empty$
{ "" }
{ "volume" volume tie.or.space.connect
series empty$
'skip$
{ " of " * series emphasize * }
if$
"volume and number" number either.or.check
}
if$
}
FUNCTION {format.number.series}
{ volume empty$
{ number empty$
{ series field.or.null }
{ output.state mid.sentence =
{ "number" }
{ "Number" }
if$
number tie.or.space.connect
series empty$
{ "there's a number but no series in " cite$ * warning$ }
{ " in " * series * }
if$
}
if$
}
{ "" }
if$
}
FUNCTION {format.edition}
{ edition empty$
{ "" }
{ output.state mid.sentence =
{ edition "l" change.case$ " edition" * }
{ edition "t" change.case$ " edition" * }
if$
}
if$
}
INTEGERS { multiresult }
FUNCTION {multi.page.check}
{ 't :=
#0 'multiresult :=
{ multiresult not
t empty$ not
and
}
{ t #1 #1 substring$
duplicate$ "-" =
swap$ duplicate$ "," =
swap$ "+" =
or or
{ #1 'multiresult := }
{ t #2 global.max$ substring$ 't := }
if$
}
while$
multiresult
}
FUNCTION {format.pages}
{ pages empty$
{ "" }
{ pages multi.page.check
{ "pages" pages n.dashify tie.or.space.connect }
{ "page" pages tie.or.space.connect }
if$
}
if$
}
FUNCTION {format.vol.num.pages}
{ volume field.or.null
number empty$
'skip$
{ "(" number * ")" * *
volume empty$
{ "there's a number but no volume in " cite$ * warning$ }
'skip$
if$
}
if$
pages empty$
'skip$
{ duplicate$ empty$
{ pop$ format.pages }
{ ":" * pages n.dashify * }
if$
}
if$
}
FUNCTION {format.chapter.pages}
{ chapter empty$
'format.pages
{ type empty$
{ "chapter" }
{ type "l" change.case$ }
if$
chapter tie.or.space.connect
pages empty$
'skip$
{ ", " * format.pages * }
if$
}
if$
}
FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
{ "" }
{ editor empty$
{ "In " booktitle emphasize * }
{ "In " format.editors * ", " * booktitle emphasize * }
if$
}
if$
}
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
month empty$ year empty$ note empty$
and and and and and
key empty$ not and
{ "all relevant fields are empty in " cite$ * warning$ }
'skip$
if$
}
FUNCTION {format.thesis.type}
{ type empty$
'skip$
{ pop$
type "t" change.case$
}
if$
}
FUNCTION {format.tr.number}
{ type empty$
{ "Technical Report" }
'type
if$
number empty$
{ "t" change.case$ }
{ number tie.or.space.connect }
if$
}
FUNCTION {format.article.crossref}
{ key empty$
{ journal empty$
{ "need key or journal for " cite$ * " to crossref " * crossref *
warning$
""
}
{ "In <em>" journal * "</em>" * }
if$
}
{ "In " key * }
if$
" <span class='cite'>" * crossref * "</span>" *
}
FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
editor num.names$ duplicate$
#2 >
{ pop$ " et~al." * }
{ #2 <
'skip$
{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
{ " et~al." * }
{ " and " * editor #2 "{vv~}{ll}" format.name$ * }
if$
}
if$
}
if$
}
FUNCTION {format.book.crossref}
{ volume empty$
{ "empty volume in " cite$ * "'s crossref of " * crossref * warning$
"In "
}
{ "Volume" volume tie.or.space.connect
" of " *
}
if$
editor empty$
editor field.or.null author field.or.null =
or
{ key empty$
{ series empty$
{ "need editor, key, or series for " cite$ * " to crossref " *
crossref * warning$
"" *
}
{ "<em>" * series * "</em>" * }
if$
}
{ key * }
if$
}
{ format.crossref.editor * }
if$
" <span class='cite'>" * crossref * "</span>" *
}
FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
editor field.or.null author field.or.null =
or
{ key empty$
{ booktitle empty$
{ "need editor, key, or booktitle for " cite$ * " to crossref " *
crossref * warning$
""
}
{ "In <em>" booktitle * "</em>" * }
if$
}
{ "In " key * }
if$
}
{ "In " format.crossref.editor * }
if$
" <span class='cite'>" * crossref * "</span>" *
}
FUNCTION {make.href}
{ 
"<a href='" swap$ * "'><code>" * swap$ * "</code></a>" *
}
FUNCTION {format.url}
{ inlinelinks #1 = url empty$ or
{ "" }
{ urlintro "<code>" * url * "</code>" * }
if$
}
FUNCTION {format.eprint}
{ eprint empty$
{ "" }
{ eprintprefix eprint * eprinturl eprint * make.href }
if$
}
FUNCTION {format.doi}
{ doi empty$
{ "" }
{ doiform #0 =
{ doiprefix doi * doiurl doi * make.href }
{ "DOI:{" doi * "}" * }
if$
}
if$
}
FUNCTION {format.pubmed}
{ pubmed empty$
{ "" }
{ pubmedprefix pubmed * pubmedurl pubmed * make.href }
if$
}
FUNCTION {output.url}
{ url empty$
'skip$ 
{ new.block 
format.url output
format.lastchecked output 
}
if$
}
FUNCTION {output.web.refs}
{
new.block
output.url
addeprints eprint empty$ not and
{ format.eprint output.nonnull }
'skip$
if$
adddoiresolver doi empty$ not and
{ format.doi output.nonnull }
'skip$
if$
addpubmedresolver pubmed empty$ not and
{ format.pubmed output.nonnull }
'skip$
if$
}
FUNCTION {output.bibitem}
{ outside.brackets 'bracket.state :=
output.bibitem.original
inlinelinks url empty$ not and
{ #1 'makeinlinelink := }
{ #0 'makeinlinelink := }
if$
}
FUNCTION {fin.entry}
{ output.web.refs  % urlbst
makeinlinelink       % ooops, it appears we didn't have a title for inlinelink
{ possibly.setup.inlinelink % add some artificial link text here, as a fallback
"[link]" output.nonnull }
'skip$
if$
bracket.state close.brackets = % urlbst
{ "]" * }
'skip$
if$
fin.entry.original
}
FUNCTION {webpage}
{ output.bibitem
author empty$
{ editor empty$
'skip$  % author and editor both optional
{ format.editors output.nonnull }
if$
}
{ editor empty$
{ format.authors output.nonnull }
{ "can't use both author and editor fields in " cite$ * warning$ }
if$
}
if$
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$
format.title "title" output.check
inbrackets "online" output
new.block
year empty$
'skip$
{ format.date "year" output.check }
if$
new.block
note output
fin.entry
}
FUNCTION {article}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
crossref missing$
{ journal emphasize "journal" output.check
possibly.setup.inlinelink format.vol.num.pages output% urlbst
format.date "year" output.check
}
{ format.article.crossref output.nonnull
format.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {book}
{ output.bibitem
author empty$
{ format.editors "author and editor" output.check }
{ format.authors output.nonnull
crossref missing$
{ "author and editor" editor either.or.check }
'skip$
if$
}
if$
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.btitle "title" output.check
crossref missing$
{ format.bvolume output
new.block
format.number.series output
new.sentence
publisher "publisher" output.check
address output
}
{ new.block
format.book.crossref output.nonnull
}
if$
format.edition output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {booklet}
{ output.bibitem
format.authors output
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
howpublished address new.block.checkb
howpublished output
address output
format.date output
new.block
note output
fin.entry
}
FUNCTION {inbook}
{ output.bibitem
author empty$
{ format.editors "author and editor" output.check }
{ format.authors output.nonnull
crossref missing$
{ "author and editor" editor either.or.check }
'skip$
if$
}
if$
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.btitle "title" output.check
crossref missing$
{ format.bvolume output
format.chapter.pages "chapter and pages" output.check
new.block
format.number.series output
new.sentence
publisher "publisher" output.check
address output
}
{ format.chapter.pages "chapter and pages" output.check
new.block
format.book.crossref output.nonnull
}
if$
format.edition output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {incollection}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
crossref missing$
{ format.in.ed.booktitle "booktitle" output.check
format.bvolume output
format.number.series output
format.chapter.pages output
new.sentence
publisher "publisher" output.check
address output
format.edition output
format.date "year" output.check
}
{ format.incoll.inproc.crossref output.nonnull
format.chapter.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
crossref missing$
{ format.in.ed.booktitle "booktitle" output.check
format.bvolume output
format.number.series output
format.pages output
address empty$
{ organization publisher new.sentence.checkb
organization output
publisher output
format.date "year" output.check
}
{ address output.nonnull
format.date "year" output.check
new.sentence
organization output
publisher output
}
if$
}
{ format.incoll.inproc.crossref output.nonnull
format.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
author empty$
{ organization empty$
'skip$
{ organization output.nonnull
address output
}
if$
}
{ format.authors output.nonnull }
if$
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.btitle "title" output.check
author empty$
{ organization empty$
{ address new.block.checka
address output
}
'skip$
if$
}
{ organization address new.block.checkb
organization output
address output
}
if$
format.edition output
format.date output
new.block
note output
fin.entry
}
FUNCTION {mastersthesis}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
"Master's thesis" format.thesis.type output.nonnull
school "school" output.check
address output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {misc}
{ output.bibitem
format.authors output
title howpublished new.block.checkb
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title output
howpublished new.block.checka
howpublished output
format.date output
new.block
note output
fin.entry
empty.misc.check
}
FUNCTION {phdthesis}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.btitle "title" output.check
new.block
"PhD thesis" format.thesis.type output.nonnull
school "school" output.check
address output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {proceedings}
{ output.bibitem
editor empty$
{ organization output }
{ format.editors output.nonnull }
if$
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.btitle "title" output.check
format.bvolume output
format.number.series output
address empty$
{ editor empty$
{ publisher new.sentence.checka }
{ organization publisher new.sentence.checkb
organization output
}
if$
publisher output
format.date "year" output.check
}
{ address output.nonnull
format.date "year" output.check
new.sentence
editor empty$
'skip$
{ organization output }
if$
publisher output
}
if$
new.block
note output
fin.entry
}
FUNCTION {techreport}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
format.tr.number output.nonnull
institution "institution" output.check
address output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {unpublished}
{ output.bibitem
format.authors "author" output.check
new.block
title empty$ 'skip$ 'possibly.setup.inlinelink if$ % urlbst
format.title "title" output.check
new.block
note "note" output.check
format.date output
fin.entry
}
FUNCTION {default.type} { misc }
MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}
MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad}
{"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}
READ
FUNCTION {sortify}
{ purify$
"l" change.case$
}
INTEGERS { len }
FUNCTION {chop.word}
{ 's :=
'len :=
s #1 len substring$ =
{ s len #1 + global.max$ substring$ }
's
if$
}
FUNCTION {sort.format.names}
{ 's :=
#1 'nameptr :=
""
s num.names$ 'numnames :=
numnames 'namesleft :=
{ namesleft #0 > }
{ nameptr #1 >
{ "   " * }
'skip$
if$
s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
nameptr numnames = t "others" = and
{ "et al" * }
{ t sortify * }
if$
nameptr #1 + 'nameptr :=
namesleft #1 - 'namesleft :=
}
while$
}
FUNCTION {sort.format.title}
{ 't :=
"A " #2
"An " #3
"The " #4 t chop.word
chop.word
chop.word
sortify
#1 global.max$ substring$
}
FUNCTION {author.sort}
{ author empty$
{ key empty$
{ "to sort, need author or key in " cite$ * warning$
""
}
{ key sortify }
if$
}
{ author sort.format.names }
if$
}
FUNCTION {author.editor.sort}
{ author empty$
{ editor empty$
{ key empty$
{ "to sort, need author, editor, or key in " cite$ * warning$
""
}
{ key sortify }
if$
}
{ editor sort.format.names }
if$
}
{ author sort.format.names }
if$
}
FUNCTION {author.organization.sort}
{ author empty$
{ organization empty$
{ key empty$
{ "to sort, need author, organization, or key in " cite$ * warning$
""
}
{ key sortify }
if$
}
{ "The " #4 organization chop.word sortify }
if$
}
{ author sort.format.names }
if$
}
FUNCTION {editor.organization.sort}
{ editor empty$
{ organization empty$
{ key empty$
{ "to sort, need editor, organization, or key in " cite$ * warning$
""
}
{ key sortify }
if$
}
{ "The " #4 organization chop.word sortify }
if$
}
{ editor sort.format.names }
if$
}
FUNCTION {presort.by.author}
{ type$ "book" =
type$ "inbook" =
or
'author.editor.sort
{ type$ "proceedings" =
'editor.organization.sort
{ type$ "manual" =
'author.organization.sort
'author.sort
if$
}
if$
}
if$
"    "
*
year field.or.null sortify
*
"    "
*
title field.or.null
sort.format.title
*
#1 entry.max$ substring$
'sort.key$ :=
}
FUNCTION {presort.by.year}
{ year field.or.null sortify
"    "
*
type$ "book" =
type$ "inbook" =
or
'author.editor.sort
{ type$ "proceedings" =
'editor.organization.sort
{ type$ "manual" =
'author.organization.sort
'author.sort
if$
}
if$
}
if$
*
"    "
*
title field.or.null
sort.format.title
*
#1 entry.max$ substring$
'sort.key$ :=
}
ITERATE {presort.by.year}
SORT
STRINGS { longest.label }
INTEGERS { number.label longest.label.width }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
#1 'number.label :=
#0 'longest.label.width :=
}
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
number.label #1 + 'number.label :=
label width$ longest.label.width >
{ label 'longest.label :=
label width$ 'longest.label.width :=
}
'skip$
if$
}
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}
FUNCTION {begin.bib}
{ preamble$ empty$
'skip$
{ preamble$ write$ newline$ }
if$
"<dl>" write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.urlbst.variables}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
"</dl>" write$ newline$
}
EXECUTE {end.bib}
