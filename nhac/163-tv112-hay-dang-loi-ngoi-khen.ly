% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hãy Dâng Lời Ngợi Khen" }
  composer = "Tv. 112"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4. c8 d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 c |
  b b c8. d16 |
  c8 g r g |
  e'8. f16 e8 c ~ |
  c4 r8 c |
  b8. b16 d8 c |
  g2 ~ |
  g8 c, d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 g |
  fs fs g8. a16 |
  g8 e r e |
  a8. b16 a8 g ~ |
  g4 r8 g16 g |
  d'8. e16 d8 b |
  c2 ~ |
  c8 \bar "||"
  
  c, f e |
  d8. g16 a8 fs |
  g4. c16 c |
  a8 g \once \stemUp c
  <<
    {
      \voiceOne
      b
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #-1.5
      \tweak font-size #-2
      \parenthesize
      c
    }
  >>
  \oneVoice
  \slashedGrace { b16 (c } d2) ~ |
  d8 d d e |
  e,8. e16 a8 a |
  g4 \tuplet 3/2 { g8 c b } |
  a a16 a d8 e |
  c2 ~ |
  c8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 e |
  g g a8. g16 |
  e8 e r g |
  c8. a16 g8 e ~ |
  e4 r8 a |
  g8. g16 fs8 fs |
  g2 ~ |
  g8 c, d e |
  f4 f ~ |
  f8 e d d |
  g4 r8 e |
  d d e8. c16 |
  b8 c r c |
  f8. g16 f8 e ~ |
  e4 r8 e16 e |
  f8. g16 f8 d |
  e2 ~ |
  e8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Nào tôi tớ Chúa,
  hãy dâng lời ngợi khen,
  Dâng lời ngợi khen thánh danh Ngài,
  ngợi khen thanh danh Ngài,
  bây giờ và đến muôn đời.
  Nào tôi tớ Chúa,
  hãy dâng lời ngợi khen,
  dâng lời ngợi khen thánh danh Ngài,
  ngợi khen thánh danh Ngài,
  từ bình minh tới khi hoàng hôn.
  <<
    {
      \set stanza = "1."
      Vì Chúa siêu việt trên hết mọi dân,
      Vinh quang Ngài vượt trên trời thẳm
      Ai đâu sánh tầy Thượng Đế, Chúa ta,
      Từ chốn cao vời Ngài nhìn xem đất trời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngài nhắc kẻ hèn nơi cát bụi lên,
	    Nâng dân nghèo từ trong
	    \markup { \italic \underline "phân" }
	    thổ
	    Lên ngang với hàng quyền quí phúc vinh
	    Và khiến cho người muộn mằn nên mẫu hiền.
    }
  >>
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
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

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
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
