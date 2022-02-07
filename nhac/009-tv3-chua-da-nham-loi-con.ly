% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Đã Nhậm Lời Con" }
  composer = "Tv. 3"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 _(b16 a) |
  g4. f8 |
  f
  <<
    {
      \voiceOne
      g
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #1
      \once \tiny e
    }
  >>
  g g |
  a4. f16 a |
  g8 g e f |
  d4 r8 d |
  b8. _(a16) f'8 d |
  g4. e16 _(f) |
  d8 g4 a8 |
  a2 \bar "||" \break
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  fs4. g16 (fs) |
  e2 |
  r8 d d fs |
  g4 e8 e |
  a4 r8 b |
  b8. cs16 cs8 b |
  a4. a8 |
  e' e r e |
  e4 cs8 cs |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r4
  R2*9
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \key d \major
  d4. e16 (d) |
  cs2 |
  r8 d d d |
  e4 d8 d |
  cs4 r8 e |
  g8. a16 a8 g |
  fs4. fs8 |
  g g r gs |
  a4 e8 e |
  fs2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa ơi, địch thù con sao đông thế,
      người chống con ôi thực quá nhiều,
      Bao kẻ nói về con:
      Chúa Trời đâu cứu hắn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Mỗi khi lời miệng con kêu lên Chúa,
	    Ngài lắng nghe, thương tình đáp lời,
	    tôi nằm thiếp ngủ đi,
	    thức dậy tay Chúa đỡ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Khiến con chẳng sợ
	    \markup { \underline \italic "thù" }
	    nhân vây kín,
	    vì Chúa ban ân lộc cứu độ,
	    Bao kẻ tác hại con,
	    Chúa trở tay quất ngã.
    }
  >>
  \set stanza = "ĐK:"
  Nhưng Chúa ơi,
  Ngài là khiên thuẫn độ trì con,
  Khi con cất tiếng kêu cầu,
  từ núi thánh Chúa đã nhậm lời con.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
