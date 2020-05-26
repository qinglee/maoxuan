
\NeedsTeXFormat{LaTeX2e}[2016/01/01]
\RequirePackage{expl3}[2020/02/14]
\ProvidesExplClass{maoxuan}{2020/05/26}{0}{Selected Works of Mao Tse-Tung}

\DeclareOption { source-han }
  { \bool_gset_true:N \g_maoxuan_source_han_bool }
\bool_new:N \g_maoxuan_source_han_bool

\DeclareOption * { \PassOptionsToClass { \CurrentOption } { ctexbook } }
\PassOptionsToClass { openany , linespread = 4/3 , fontset = none } { ctexbook }
\ProcessOptions \scan_stop:
\LoadClass { ctexbook } [ 2016/10/25 ]

\raggedbottom
\RequirePackage { geometry }
\skip_set:Nn \topskip { 12pt }
\geometry
  {
    papersize     = { 130mm , 184mm } ,
    lines         = 25 ,
    hmargin       = 15mm ,
    bindingoffset =  5mm ,
    headheight    = 10pt ,
    headsep       = \baselineskip ,
    includehead   = true ,
    vcentering    = true
  }
\PassOptionsToPackage { mainaux } { rerunfilecheck }
\RequirePackage { graphicx }
\RequirePackage { pifont }
\RequirePackage { booktabs , enumitem , titleps }
\RequirePackage { hyperref }
\RequirePackage { bookmark }
\int_set:Nn \tex_clubpenalty:D  { 150 }
\int_set:Nn \tex_widowpenalty:D { 150 }
\tl_const:Nn \c_maoxuan_name_tl { 毛泽东选集 }
\hypersetup
  {
    hidelinks ,
    hypertexnames      = true ,
    naturalnames       = false ,
    bookmarksnumbered  = false ,
    pdfstartview       = XYZ ~ null ~ null ~ 1 ,
    pdfpagemode        = UseNone ,
    pdfpagelayout      = TwoPageRight ,
    pdfprintscaling    = None ,
    pdfdisplaydoctitle = true ,
    pdfinfo            =
      {
        Title   = \c_maoxuan_name_tl ,
        Author  = 毛泽东 ,
        Creator = XeLaTeX ~ + ~ xeCJK ~ + ~ CTeX ,
      } ,
  }
\cs_new_protected_nopar:Npn \maoxuan_hyper_link:nn
  { \hyper@link { link } }
