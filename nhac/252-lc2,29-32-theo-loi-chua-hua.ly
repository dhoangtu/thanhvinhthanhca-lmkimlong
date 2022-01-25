% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Theo Lời Chúa Hứa"
  composer = "Lc. 2,29-32"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 e8 |
  c c f8. f16 |
  e4 r8 c |
  g'8. g16 g8 a |
  e4. d8 |
  f e4 d8 |
  c4 r8 \bar "||" \break
  
  e16
  ^\markup { \bold "Có thể hát với Điệp ca sau đây trong Kinh tối" }
  c |
  f8 e d g |
  g4. g16 a |
  f8 e g g |
  d4 r8 c16 c |
  a'8 a a16 (c) a8 |
  g4. d8 |
  f e4 d8 |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*5
  r4.
  e16 c |
  f8 e d c |
  b4. c16 f |
  d8 d c c |
  b4 r8 c16 c |
  f8 f f16 (a) f8 |
  e4. b8 |
  d c4 b8 |
  c4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Theo lời Ngài phán, Chúa ơi,
      Giờ đây cho tôi tớ này được bước đi an bình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Bời vì rầy chính mắt con được trông xem
	    Ơn Cứu Độ dành sẵn cho nhân trần.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chính là sự sáng chiếu soi,
	    Là vinh quang Ít -- ra -- en
	    chỉ lối cho muôn người.
    }
  >>
  Khi còn thức xin Ngài cứu vớt,
  Khi đã ngủ xin cũng giữ gìn,
  Cùng tỉnh thức với Đức Ki -- tô và nghỉ ngơi an bình.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
