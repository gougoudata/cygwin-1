%%
%% This is file `chscite.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% chscite.dtx  (with options: `bibstyle')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2012 by Simon Sigurdhsson <ssimon@student.chalmers.se>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Simon Sigurdhsson.
%% 
%% This work consists of the files chscite.dtx and chscite.ins
%% and the derived filebase chscite.sty.
%% 
%%
%% Copyright (C) 2012 by Simon Sigurdhsson <ssimon@student.chalmers.se>
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Simon Sigurdhsson.
%%
%% This work consists of the files chscite.dtx and chscite.ins
%% and the derived filebase chscite.sty.
%%
ENTRY
  {
    address
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
    URL
    volume
    year
  }
  { field.used }
  { extra.label sort.label list.year }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t f }

FUNCTION {item.check}
{
  't :=
  empty$
  { "empty " t * " in " * cite$ * warning$ }
  { skip$ }
  if$
}

FUNCTION {new.block}
{
  output.state before.all =
  'skip$
  { after.block 'output.state := }
  if$
}

FUNCTION {lastint}
{
  #-1 #1 substring$ chr.to.int$ "0" chr.to.int$ -
}

FUNCTION {format.number.th}
{
  duplicate$ duplicate$
  #1 =
  { pop$ pop$ "\chsWst{}" }
  {
    #2 =
    { pop$ "\chsWnd{}" }
    {
      #3 =
      { "\chsWrd{}" }
      { "\chsWth{}" }
      if$
    }
    if$
  }
  if$
}

FUNCTION {not}
{
  { #0 }
  { #1 }
  if$
}

FUNCTION {and}
{
  'skip$
  { pop$ #0 }
  if$
}

FUNCTION {or}
{
  { pop$ #1 }
  'skip$
  if$
}

FUNCTION {field.or.null}
{
  duplicate$ empty$
  { pop$ "" }
  'skip$
  if$
}

FUNCTION {emphasize}
{
  duplicate$ empty$
  { pop$ "" }
  { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {write.url}
{
  URL empty$
  'skip$
  { " \chsurl{" URL * "}" add.period$ * write$ newline$ }
  if$
}

FUNCTION {fin.entry}
{
  add.period$
  write$
  type$ "misc" =
    'skip$
    'write.url
  if$
  newline$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{
  's :=
  'f :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  #3 numnames >
  {
    { namesleft #0 > }
    {
      s nameptr f format.name$ 't :=
      nameptr #1 >
    {
      namesleft #1 >
      { ", " * t * }
      {
        t "others" =
      { " et~al." * }
      { " \chsWand{}\ " * t * }
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
  { s nameptr f format.name$ " et~al." * }
  if$
}

FUNCTION {format.authors}
{
  author empty$
  { "" }
  { "{vv~}{ll}{, jj}{, f.}" author format.names }
  if$
}

FUNCTION {n.dashify}
{
  't :=
  ""
  { t empty$ not }
  {
    t #1 #1 substring$ "-" =
  {
    t #1 #2 substring$ "--" = not
    {
      "--" *
      t #2 global.max$ substring$ 't :=
    }
    {
      { t #1 #1 substring$ "-" = }
    {
      "-" *
      t #2 global.max$ substring$ 't :=
    }
      while$
    }
    if$
  }
  {
    t #1 #1 substring$ *
    t #2 global.max$ substring$ 't :=
  }
    if$
  }
  while$
}

FUNCTION {format.btitle}
{
  title "." * emphasize
}

FUNCTION {tie.or.space.connect}
{
  duplicate$ text.length$ #3 <
  { "~" }
  { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{
  empty$
  'pop$
  { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.editors}
{
  editor empty$
  { "" }
  { "\chsWeditor{}" "{vv~}{ll}{, jj}{, f.}" editor format.names tie.or.space.connect }
  if$
}

FUNCTION {format.book.editors}
{
  editor empty$
  { "" }
  { "\chsWeditor{}" "{vv~}{ll}{, jj}{, f.}" editor format.names tie.or.space.connect }
  if$
}

FUNCTION {format.edition}
{
  edition edition lastint format.number.th *
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{
  't :=
  #0 'multiresult :=
  {
    multiresult not
    t empty$ not
    and
  }
  {
    t #1 #1 substring$
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
{
  pages empty$
  { "" }
  {
    ","
    pages multi.page.check
  { "\chsPages{}" pages n.dashify tie.or.space.connect }
  { "\chsPage{}" pages tie.or.space.connect }
    if$
    tie.or.space.connect
  }
  if$
}

INTEGERS { len }

FUNCTION {chop.word}
{
  's :=
  'len :=
  s #1 len substring$ =
  { s len #1 + global.max$ substring$ }
  's
  if$
}

INTEGERS { ind tsslen }

STRINGS { tss ret rss istr }

FUNCTION {replace.substring}
{
  'rss :=
  'tss :=
  'istr :=
  "" 'ret :=
  tss text.length$ 'tsslen :=
  #1 'ind :=
  { istr ind tsslen substring$ "" = not }
  {
    istr ind tsslen substring$ tss =
    {
      ret rss * 'ret :=
      ind tsslen + 'ind :=
    }
    {
      ret istr ind #1 substring$ * 'ret :=
      ind #1 + 'ind :=
    }
    if$
  }
  while$
  ret
}

FUNCTION {format.lab.names.abbr}
{
  's :=
  s num.names$ 'numnames :=
  numnames #1 >
  {
    numnames #3 >
  { s #1 "{vv~}{ll}" format.name$ " et~al." * }
  {
    s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
      { s #1 "{vv~}{ll}" format.name$ " et~al." * }
    {
      s #1 "{vv~}{ll}" format.name$ " \chsWand{}\ " *
        s #2 "{vv~}{ll}" format.name$ *
      }
      if$
    }
    if$
  }
  { s #1 "{vv~}{ll}" format.name$ }
  if$
}

FUNCTION {format.lab.names.full}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  { namesleft #0 > }
  {
    s nameptr "{vv~}{ll}" format.name$ 't :=
    nameptr #1 >
  {
    namesleft #1 >
    { ", " * t * }
    {
      t "others" =
    { " et~al." * }
    { " \chsWand{}\ " * t * }
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

INTEGERS { author.field editor.field organization.field title.field key.field }

FUNCTION {init.field.constants}
{
  #0 'author.field :=
  #1 'editor.field :=
  #2 'organization.field :=
  #3 'title.field :=
  #4 'key.field :=
}

FUNCTION {make.list.label}
{
  author.field field.used =
  { format.authors }
  {
    editor.field field.used =
    { format.editors }
    {
      organization.field field.used =
      { "The " #4 organization chop.word #3 text.prefix$ }
      {
        title.field field.used =
        { format.btitle }
        {
          key.field field.used =
          { key #3 text.prefix$ }
          { "Internal error :001 on " cite$ * " label" * warning$ }
          if$
        }
        if$
      }
      if$
    }
    if$
  }
  if$
}

FUNCTION {make.full.label}
{
  author.field field.used =
  { author format.lab.names.full }
  {
    editor.field field.used =
    { editor format.lab.names.full }
    {
      organization.field field.used =
      { "The " #4 organization chop.word #3 text.prefix$ }
      {
        title.field field.used =
        { format.btitle }
        {
          key.field field.used =
          { key #3 text.prefix$ }
          { "Internal error :001 on " cite$ * " label" * warning$ }
          if$
        }
        if$
      }
      if$
    }
    if$
  }
  if$
}

FUNCTION {make.abbr.label}
{
author.field field.used =
{ author format.lab.names.abbr }
{
  editor.field field.used =
  { editor format.lab.names.abbr }
  {
    organization.field field.used =
    { "The " #4 organization chop.word #3 text.prefix$ }
    {
      title.field field.used =
      { format.btitle }
      {
        key.field field.used =
        { key #3 text.prefix$ }
        { "Internal error :001 on " cite$ * " label" * warning$ }
        if$
      }
      if$
    }
    if$
  }
  if$
}
if$
}

FUNCTION {output.bibitem}
{
  newline$
  "\chsitem{" write$
  make.abbr.label write$
  "}{" write$
  list.year write$
  "}{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {journal.or.series}
{
  journal missing$
{ series }
{ journal }
if$
}

FUNCTION {publisher.or.school}
{
  publisher missing$
{ school }
{ publisher }
if$
}

%% STYLES
FUNCTION {article}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
  title missing$
    'skip$
    { title tie.or.space.connect }
  if$
type$ "inproceedings" =
type$ "conference" =
or not
month missing$
or
'skip$
{ ";" month year tie.or.space.connect tie.or.space.connect }
if$
journal missing$
'skip$
{ add.period$ journal.or.series emphasize tie.or.space.connect
  volume missing$
{ cite$ " has journal/series with no volume!" * warning$ }
{ "," "\chsVolume{}" tie.or.space.connect volume tie.or.space.connect * }
if$
  number missing$
'skip$
{ "," "\chsNumero{}" number tie.or.space.connect tie.or.space.connect * }
if$
}
if$
pages missing$
'skip$
{ format.pages * }
if$
add.period$ *

  fin.entry
}

FUNCTION {book}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
chapter missing$
'skip$
{ chapter add.period$ "\chsWin{}" tie.or.space.connect tie.or.space.connect }
if$
  title missing$
    'skip$
    { title emphasize tie.or.space.connect }
  if$
editor missing$
'skip$
{ "," format.book.editors tie.or.space.connect }
if$
pages missing$
journal missing$
not or
'skip$
{ format.pages * }
if$
add.period$
  edition missing$
'skip$
{ edition empty$
'skip$
{ format.edition "\chsEdition{}" add.period$ tie.or.space.connect tie.or.space.connect }
if$
}
if$
URL missing$
  'skip$
  { "[\chsWelectronic]" tie.or.space.connect }
if$
  publisher missing$
school missing$
and
'skip$
{ address missing$
{ cite$ " has publisher with no address!" * warning$ }
{ address ":" * publisher.or.school tie.or.space.connect add.period$ tie.or.space.connect }
if$
}
if$
series missing$
journal missing$
and
'skip$
{ volume missing$
{ cite$ " has journal/series with no volume!" * warning$ }
{ "(" journal.or.series ":" * * volume tie.or.space.connect
series missing$
'skip$
{ format.pages * }
if$
")" add.period$ * tie.or.space.connect * }
if$
}
if$

type$ "mastersthesis" =
type$ "phdthesis" =
or
'skip$
  { write$ fin.entry }
if$
}

FUNCTION {booklet} { book }

FUNCTION {inbook} { book }

FUNCTION {incollection} { book }

FUNCTION {inproceedings}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
booktitle missing$
{ title emphasize tie.or.space.connect }
{ title add.period$ "\chsWin{}" tie.or.space.connect booktitle emphasize tie.or.space.connect tie.or.space.connect }
if$
month missing$
'skip$
{ booktitle missing$
{ add.period$ }
{ ";" * }
if$
month "~" year * * tie.or.space.connect
}
if$
address missing$
'skip$
{ "," address tie.or.space.connect add.period$ * }
if$
pages missing$
'skip$
{ format.pages add.period$ tie.or.space.connect }
if$
write$

  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ cite$ ": @manual cite style not implemented!" * warning$ }

FUNCTION {mastersthesis}
{ book
"(\chsWmscthesis{}" tie.or.space.connect
note missing$
'skip$
{ "\chsWinstitution{}" note tie.or.space.connect tie.or.space.connect }
if$
")" add.period$ * write$
fin.entry
}

FUNCTION {phdthesis}
{ book
"(\chsWphdthesis{}" tie.or.space.connect
note missing$
'skip$
{ "\chsWinstitution{}" note tie.or.space.connect tie.or.space.connect }
if$
")" add.period$ * write$
fin.entry
}

FUNCTION {proceedings} { inproceedings }

FUNCTION {unpublished}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
chapter missing$
'skip$
{ chapter add.period$ "\chsWin{}" tie.or.space.connect tie.or.space.connect tie.or.space.connect }
if$
  title missing$
    'skip$
    { title emphasize tie.or.space.connect }
  if$
editor missing$
'skip$
{ "," format.book.editors tie.or.space.connect * }
if$
pages missing$
journal missing$
not or
'skip$
{ format.pages * }
if$
add.period$
URL missing$
  { "\chsWprinting{}" tie.or.space.connect add.period$ }
  { "[\chsWelectronic]" tie.or.space.connect }
if$
  publisher missing$
'skip$
{ address missing$
{ cite$ " has publisher with no address!" * warning$ }
{ address ":" * publisher.or.school tie.or.space.connect add.period$ tie.or.space.connect }
if$
}
if$
write$

  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
  title missing$
    'skip$
    { title tie.or.space.connect add.period$ }
  if$
  howpublished missing$
    'skip$
    { howpublished emphasize tie.or.space.connect add.period$ }
  if$
  URL missing$
    'skip$
    { " \chsurl{" URL "}" * * tie.or.space.connect add.period$ }
  if$
  note missing$
    'skip$
    { "(" note ")" * * tie.or.space.connect add.period$ }
  if$
  write$
  fin.entry
}

FUNCTION {techreport}
{ cite$ ": @techreport cite style not implemented!" * warning$ }

FUNCTION {patent}
{ output.bibitem
  make.list.label "(" tie.or.space.connect list.year * ")" *
  author "author" item.check
    title missing$
      'skip$
      { title emphasize tie.or.space.connect add.period$ }
    if$
    number missing$
      'skip$
      { number tie.or.space.connect add.period$ }
    if$
  write$
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"\chsWjanuary{}"}
MACRO {feb} {"\chsWfebruary{}"}
MACRO {mar} {"\chsWmarch{}"}
MACRO {apr} {"\chsWapril{}"}
MACRO {may} {"\chsWmay{}"}
MACRO {jun} {"\chsWjune{}"}
MACRO {jul} {"\chsWjuly{}"}
MACRO {aug} {"\chsWaugust{}"}
MACRO {sep} {"\chsWseptember{}"}
MACRO {oct} {"\chsWoctober{}"}
MACRO {nov} {"\chsWnovember{}"}
MACRO {dec} {"\chsWdecember{}"}

MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad} {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
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

EXECUTE {init.field.constants}

FUNCTION {sortify}
{
  purify$
  "l" change.case$
}

FUNCTION {sortify.names}
{
  " \chsWand{}\ " " " replace.substring
  " et~al." " zzz" replace.substring
  sortify
}

FUNCTION {author.key.label}
{
  author empty$
  {
    key empty$
  { title.field 'field.used := }
  { key.field 'field.used := }
    if$
  }
  { author.field 'field.used := }
  if$
}

FUNCTION {author.editor.key.label}
{
  author empty$
  {
    editor empty$
  {
    key empty$
    { title.field 'field.used := }
    { key.field 'field.used := }
    if$
   }
  { editor.field 'field.used := }
    if$
  }
  { author.field 'field.used := }
  if$
}

FUNCTION {author.key.organization.label}
{
  author empty$
  {
    key empty$
  {
    organization empty$
    { title.field 'field.used := }
    { organization.field 'field.used := }
    if$
  }
  { key.field 'field.used := }
    if$
  }
  { author.field 'field.used := }
  if$
}

FUNCTION {editor.key.organization.label}
{
  editor empty$
  {
    key empty$
  {
    organization empty$
    { title.field 'field.used := }
    { organization.field 'field.used := }
    if$
  }
  { key.field 'field.used := }
    if$
  }
  { editor.field 'field.used := }
  if$
}

FUNCTION {sort.format.title}
{
  't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {calc.label}
{
  make.abbr.label
  title.field field.used =
  { sort.format.title }
  { sortify.names }
  if$
  year field.or.null purify$ #-1 #4 substring$ sortify *
  'sort.label :=
}

FUNCTION {preliminaries}
{
  type$ "book" =
  type$ "inbook" =
  or
  'author.editor.key.label
  {
    type$ "proceedings" =
  'editor.key.organization.label
  {
    type$ "manual" =
    'author.key.organization.label
    'author.key.label
    if$
  }
    if$
  }
  if$
}

FUNCTION {first.presort}
{
  calc.label
  sort.label
  title.field field.used =
  { skip$ }
  { "    " * make.list.label sortify.names * "    " * title field.or.null sort.format.title * }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {preliminaries}

ITERATE {first.presort}

SORT

STRINGS { last.sort.label next.extra last.full.label }

INTEGERS { last.extra.num }

FUNCTION {initialize.confusion}
{
  #0 int.to.chr$ 'last.sort.label :=
  #0 int.to.chr$ 'last.full.label :=
}

FUNCTION {confusion.pass}
{
  last.sort.label sort.label =
  'skip$
  {
    sort.label 'last.sort.label :=
    make.full.label sortify.names 'last.full.label :=
  }
  if$
}

EXECUTE {initialize.confusion}

ITERATE {confusion.pass}

EXECUTE {initialize.confusion}

REVERSE {confusion.pass}

FUNCTION {initialize.last.extra.num}
{
  #0 int.to.chr$ 'last.sort.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{
  last.sort.label sort.label =
  {
    last.extra.num #1 + 'last.extra.num :=
    last.extra.num int.to.chr$ 'extra.label :=
  }
  {
    "a" chr.to.int$ 'last.extra.num :=
    "" 'extra.label :=
    sort.label 'last.sort.label :=
  }
  if$
}

FUNCTION {reverse.pass}
{
  next.extra "b" =
  { "a" 'extra.label := }
  'skip$
  if$
  year empty$
  { "n.d." extra.label * 'list.year := }
  { year extra.label * 'list.year := }
  if$
  extra.label 'next.extra :=
}

ITERATE {first.presort}

SORT

EXECUTE {initialize.last.extra.num}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {second.presort}
{
  make.list.label
  title.field field.used =
  { sort.format.title }
  { sortify.names }
  if$
  "    " * list.year field.or.null sortify * "    " *
  title.field field.used =
  'skip$
  { title field.or.null sort.format.title * }
  if$
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {second.presort}

SORT

FUNCTION {begin.bib}
{
  preamble$ empty$
  'skip$
  {
    "\chspreambledefs{%" write$ newline$
    preamble$ write$ "}" write$ newline$
    "\chspreambletext{%" write$ newline$
    preamble$ write$ "}" write$ newline$
  }
  if$
  "\begin{thebibliography}{xx}" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{
  newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
