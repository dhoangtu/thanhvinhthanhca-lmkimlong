% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Lạy Thiên Chúa" }
  composer = "Kh. 4,11;5,9.10.12"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \once \override Score.RehearsalMark.font-size = #0.1
  \once \override Score.RehearsalMark.extra-offset = #'(5 . 0)
  \mark \markup { \musicglyph #"scripts.segno" }
  \partial 4 c8 (d) |
  e2 |
  \once \phrasingSlurDashed
  d8. \(g16\) a8
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.6
      \tweak font-size #-2
      \parenthesize
      g8
    }
  >>
  \oneVoice
  g4. g8 |
  
  <<
    {
      \voiceOne
      e'8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      %\once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \once \override NoteColumn.force-hshift = #2
      \tweak font-size #-2
      \parenthesize
      d8
    }
  >>
  \oneVoice
  e4 e8 |
  c4. d8 |
  d8.
  <<
    {
      \voiceOne
      \stemDown
      d16
    }
    \new Voice = "splitpart" {
      \voiceTwo
      %\once \override Beam.transparent = ##t
      \once \override Stem.transparent = ##t
      \stemDown
      \once \override NoteColumn.force-hshift = #1.5
      \tweak font-size #-2
      \parenthesize
      b16
    }
  >>
  \oneVoice
  b8 d |
  c g ~ g4 ~ |
  g r8 d16 d |
  d8 d f d |
  
  \set Score.repeatCommands = #'((volta "1+2"))
  c2 ~ |
  c8 c e f16 (e) |
  
  d8. d16 d8
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.6
      \tweak font-size #-2
      \parenthesize
      g8
    }
  >>
  \oneVoice
  a4. g8 |
  a4 b |
  c2 ~ |
  \partial 4 c4 
  \once \override Score.RehearsalMark #'break-visibility = #end-of-line-visible
  \once \override Score.RehearsalMark.font-size = #0.1
  \mark \markup { \musicglyph #"scripts.segno" }
  \set Score.repeatCommands = #'((volta #f) (volta "3") end-repeat)
  \bar "||" \break
  
  <>^\markup { \bold "CODA" }
  c,4 r8 g' |
  \set Score.repeatCommands = #'((volta #f))
  g2 |
  a8 (g) e (g) |
  a4. d16 d |
  b8 b c d |
  g,4 r8 g |
  g8. g16 d8 d |
  f g r g |
  a g a (b) |
  c2 ~ |
  c4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  c8 (d) |
  e2 |
  \once \phrasingSlurDashed
  d8. \(g16\) a8
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.6
      \tweak font-size #-2
      \parenthesize
      g8
    }
  >>
  \oneVoice
  g4. g8 |
  <<
    {
      \voiceOne
      c8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2
      \tweak font-size #-2
      \parenthesize
      b
    }
  >>
  \oneVoice
  c4 b8 |
  a4. f8 |
  g8.
  <<
    {
      \voiceOne
      \stemDown
      g16
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1.5
      \tweak font-size #-2
      \parenthesize
      g16
    }
  >>
  \oneVoice
  g8 g |
  e8 e ~ e4 ~ |
  e r8 d16 d |
  d8 d f d |
  c2 ~ |
  c8 c e f16 (e) |
  
  d8. d16 d8
  <<
    {
      \voiceOne
      d8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.6
      \tweak font-size #-2
      \parenthesize
      g8
    }
  >>
  \oneVoice
  f4. e8 |
  d4 g |
  e2 ~ |
  e4
  
  c4 r8 e |
  e2 |
  d8 (e) c (e) |
  f4. fs16 fs |
  g8 g a f |
  e4 r8 e |
  d8. c16 b8 b |
  d e r e |
  f e d (g) |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Lạy Chúa là Thiên Chúa chúng con,
      ngài xứng đáng lãnh nhận vinh quang danh dự với uy quyền,
      Vì Ngài đà tạo tác muôn loài
      Và do ý Ngài mọi loài liền có và được dựng nên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lạy Chúa \markup { \italic \underline "là" } _
	    Đức \markup { \italic \underline "Ki" } -- tô,
	    Ngài xứng đáng lãnh nhận cuốn sách
	    \markup { \italic \underline "để" }
	    mở ấn niêm chặt,
	    Vì Ngài đã bị giết ô nhục
	    Và đem máu đào chuộc về
	    \markup { \italic \underline "cho" }
	    Chúa ngàn muôn dân nước.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài đã làm cho chúng \markup { \italic \underline "con" }
	    đây thành \markup { \italic \underline "Tư" }
	    tế nước Ngài,
	    luôn luôn \markup { \italic \underline "phụng" }
	    thờ kính tôn Ngài,
	    Được Ngài đặt làm chủ địa
    }
  >>
  \stanzaReminderOff
  \set stanza = "3."
  cầu.
  Con Chiên đã bị giết,
  Đáng lãnh nhận quyền năng dũng lực,
  khôn ngoan danh dự cùng vinh quang
  và muôn lời ca chúc.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