\cs_new_protected:Npn \maoxuan_hyper_anchor:n #1
  { \Hy@raisedlink { \hyper@anchor {#1} } }
\cs_new_protected:Npn \maoxuan_hyper_page:n #1
  { \maoxuan_hyper_link:nn { page.#1 } {#1} }
\xeCJKsetup
  {
    AllowBreakBetweenPuncts = true ,
    CheckSingle             = true ,
    AutoFakeBold            = false ,
    AutoFakeSlant           = false ,
    CheckFullRight          = true ,
    NewLineCS+              = \mxendarticle \item \mnitem
                              \maoxuan_endline_mark: ,
    NoBreakCS+              = \mnote ,
    PunctStyle              = kaiming ,
    KaiMingPunct+           = ：； ,
  }
\bool_if:NTF \g_maoxuan_source_han_bool
  {
    \setmainfont { Source ~ Serif ~ Pro }
    \setsansfont { Source ~ Sans ~ Pro }
    \setmonofont { Source ~ Code ~ Pro }
    \setCJKmainfont
      [BoldFont=Source ~ Han ~ Sans ~ SC ~ Medium]{Source ~ Han ~ Serif ~ SC}
    \setCJKsansfont{Source ~ Han ~ Sans ~ SC}
    \newCJKfontfamily\songti[BoldFont=* ~ Heavy]{Source ~ Han ~ Serif ~ SC}
    \newCJKfontfamily\mingchao{Source ~ Han ~ Serif}
    \NewDocumentCommand \kaishu { } { \normalfont }
    \cs_new_eq:NN \fangsong \kaishu
  }
  {
    \setmainfont { Linux ~ Biolinum ~ O }
    \setCJKmainfont[
           BoldFont=FZYouH_GBK ~ 511M,
         ItalicFont=FZNewKai-Z03]{FZNewShuSong-Z10}
    \setCJKsansfont[BoldFont=FZYouH_GBK ~ 511M]{FZYouH_GBK ~ 508R}
    \setCJKmonofont{FZFangSong-Z02}
    \newCJKfontfamily\songti[BoldFont=FZYaSong-EB-GBK]{FZNewShuSong-Z10}
    \newCJKfontfamily\kaishu      {FZNewKai-Z03}
    \newCJKfontfamily\fangsong    {FZFangSong-Z02}
    \newCJKfontfamily\mingchao    {Hiragino ~ Mincho ~ ProN}
  }
\ctex_patch_cmd:Nnn \cleardoublepage
  { \newpage }
  { \thispagestyle { empty } \newpage }
\NewDocumentCommand \maketitlepage { }
  {
    \cleardoublepage
    \group_begin:
      \pagenumbering { Alph }
      \pagestyle { empty }
      \null \vfill \centering
      \includegraphics [ width = \linewidth ] { maoxuan/mao.pdf }
      \vfill \vskip\topskip
      \clearpage
      \centering
      \vspace * { \stretch { 1 } } \ziju { .3 }
      全世界无产者，联合起来！
      \vspace { \stretch { 2 } }
      \clearpage
    \group_end:
    \pagenumbering { arabic }
  }
\NewDocumentCommand \makevoltitlepage { }
  {
    \cleardoublepage
    \int_set:Nn \l_maoxuan_page_int { \value { page } }
    \group_begin:
      \setcounter { page } { \c_one }
      \tl_gset:Nn \thepage { \Roman { volume } . \Alph { page } }
      \pagestyle { empty }
      \centering
      \vspace * { \stretch { 3 } }
      { \Huge \songti \bfseries \ziju { .5 } \c_maoxuan_name_tl } \par
      \vspace { \stretch { 2 } }
      { \large \ziju { .5 } 第 \chinese { volume } 卷 } \par
      \vspace { \stretch { 10 } }
      \cleardoublepage
    \group_end:
    \pagenumbering { arabic }
    \setcounter { page } { \l_maoxuan_page_int }
  }
\int_new:N \l_maoxuan_page_int
\NewDocumentCommand \mxvolume { m }
  {
    \cleardoublepage
    \setcounter { volume } { \int_eval:n {#1} }
    \tl_set:Nx \l_maoxuan_vol_prefix_tl
      { maoxuan/mx \two@digits { \value { volume } } }
    \maoxuan_vol:o { \l_maoxuan_vol_prefix_tl }
  }
\newcounter { volume }
\cs_new_protected:Npn \maoxuan_vol:n #1
  {
    \addtocontents { toc } { \mxvolumetocbegin {#1} }
    \makevoltitlepage
    \maoxuan_volume_toc:n {#1}
  }
\cs_generate_variant:Nn \maoxuan_vol:n { o }
\NewDocumentCommand \mxvolumetocbegin { m } { }
\NewDocumentCommand \mxpart { +m }
  {
    \cleardoublepage
    \tl_gset:Nn \g_maoxuan_part_tl {#1}
    \part { \g_maoxuan_part_tl }
    \cleardoublepage
  }
\tl_new:N \g_maoxuan_part_tl
\NewDocumentCommand \mxinclude
  { > { \SplitArgument { 1 } { - } } m }
  { \maoxuan_include_aux:nn #1 }
\cs_new_protected:Npn \maoxuan_include_aux:nn #1#2
  {
    \tl_if_novalue:nTF {#2}
      { \maoxuan_include:nn { 1 } {#1} }
      { \maoxuan_include:nn {#1}  {#2} }
  }
\cs_new_protected:Npn \maoxuan_include:nn #1#2
  {
    \tl_clear:N \l_tmpa_tl
    \int_set:Nn \l_tmpa_int {#1}
    \int_set:Nn \l_tmpb_int {#2}
    \int_step_inline:nnn
      { \l_tmpa_int }
      { \int_min:nn { \l_tmpb_int } { 9 } }
      {
        \tl_put_right:Nx \l_tmpa_tl
          { \maoxuan_input_article:n { \l_maoxuan_vol_prefix_tl 0 ##1 } }
      }
    \int_step_inline:nnn
      { \int_max:nn { \l_tmpa_int } { 10 } }
      { \l_tmpb_int }
      {
        \tl_put_right:Nx \l_tmpa_tl
          { \maoxuan_input_article:n { \l_maoxuan_vol_prefix_tl ##1 } }
      }
    \tl_use:N \l_tmpa_tl
  }
\cs_new_protected:Npn \maoxuan_input_article:n #1
  {
    \file_get_full_name:nNTF {#1} \l_maoxuan_current_file_tl
      {
        \clearpage
        \@addtofilelist { \l_maoxuan_current_file_tl }
        \tex_input:D { \l_maoxuan_current_file_tl }
        \maoxuan_at_end_article:
        \clearpage
      }
      {
        \msg_error:nnx { maoxuan } { file-not-found }
          { \l_maoxuan_current_file_tl }
      }
  }
\cs_new_eq:NN \mxinput \maoxuan_input_article:n
\tl_new:N \l_maoxuan_current_file_tl
\msg_new:nnn { maoxuan } { file-not-found }
  {  File ~ "#1" ~ \msg_line_context: \ not ~ found. }
\cs_new_protected:Npn \maoxuan_at_end_article:
  {
    \protected@write \@auxout { }
      {
        \c_backslash_str maoxuan@article@endpage
          { \l_maoxuan_current_article_str }
          { \thepage }
      }
  }
\cs_new_eq:NN \mxendarticle \maoxuan_at_end_article:
\cs_new_protected:Npn \maoxuan_save_end_page:nn
  { \prop_gput:Nnn \g_maoxuan_article_end_page_prop }
\cs_new_eq:NN \maoxuan@article@endpage \maoxuan_save_end_page:nn
\prop_new:N \g_maoxuan_article_end_page_prop
\setcounter { secnumdepth } { -5 }
\ctexset
  {
    part =
      {
        pagestyle  = empty ,
        format     = \bfseries \centering \huge ,
        beforeskip = \stretch { 1 } ,
        afterskip  = \stretch { 4 } ,
      } ,
    chapter =
      {
        pagestyle   = chapter ,
        format      = \bfseries \centering \LARGE ,
        titleformat = \maoxuan_endline_mark:n ,
        tocline     = \maoxuan_article_toc:nn { \CTEXnumberline {#1} #2 }
                                              { \g_maoxuan_date_tl } ,
        aftertitle  = \maoxuan_make_thanks: \par
                      \maoxuan_make_date:n { \normalsize } \par ,
        beforeskip  = 20pt ,
        afterskip   = 30pt minus 15pt ,
      } ,
    section =
      {
        hang        = false ,
        format      = \maoxuan_topskip_kludge:
                      \bfseries \centering \Large ,
        titleformat = \maoxuan_title_hangbox:n ,
        aftertitle  = \par \maoxuan_make_date:n { \small } \par ,
        beforeskip  = \bigskipamount ,
        afterskip   = \bigskipamount ,
      } ,
    subsection =
      {
        hang        = false ,
        format      = \maoxuan_topskip_kludge:
                      \bfseries \centering \large ,
        titleformat = \maoxuan_title_hangbox:n ,
        beforeskip  = \medskipamount ,
        afterskip   = \medskipamount ,
      } ,
    subsubsection =
      {
        hang        = false ,
        format      = \maoxuan_topskip_kludge:
                      \bfseries \centering \normalsize ,
        beforeskip  = \smallskipamount ,
        afterskip   = \smallskipamount ,
      } ,
  }
\cs_new_protected:Npn \maoxuan_title_hangbox:n #1
  { \maoxuan_title_hangbox:w #1 ^^^^3000 ^^^^3000 \q_stop }
\cs_new_protected:Npn \maoxuan_title_hangbox:w #1 ^^^^3000 #2 ^^^^3000 #3 \q_stop
  {
    \tl_if_empty:nTF {#3}
      { \maoxuan_endline_mark:n {#1} }
      { \maoxuan_title_hangbox:nn {#1} {#2} }
  }
\cs_new_protected:Npn \maoxuan_title_hangbox:nn #1#2
  {
    \hbox_set:Nn \l_tmpa_box {#1}
    \hbox_set:Nn \l_tmpb_box { \maoxuan_endline_mark:n {#2} }
    \dim_set:Nn \l_tmpa_dim { \linewidth - 2\ccwd }
    \dim_compare:nNnTF
      { \box_wd:N \l_tmpa_box + \box_wd:N \l_tmpb_box } > { \l_tmpa_dim }
      { \maoxuan_make_title_coffin: }
      {
        \mode_leave_vertical:
        \box_use_drop:N \l_tmpa_box \tex_kern:D \ccwd
        \box_use_drop:N \l_tmpb_box
      }
  }
\cs_new_protected_nopar:Npn \maoxuan_make_title_coffin:
  {
    \hcoffin_set:Nn \l_tmpa_coffin { \hbox_unpack_drop:N \l_tmpa_box }
    \dim_sub:Nn \l_tmpa_dim { \coffin_wd:N \l_tmpa_coffin }
    \vcoffin_set:Nnn \l_tmpb_coffin
      { \int_div_truncate:nn { \l_tmpa_dim } { \ccwd } \ccwd }
      { \@parboxrestore \hbox_unpack_drop:N \l_tmpb_box }
    \coffin_join:NnnNnnnn
      \l_tmpa_coffin { H } { r }
      \l_tmpb_coffin { T } { l } { \ccwd } { \c_zero_dim }
    \coffin_typeset:Nnnnn \l_tmpa_coffin
      { H } { l } { \c_zero_dim } { \c_zero_dim }
  }
\cs_new_protected:Npn \maoxuan_endline_mark:n #1
  { #1 \maoxuan_endline_mark: }
\cs_new_protected_nopar:Npn \maoxuan_endline_mark:
  { \maoxuan_endline_mark_aux: }
\cs_new_eq:NN \maoxuan_endline_mark_aux: \prg_do_nothing:
\cs_new:Npn \maoxuan_article_toc:nn #1#2
  { {#1} {#2} }
\pdfstringdefDisableCommands
  { \cs_set_eq:NN \maoxuan_article_toc:nn \use_i:nn }
\cs_new_protected_nopar:Npn \maoxuan_topskip_kludge:
  {
    \skip_set:Nn \l_tmpa_skip
      { \l_maoxuan_headsep_dim - \tex_lastskip:D }
    \dim_compare:nNnTF { \l_tmpa_skip } > \c_zero_dim
      { \skip_set_eq:NN \l_tmpa_skip \tex_topskip:D }
      { \skip_add:Nn \l_tmpa_skip { \tex_topskip:D } }
    \skip_vertical:N \l_tmpa_skip
    \@vspacer { -\l_tmpa_skip }
  }
\cs_new_protected_nopar:Npn \maoxuan_article_head_rule:
  { \box_use:N \l_maoxuan_article_head_rule_box }
\cs_new_protected_nopar:Npn \maoxuan_main_head_rule:
  { \box_use:N \l_maoxuan_main_head_rule_box }
\box_new:N \l_maoxuan_article_head_rule_box
\box_new:N \l_maoxuan_main_head_rule_box
\vbox_set_top:Nn \l_maoxuan_article_head_rule_box
  {
    \tex_kern:D 5pt \scan_stop:
    \tex_hrule:D width \textwidth depth 1.5pt height \c_zero_dim \scan_stop:
    \tex_kern:D 2pt \scan_stop:
    \tex_hrule:D width \textwidth depth  .5pt height \c_zero_dim \scan_stop:
  }
\vbox_set_top:Nn \l_maoxuan_main_head_rule_box
  {
    \tex_kern:D 5pt \scan_stop:
    \tex_hrule:D width \textwidth depth .5pt height \c_zero_dim \scan_stop:
  }
\dim_new:N \l_maoxuan_headsep_dim
\dim_set:Nn \l_maoxuan_headsep_dim
  {
    \headsep - \box_ht:N \l_maoxuan_main_head_rule_box
             - \box_dp:N \l_maoxuan_main_head_rule_box
  }
\newpagestyle { chapter } [ \small ]
  {
    \sethead [ \quad \maoxuan_the_page: ] [ ] [ ]
             { } { } { \maoxuan_the_page: \quad }
    \cs_set_eq:NN \makeheadrule \maoxuan_article_head_rule:
  }
\newpagestyle { main } [ \small ]
  {
    \sethead [ \quad \maoxuan_the_page: ] [ \maoxuan_even_head: ] [ ]
             { } { \chaptertitle } { \maoxuan_the_page: \quad }
    \cs_set_eq:NN \makeheadrule \maoxuan_main_head_rule:
  }
\pagestyle { main }
\cs_new_protected_nopar:Npn \maoxuan_even_head:
  {
    \c_maoxuan_name_tl
    \tl_if_empty:NF \g_maoxuan_part_tl
      { \quad \g_maoxuan_part_tl }
  }
\cs_new_protected_nopar:Npn \maoxuan_the_page: { \thepage }
\cs_new_protected_nopar:Npn \maoxuan_the_page_toc:
  { \itshape \arabic { page } }
\RenewDocumentCommand \tableofcontents { }
  {
    \maoxuan_input_toc_aux:nn
      { \Roman { page } }
      {
        \maoxuan_toc_title:n { 总目录 }
        \maoxuan_input_toc:
      }
  }
\cs_new_protected:Npn \maoxuan_volume_toc:n #1
  {
    \maoxuan_input_toc_aux:nn
      { \Roman { volume } . \Roman { page } }
      {
        \maoxuan_toc_title:n { 第 \chinese { volume } 卷 \contentsname }
        \prop_get:NnNT \g_maoxuan_toc_prop {#1} \l_tmpa_tl
          { \tl_use:N \l_tmpa_tl }
      }
  }
\cs_new_protected_nopar:Npn \maoxuan_input_toc:
  {
    \file_get:nnNTF
      { \c_sys_jobname_str .toc }
      {
        \char_set_catcode_letter:n { 64 }
        \int_set:Nn \tex_endlinechar:D { -1 }
      }
      \l_tmpa_tl
      {
        \tl_gset_eq:NN \g_maoxuan_toc_tl \l_tmpa_tl
        \tl_use:N \g_maoxuan_toc_tl
        \exp_args:No \maoxuan_save_toc:n { \g_maoxuan_toc_tl }
      }
      { \tl_gclear:N \g_maoxuan_toc_tl }
    \legacy_if:nT { @filesw }
      {
        \iow_new:N \g_maoxuan_toc_iow
        \RerunFileCheck { \c_sys_jobname_str .toc }
          { \iow_close:N \g_maoxuan_toc_iow }
          { }
        \iow_open:Nn \g_maoxuan_toc_iow { \c_sys_jobname_str .toc }
        \cs_new_eq:NN \tf@toc \g_maoxuan_toc_iow
      }
    \@nobreakfalse
  }
\cs_new_protected:Npn \maoxuan_save_toc:n #1
  {
    \seq_set_split:Nnn \l_tmpa_seq { \mxvolumetocbegin } {#1}
    \seq_pop_left:NN \l_tmpa_seq \l_tmpa_tl
    \seq_map_inline:Nn \l_tmpa_seq { \maoxuan_save_toc:w ##1 \q_stop }
  }
\cs_new_protected:Npn \maoxuan_save_toc:w #1#2 \q_stop
  { \prop_gput:Nnn \g_maoxuan_toc_prop {#1} {#2} }
\tl_new:N \g_maoxuan_toc_tl
\tl_new:N \g_maoxuan_toc_prop
\cs_new_protected:Npn \maoxuan_input_toc_aux:nn #1#2
  {
    \cleardoublepage
    \int_set:Nn \l_maoxuan_page_int { \value { page } }
    \group_begin:
      \setcounter { page } { \c_one }
      \cs_set_eq:NN \maoxuan_the_page: \maoxuan_the_page_toc:
      \tl_gset:Nn \thepage {#1}
      #2
      \cleardoublepage
    \group_end:
    \pagenumbering { arabic }
    \setcounter { page } { \l_maoxuan_page_int }
  }
\cs_new_protected:Npn \maoxuan_toc_title:n
  {
    \bookmarksetup { startatroot }
    \cs_set_eq:NN \addtocontents \use_none:nn
    \chapter
  }
\cs_new_eq:NN \maoxuan@saved@contentsline \contentsline
\RenewDocumentCommand \contentsline { m }
  {
    \cs_if_exist_use:cF { maoxuan@toc@#1 }
      { \maoxuan@saved@contentsline {#1} }
  }
\cs_new_protected:Npn \maoxuan@toc@part
  {
    \int_compare:nNnTF { \value { tocdepth } } > { -2 }
      { \maoxuan_toc_part:nnn }
      { \use_none:nnn }
  }
\cs_new_protected:Npn \maoxuan_toc_part:nnn #1#2#3
  {
    \addpenalty { -\@highpenalty }
    \addvspace { \bigskipamount }
    \maoxuan_topskip_kludge:
    \group_begin:
      \centering \bfseries \large
      \maoxuan_hyper_link:nn {#3} {#1} \par
    \group_end:
    \@nobreaktrue \everypar { \@nobreakfalse \everypar { } }
    \nobreak \bigskip
  }
\cs_new_protected:Npn \maoxuan@toc@chapter
  {
    \int_compare:nNnTF { \value { tocdepth } } > { -1 }
      { \maoxuan_toc_chapter:nnn }
      { \use_none:nnn }
  }
\cs_new_protected:Npn \maoxuan_toc_chapter:nnn #1
  { \maoxuan_toc_chapter:nnnn #1 }
\cs_new_protected:Npn \maoxuan_toc_chapter:nnnn #1#2#3#4
  {
    \addpenalty { -\@highpenalty }
    \addvspace { \smallskipamount }
    \group_begin:
      \skip_set:Nn \tex_rightskip:D { 6\ccwd plus 1fil minus 4\ccwd }
      \skip_sub:Nn \tex_parfillskip:D { \tex_rightskip:D }
      \dim_set_eq:NN \tex_hangindent:D \ccwd
      \int_set_eq:NN \tex_hangafter:D \c_one
      \int_set_eq:NN \tex_interlinepenalty:D \c_ten_thousand
      \tex_noindent:D
      \maoxuan_hyper_link:nn {#4}
        { #1 \tl_if_empty:nF {#2} { { \footnotesize （ #2 ） } } }
      \tex_penalty:D \c_zero \null \maoxuan_cdot_fill:
      \prop_get:NnNTF \g_maoxuan_article_end_page_prop {#4} \l_tmpa_tl
        { \exp_args:No \maoxuan_toc_page_range:nn { \l_tmpa_tl } {#3} }
        { \maoxuan_hyper_page:n {#3} }
      \par \tex_penalty:D \@highpenalty
    \group_end:
  }
\cs_new_protected:Npn \maoxuan_toc_page_range:nn #1#2
  {
    \str_if_eq:nnTF {#1} {#2}
      { \maoxuan_hyper_page:n {#1} }
      {
        \hbox:n
          {
            \maoxuan_hyper_page:n {#2} —
            \maoxuan_hyper_page:n {#1}
          }
      }
  }
\cs_new_protected:Npn \maoxuan@toc@section
  {
    \int_compare:nNnTF { \value { tocdepth } } > \c_zero
      { \maoxuan_toc_section:nnn }
      { \use_none:nnn }
  }
\cs_new_protected:Npn \maoxuan_toc_section:nnn #1#2#3
  {
    \group_begin:
      \skip_set:Nn \tex_leftskip:D { \ccwd }
      \small
      \skip_set:Nn \tex_rightskip:D { 4\ccwd minus \ccwd }
      \skip_sub:Nn \tex_parfillskip:D { \tex_rightskip:D }
      \maoxuan_toc_hangindent_aux:w #1 ^^^^3000 \q_nil \q_stop
      \int_set_eq:NN \tex_hangafter:D \c_one
      \int_set_eq:NN \tex_interlinepenalty:D \c_ten_thousand
      \skip_gset:Nn \g_maoxuan_subsection_toc_skip
        { \tex_leftskip:D + \tex_hangindent:D }
      \tex_noindent:D
      \maoxuan_hyper_link:nn {#3} {#1}
      \maoxuan_cdot_fill:
      { \normalsize \maoxuan_hyper_page:n {#2} } \par
    \group_end:
  }
\cs_set_protected:Npn \maoxuan@toc@subsection
  {
    \int_compare:nNnTF { \value { tocdepth } } > \c_one
      { \maoxuan_toc_subsection:nnn }
      { \use_none:nnn }
  }
\cs_new_protected:Npn \maoxuan_toc_subsection:nnn #1#2#3
  {
    \group_begin:
      \footnotesize
      \skip_set_eq:NN \tex_leftskip:D \g_maoxuan_subsection_toc_skip
      \skip_set:Nn \tex_rightskip:D { 4\ccwd minus 3\ccwd }
      \skip_sub:Nn \tex_parfillskip:D { \tex_rightskip:D }
      \maoxuan_toc_hangindent_aux:w #1 ^^^^3000 \q_nil \q_stop
      \int_set_eq:NN \tex_hangafter:D \c_one
      \int_set_eq:NN \tex_interlinepenalty:D \c_ten_thousand
      \tex_noindent:D
      \maoxuan_hyper_link:nn {#3} {#1}
      \maoxuan_cdot_fill:
      { \normalsize \maoxuan_hyper_page:n {#2} } \par
    \group_end:
  }
\skip_new:N \g_maoxuan_subsection_toc_skip
\cs_new_protected:Npn \maoxuan_toc_hangindent_aux:w #1 ^^^^3000 #2 \q_stop
  {
    \dim_set:Nn \tex_hangindent:D
      {
        \quark_if_nil:nTF {#2}
          { 2\ccwd }
          { \tl_count:n {#1} \ccwd + \ccwd }
      }
  }
\cs_new_protected_nopar:Npn \maoxuan_cdot_fill:
  {
    \tex_leaders:D
      \hbox_to_wd:nn { 8pt } { \tex_hss:D \textperiodcentered \tex_hss:D }
      \tex_hfill:D
  }
\cs_new_protected_nopar:Npn \maoxuan_sanitize:Nnn #1#2#3
  {
    \group_begin:
      \cs_set_eq:NN \protect \@unexpandable@protect
      #2 \scan_stop:
    \exp_args:NNNx \group_end:
      \str_set:Nn #1 { \maoxuan_sanitize_wrapper:n {#3} }
  }
\cs_new_nopar:Npn \maoxuan_sanitize_wrapper:n #1
  { \pdf@mdfivesum {#1} }
\RenewDocumentCommand \title { +m }
  {
    \tl_set:Nn \l_maoxuan_title_tl {#1}
    \maoxuan_sanitize:Nnn \l_maoxuan_current_article_str { }
      { \l_maoxuan_title_tl }
  }
\str_new:N \l_maoxuan_current_article_str
\RenewDocumentCommand \date { +m }
  { \tl_gset:Nn \g_maoxuan_date_tl {#1} }
\RenewDocumentCommand \thanks { +m }
  { \tl_set:Nn \l_maoxuan_thanks_tl {#1} }
\RenewDocumentCommand \maketitle { +m }
  {
    \exp_args:No \chapter { \l_maoxuan_title_tl }
    \tl_clear:N \l_maoxuan_title_tl
    \tl_clear:N \l_maoxuan_thanks_tl
  }
\cs_set_protected:Npn \CTEX@makeanchor@chapter #1
  {
    \tl_if_empty:NTF \l_maoxuan_title_tl
      { \Hy@MakeCurrentHrefAuto {#1} }
      { \Hy@MakeCurrentHref { \l_maoxuan_current_article_str } }
    \maoxuan_hyper_anchor:n { \@currentHref }
  }
\NewDocumentCommand \mxname { +m } { \tex_noindent:D #1 }
\NewDocumentCommand \mxsay { +m } { { \bfseries #1 } }
\tl_new:N \g_maoxuan_date_tl
\tl_new:N \l_maoxuan_title_tl
\tl_new:N \l_maoxuan_thanks_tl
\cs_new_protected_nopar:Npn \maoxuan_make_thanks:
  {
    \tl_if_empty:NF \l_maoxuan_thanks_tl
      { \maoxuan_make_thanks_aux: }
  }
\cs_new_protected_nopar:Npn \maoxuan_make_thanks_aux:
  {
    \str_set:Nx \l_maoxuan_current_thanks_str
      { thanks . \l_maoxuan_current_article_str }
    \maoxuan_thanks_mark:
    \maoxuan_thanks_insert:
  }
\skip_new:N \l_maoxuan_current_thanks_str
\cs_new_protected_nopar:Npn \maoxuan_thanks_mark:
  {
    \tex_unskip:D
    \hbox_set:Nn \l_tmpa_box
      {
        \box_move_up:nn { 1ex }
          {
            \hbox:n
              {
                \normalsize
                \maoxuan_hyper_link:nn
                  { \l_maoxuan_current_thanks_str }
                  { \l_maoxuan_thanks_symbol_tl }
              }
          }
      }
    \box_set_ht:Nn \l_tmpa_box { \c_zero_dim }
    \box_set_wd:Nn \l_tmpa_box { \c_zero_dim }
    \box_use_drop:N \l_tmpa_box
  }
\tl_new:N \l_maoxuan_thanks_symbol_tl
\tl_set:Nn \l_maoxuan_thanks_symbol_tl { \ding { 91 } }
\cs_new_protected_nopar:Npn \maoxuan_thanks_insert:
  {
    \group_begin:
      \normalfont \footnotesize
      \vbox_set:Nn \l_maoxuan_thanks_box
        {
          \dim_set_eq:NN \tex_hsize:D \columnwidth
          \@parboxrestore
          \int_set_eq:NN \tex_interlinepenalty:D \interfootnotelinepenalty
          \protected@edef \@currentlabel { \l_maoxuan_thanks_symbol_tl }
          \color@begingroup
            \maoxuan_thanks_text:
          \color@endgroup
        }
      \dim_set:Nn \l_tmpa_dim
        { \box_ht:N \l_maoxuan_thanks_box + \box_dp:N \l_maoxuan_thanks_box }
      \dim_gset:Nn \g_maoxuan_thanks_height_dim
        {
          \dim_compare:nNnTF \l_tmpa_dim > \g_maoxuan_thanks_max_height_dim
            { ( \l_tmpa_dim + \tex_baselineskip:D ) / 2 }
            { \g_maoxuan_thanks_max_height_dim }
        }
      \tex_insert:D \footins
        {
          \skip_zero:N \tex_splittopskip:D
          \dim_set:Nn \tex_splitmaxdepth:D { \box_dp:N \strutbox }
          \int_set_eq:NN \tex_floatingpenalty:D \@MM
          \vbox_unpack_drop:N \l_maoxuan_thanks_box
        }
    \group_end:
  }
\cs_new_protected:Npn \maoxuan_thanks_text:
  {
    \skip_set:Nn \tex_leftskip:D { \ccwd }
    \dim_set:Nn \parindent { 2\ccwd }
    \tex_noindent:D
    \hbox_overlap_left:n
      {
        \maoxuan_hyper_link:nn
          { \@currentHref } { \l_maoxuan_thanks_symbol_tl }
        \maoxuan_hyper_anchor:n { \l_maoxuan_current_thanks_str }
        \skip_horizontal:n { .5\ccwd }
      }
    \tl_clear:N \@currentlabelname
    \tl_set_eq:NN \@currentHref \l_maoxuan_current_thanks_str
    \l_maoxuan_thanks_tl \par
  }
\box_new:N \l_maoxuan_thanks_box
\dim_new:N \g_maoxuan_thanks_max_height_dim
\tex_skipdef:D \g_maoxuan_thanks_sep_skip = \footins
\tex_dimendef:D \g_maoxuan_thanks_height_dim = \footins
\skip_gset:Nn \g_maoxuan_thanks_sep_skip { 16pt minus 6pt }
\dim_gset:Nn \g_maoxuan_thanks_max_height_dim { \textheight / 3 }
\dim_gset_eq:NN \g_maoxuan_thanks_height_dim \g_maoxuan_thanks_max_height_dim
\skip_new:N \l_maoxuan_thanks_rule_above_skip
\skip_new:N \l_maoxuan_thanks_rule_below_skip
\skip_set:Nn \l_maoxuan_thanks_rule_below_skip
  { \g_maoxuan_thanks_sep_skip / 2 }
\skip_set:Nn \l_tmpa_skip
  { \g_maoxuan_thanks_sep_skip - \l_maoxuan_thanks_rule_below_skip }
\skip_set:Nn \l_maoxuan_thanks_rule_above_skip
  {
    \dim_eval:n { \l_tmpa_skip }
    plus 1fil ~ minus \etex_glueshrink:D \l_tmpa_skip
  }
\RenewDocumentCommand \footnoterule { }
  {
    \tex_unskip:D
    \skip_vertical:N \l_maoxuan_thanks_rule_above_skip
    \box_use:N \l_maoxuan_footnote_rule_box
    \skip_vertical:N \l_maoxuan_thanks_rule_below_skip
  }
\box_new:N \l_maoxuan_footnote_rule_box
\hbox_set:Nn \l_maoxuan_footnote_rule_box
  {
    \tex_vrule:D width .45 \columnwidth depth .5pt
      height \c_zero_dim \scan_stop:
  }
\box_set_dp:Nn \l_maoxuan_footnote_rule_box { \c_zero_dim }
\cs_new_protected:Npn \maoxuan_make_date:n #1
  {
    \tl_if_empty:NF \g_maoxuan_date_tl
      { \maoxuan_make_date_aux:n {#1} }
  }
\cs_new_protected:Npn \maoxuan_make_date_aux:n #1
  {
    \nobreak \medskip
    \group_begin:
      #1 \mdseries \fangsong
      （ \g_maoxuan_date_tl ） \par
    \group_end:
    \tl_gclear:N \g_maoxuan_date_tl
  }
\pdfstringdefDisableCommands
  { \cs_set_eq:NN \mnote \use_none:n }
\DeclareExpandableDocumentCommand \mnote { }
  {
    \cs_if_eq:NNTF \protect \@typeset@protect
      { \maoxuan_note_link_super:n } { \use_none:n }
  }
\NewDocumentCommand \mxart { }
  { \maoxuan_article_link:Nn \l_tmpa_str }
\NewDocumentCommand \mxnote { +m +m }
  {
    \maoxuan_article_link:Nn \l_maoxuan_current_xnote_str {#1}
    \maoxuan_note_link:nn { \l_maoxuan_current_xnote_str #2 } {#2}
  }
\NewDocumentCommand \mxnotex { +m }
  { \maoxuan_note_link:nn { \l_maoxuan_current_xnote_str #1 } {#1} }
\NewDocumentCommand \mxthanks { +m +m }
  {
    \maoxuan_article_link:Nn \l_maoxuan_current_thanks_str {#1}
    #2 \CJKglue
    \maoxuan_hyper_link:nn { thanks . \l_maoxuan_current_thanks_str } { 题解 }
    \xeCJK_make_node:n { CJK }
  }
\NewDocumentCommand \mxapp { s +m }
  {
    \IfBooleanF #1 { 附录 }
    《 \maoxuan_sanitize:Nnn \l_tmpa_str { } { 附录： #2 }
      \maoxuan_hyper_link:nn { \l_tmpa_str } {#2} 》
  }
\cs_new_protected:Npn \maoxuan_article_link:Nn #1#2
  {
    《 \maoxuan_sanitize:Nnn #1 { } {#2}
      \maoxuan_hyper_link:nn {#1} {#2} 》
  }
\cs_new_protected:Npn \maoxuan_note_link:n #1
  {
    \str_set:Nx \l_maoxuan_current_note_str
      { \l_maoxuan_current_article_str #1 }
    \maoxuan_note_link:nn { \l_maoxuan_current_note_str } {#1}
  }
\cs_new_protected:Npn \maoxuan_note_link:nn #1#2
  {
    注 \CJKecglue
    \maoxuan_hyper_link:nn { mnotelisti . #1 }
      { \maoxuan_note_format:n {#2} }
    \xeCJK_make_node:n { default }
  }
\cs_new_protected:Npn \maoxuan_note_link_super:n #1
  {
    \str_set:Nx \l_maoxuan_current_note_str
      { \l_maoxuan_current_article_str #1 }
    \maoxuan_hyper_link:nn
      { mnotelisti . \l_maoxuan_current_note_str }
      { \maoxuan_note_link_super_aux:n {#1} }
  }
\cs_new_protected:Npn \maoxuan_note_link_super_aux:n #1
  {
    \hbox_set:Nn \l_tmpa_box
      {
        \fontsize { .7\ccwd } { .8\ccwd } \selectfont
        \maoxuan_hyper_anchor:n { mnote . \l_maoxuan_current_note_str }
        \maoxuan_note_format:n {#1}
      }
    \hbox_set:Nn \l_tmpa_box
      {
        \box_move_up:nn { \ccwd - \box_ht:N \l_tmpa_box }
          { \box_use_drop:N \l_tmpa_box }
      }
    \box_set_ht:Nn \l_tmpa_box { \c_zero_dim }
    \box_use_drop:N \l_tmpa_box
  }
\cs_new_protected:Npn \maoxuan_note_format:n #1 { [#1] }
\NewDocumentCommand \mnitem { +m }
  {
    \str_set:Nx \l_maoxuan_current_note_str
      { \l_maoxuan_current_article_str #1 }
    \item
  }
\str_new:N \l_maoxuan_current_note_str
\str_new:N \l_maoxuan_current_xnote_str
\newlist { mnotelist } { enumerate } { 1 }
\setlist [ mnotelist , 1 ]
  {
    nosep , wide , labelsep = 0.5em ,
    label  = \maoxuan_note_format:n { \arabic * } ,
    format = \maoxuan_mnitem_format:n ,
    before = \cs_set_eq:NN \item \H@item
             \cs_set_eq:NN \mnote \maoxuan_note_link:n ,
    after  = \int_set_eq:NN \tex_widowpenalty:D \c_ten_thousand ,
  }
\tl_set:Nn \theHmnotelisti { \l_maoxuan_current_note_str }
\cs_new_protected_nopar:Npn \maoxuan_mnitem_format:n
  { \maoxuan_hyper_link:nn { mnote . \l_maoxuan_current_note_str } }
\SetLabelAlign { qa } { \hbox_to_wd:nn { 2\ccwd } { #1 \tex_hss:D } }
\SetEnumitemKey { qa }
  {
    nosep , align = qa , labelsep = \c_zero_dim ,
    leftmargin = 2\ccwd , listparindent=2\ccwd ,
    before = \box_clear:N \@labels ,
  }
\dim_new:N \l_maoxuan_notetitle_indent_dim
\group_begin:
  \footnotesize
  \hbox_set:Nn \l_tmpa_box { [ 1 ] }
\exp_args:NNNf \group_end:
\dim_set:Nn \l_maoxuan_notetitle_indent_dim
  { \dim_eval:n { \parindent + \box_wd:N \l_tmpa_box + .5em } }
\NewDocumentEnvironment { maonote } { }
  {
    \ctexset
      {
        section =
          {
            format      = \maoxuan_topskip_kludge:
                          \large \bfseries ,
            indent      = \l_maoxuan_notetitle_indent_dim ,
            beforeskip  = 15pt minus 10pt ,
            afterskip   = 15pt minus 10pt ,
          } ,
      }
    \section * { 注 \quad 释 }
    \footnotesize
    \mnotelist
  }
  { \endmnotelist }
\dim_new:N \l_maoxuan_quote_parindent_dim
\group_begin: \kaishu \small \exp_args:NNNo \group_end:
\dim_set:Nn \l_maoxuan_quote_parindent_dim { \dim_use:N \parindent }
\RenewDocumentEnvironment { quote } { }
  {
    \list { }
      {
        \skip_zero:N \partopsep
        \skip_set_eq:NN \topsep \medskipamount
        \skip_set_eq:NN \parsep \parskip
        \dim_zero:N \rightmargin
        \dim_set_eq:NN \leftmargin \parindent
        \dim_set_eq:NN \listparindent \l_maoxuan_quote_parindent_dim
        \mode_if_vertical:TF
          { \dim_set_eq:NN \itemindent \listparindent }
          { \dim_zero:N \itemindent }
      }
    \kaishu \small
    \item \scan_stop:
  }
  { \endlist }
