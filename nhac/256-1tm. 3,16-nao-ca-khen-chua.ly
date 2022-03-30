% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nào Ca Khen Chúa" }
  composer = "1Tm. 3,16"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 c8 c |
  g4. e8 |
  a4 b |
  c2 ~ |
  c4 \bar "|." \break
  
  c8 a |
  g4.
  <<
    {
      \voiceOne
      a8
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2
      \tweak font-size #-2
      \parenthesize
      g
    }
  >>
  \oneVoice
  d f4 g8 |
  c,2 ~ |
  c8 c f e |
  d4. a'8 |
  fs fs4 fs8 |
  g2 ~ |
  g4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  e8 c |
  b4. c8 |
  f4 d |
  e2 ~ |
  e4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Muôn dân nào cùng ca khen Chúa
  <<
    {
      \set stanza = "1."
      Đức Ki -- tô xuất hiện trong xác phàm,
      Được Chúa Thánh Thần chứng thực và biểu dương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Đức Ki -- tô \markup { \italic \underline "thiên" }
	    thần luôn ngưỡng nhìn,
	    Và giữa nhân loại đã hằng được truyền rao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đức Ki -- tô khắp trần gian kính thờ,
	    Người đã siêu độ cõi trần đầy hiển vinh.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
