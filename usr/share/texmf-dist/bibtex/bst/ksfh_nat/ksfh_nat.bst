%%%
%%%	This ksfh_nat.bst file is for proper format
%%%  for KSFH Munich standard.
%%%
% Copyright 2011, Matthias Bilger
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any 
% later version.
% The latest version of the license is in
%    http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of
% LaTeX version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Matthias Bilger,
% <matthias@bilger.info> 
%
% Version 1.1 2011/12/06
%
%%%

%% Types of entries currently allowed in a BibTeX file:
%%
%% ARTICLE -- An article from a journal or magazine.
%%
%% BOOK -- A book with an explicit publisher.
%%
%% INBOOK -- A part of a book,
%% which may be a chapter (or section or whatever) and/or a range of pages.
%%
%% INCOLLECTION -- A part of a book having its own title.
%%
%% MISC -- Use this type when nothing else fits.
%%


ENTRY
  { 
    abstract
    address
    author
    booktitle
    edition
    editor
    howpublished
    note
    number
    pages
    publisher
    title
    year
  }
  {}
  { label extra.label sort.label short.list }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block = 
        { add.period$ write$
          newline$
          "\newblock " write$
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
FUNCTION {output.nonnull.nostate}
{ 's :=
  output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    'write$
  if$
  s
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
INTEGERS { nameptr namesleft numnames posothers showetal myint }

FUNCTION {format.full.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames #4 >
	  {
	  	s nameptr
		  "{vv~}{ll}" format.name$
			" u.a." *
	  }
	  {
		  	numnames 'namesleft :=
			    { namesleft #0 > }
			    { s nameptr
			      "{vv~}{ll}" format.name$ 't :=
			      nameptr #1 >
			        { namesleft #1 >
			            { " / " * t * }
			            { t "others" =
			                { " u.a. " * }
			                { " / " * t * }
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
	if$
}

FUNCTION {create.bibitem.names }
{
  type$ "misc" =
    { author format.full.names }
    'skip$
  if$

  type$ "article" =
    { author format.full.names }
    'skip$
  if$

  type$ "book" =
    { author format.full.names }
    'skip$
  if$

  type$ "incollection" =
    { author format.full.names }
    'skip$
  if$

}

FUNCTION {format.bibitem.first.name}
{ #1 'nameptr :=
  nameptr
  "{vv~}{ll}" format.name$
  author num.names$ #1 >
    { " u.a." * }
    'skip$
  if$
}

FUNCTION {create.bibitem.first.name}
{
  type$ "misc" =
    { author format.bibitem.first.name }
    'skip$
  if$

  type$ "article" =
    { author format.bibitem.first.name }
    'skip$
  if$

  type$ "book" =
    { author format.bibitem.first.name }
    'skip$
  if$

  type$ "incollection" =
    { author format.bibitem.first.name }
    'skip$
  if$
}

FUNCTION {create.bibitem.year}
{
  year
  "(" swap$ * ")" *
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  create.bibitem.first.name
  write$
  create.bibitem.year
  write$
  create.bibitem.names
  write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
           swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {fin.entry}
{ add.period$
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
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}
FUNCTION {add.colon}
{ duplicate$ empty$
    'skip$
    { ":" * add.blank }
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
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}
FUNCTION {italize}
{ duplicate$ empty$
    { pop$ "" }
    { "\textit{" swap$ * "}" * }
  if$
}
FUNCTION {scaps}
{ duplicate$ empty$
    { pop$ "" }
    { "\textsc{" swap$ * "}" * }
  if$
}
FUNCTION {anglequote}
{ duplicate$ empty$
    { pop$ "" }
    { "<<" swap$ * ">>" * }
  if$
}
FUNCTION {singlequote}
{ duplicate$ empty$
    { pop$ "" }
    { "'{}" swap$ * "'{}" * }
  if$
}
FUNCTION {doublequote}
{ duplicate$ empty$
    { pop$ "" }
    { "``{}" swap$ * "''{}" * }
  if$
}
FUNCTION {format.names.author}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{ll{ }}{, ff{ }}{ vv }" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #8 >
    { #1 'numnames :=
      #1 'showetal :=
    }
    { numnames #8 =
        { posothers #0 >
          { #1 'showetal :=
            #1 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll{ }}{, ff{ }}{ vv }" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { " / " * t * }
            { showetal #0 >
                { " / " * t * }
                { " / " * t * }
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

  showetal #0 >
    { " u.a." * }
    'skip$
  if$
}

FUNCTION {format.names.editor}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{ll{ }}{, ff{ }}{vv}" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #8 >
    { #1 'numnames :=
      #1 'showetal :=
    }
    { numnames #8 =
        { posothers #0 >
          { #1 'showetal :=
            #1 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll{ }}{, ff{ }}{vv}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { " / " * t * }
            { showetal #0 >
                { ", " * t * }
                { " / " * t * }
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

  showetal #0 >
    { " u.a." * }
    'skip$
  if$
}

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

FUNCTION {format.title.short}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  #1 #3 substring$
}
FUNCTION {format.misc.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.misc.howpublished}
{ howpublished
  "howpublished" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.note}
{ note
  "note" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {misc}
{ output.bibitem
  author empty$
  'skip$
    {         format.misc.author
       output.nonnull.nostate
    }
  if$
  new.block
  year empty$
  'skip$
    {  " ("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.year
       output.nonnull.nostate
       "):"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.misc.title
       output.nonnull.nostate
       newline$ "\newline "
       output.nonnull.nostate
    }
  if$
  new.block
  howpublished empty$
  'skip$
    {         format.misc.howpublished
       output.nonnull.nostate
    }
  if$
  new.block
  note empty$
  'skip$
    {  ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.note
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.article.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.article.booktitle}
{ booktitle
  "booktitle" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.number}
{ number
  "number" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.pages}
{ pages
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {article}
{ output.bibitem
  author empty$
  'skip$
    {         format.article.author
       output.nonnull.nostate
    }
  if$
  new.block
  year empty$
  'skip$
    {  "("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.year
       output.nonnull.nostate
       "): "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.article.title
       output.nonnull.nostate
    }
  if$
  new.block
  booktitle empty$
  'skip$
    {  "In: "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.booktitle
       output.nonnull.nostate
    }
  if$
  new.block
  number empty$
  'skip$
    {  ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.number
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {         format.article.pages
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.book.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.book.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.edition}
{ edition
  "edition" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.pages}
{ pages
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {book}
{ output.bibitem
  author empty$
  'skip$
    {         format.book.author
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {  " ("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.year
       output.nonnull.nostate
       "): "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.book.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.book.address
       output.nonnull.nostate
    }
  if$
  new.block
  publisher empty$
  'skip$
    {  ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.publisher
       output.nonnull.nostate
    }
  if$
  new.block
  edition empty$
  'skip$
    {  ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.edition
       output.nonnull.nostate
       " Auflage"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {  ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.book.pages
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.incollection.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.incollection.editor}
{ editor
  duplicate$ empty$ 'skip$
    { format.names.editor }
  if$
  "editor" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.booktitle}
{ booktitle
  "booktitle" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.incollection.pages}
{ pages
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {incollection}
{ output.bibitem
  author empty$
  'skip$
    {         format.incollection.author
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {  " ("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.incollection.year
       output.nonnull.nostate
       "): "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.incollection.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  editor empty$
  'skip$
    {  "In: "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.incollection.editor
       output.nonnull.nostate
       " (Hg.), "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  booktitle empty$
  'skip$
    {         format.incollection.booktitle
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {  " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.incollection.address
       output.nonnull.nostate
    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.incollection.publisher
       output.nonnull.nostate
    }
  if$
  new.block
  pages empty$
  'skip$
    {  ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.incollection.pages
       output.nonnull.nostate
    }
  if$
  new.block
  fin.entry
}
READ
INTEGERS { et.al.char.used }

FUNCTION {initialize.et.al.char.used}
{ #0 'et.al.char.used :=
}

EXECUTE {initialize.et.al.char.used}

FUNCTION {format.lab.names}
{ 's :=
  s num.names$ 'numnames :=
  numnames #1 >
    { numnames #8 >
        { #7 'namesleft := }
        { numnames 'namesleft := }
      if$
      #1 'nameptr :=
      ""
        { namesleft #0 > }
        { nameptr numnames =
            { s nameptr "{ff }{vv }{ll}{ jj}" format.name$ "others" =
                { "{\etalchar{+}}" *
                  #1 'et.al.char.used :=
                }
                { s nameptr "{vv{}}{ll{}}" format.name$ * }
              if$
            }
            { s nameptr "{vv{}}{ll{}}" format.name$ * }
          if$
          nameptr #1 + 'nameptr :=
          namesleft #1 - 'namesleft :=
        }
      while$
      numnames #4 >
        { "{\etalchar{+}}" *
          #1 'et.al.char.used :=
        }
        'skip$
      if$
    }
    { s #1 "{vv{}}{ll{}}" format.name$
      duplicate$ text.length$ #2 <
        { pop$ s #1 "{ll}" format.name$ #3 text.prefix$ }
        'skip$
      if$
    }
  if$
}
FUNCTION {author.year.label}
{ author empty$
    { year empty$
        {cite$ #1 #3 substring$ }
        {year format.title.short }
      if$
    }
    { author format.lab.names }
  if$
  duplicate$
	" " author " " sort.label * * * * warning$
}
FUNCTION {calc.label}
{  type$ "misc" =
     'author.year.label 
    'skip$
  if$
  type$ "book" =
     'author.year.label 
    'skip$
  if$
  type$ "incollection" =
     'author.year.label 
    'skip$
  if$
  duplicate$
  year field.or.null purify$ #-1 #2 substring$
  *
  'label :=
  year field.or.null purify$ #1 #4 substring$
  *
  sortify 'sort.label :=
  " " sort.label * warning$
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
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "u.a." *}
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
FUNCTION {author.year.sort}
{ author empty$
    { year empty$
        { "to sort, need author, oryear in " cite$ * warning$
  ""
}
        {year format.title.short sortify }      if$
    }
    { author sort.format.names }
  if$
}
FUNCTION {presort}
{ calc.label
  sort.label
  "    "
  *
  type$ "misc" =
    'author.year.sort
    'skip$
  if$
  type$ "book" =
    'author.year.sort
    'skip$
  if$
  type$ "incollection" =
    'author.year.sort
    'skip$
  if$
  *
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

ITERATE {presort}

SORT

STRINGS { longest.label last.label next.extra }

INTEGERS { longest.label.width last.extra.num number.label }

FUNCTION { initialize.longest.label }
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ et.al.char.used
    { "\newcommand{\etalchar}[1]{$^{#1}$}" write$ newline$ }
    'skip$
  if$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  number.label int.to.str$  * "}" * write$ newline$
  "\providecommand{\natexlab}[1]{#1}" write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}EXECUTE {end.bib}