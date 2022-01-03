% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Từ Thuở Ấu Thơ"
  composer = "Tv. 128"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \parenthesize r8 d f a |
  g8. c16 c8 c |
  c a r a |
  g g e16 (d) g8 |
  c,2 ~ |
  c8 c f a |
  g8. c16 c8 c |
  c a r a |
  bf8. g16 c8 e, |
  f2 ~ |
  f4 \bar "||"
  
  f8 f |
  e8. a16 d,8 e |
  f c4 d8 |
  bf'8. bf16 bf8 g |
  a4 r8 a |
  bf8. a16 g8 g |
  g c4 c8 |
  e,8. e16 g8 g |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  \parenthesize r8 d f a |
  g8. f16 e8 e |
  e f r f |
  c c b! [b] |
  c2 ~ |
  c8 c f a |
  g8. f16 e8 e |
  d f r f |
  g8. f16 e8 c |
  a2 ~ |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Từ thuở ấu thơ chúng đã ức hiếp tôi,
  Is -- ra -- el hãy nói rằng:
  Từ thuở ấu thơ chúng đã ức hiếp tôi,
  nhưng chúng không thắng được tôi.
  <<
    {
      \set stanza = "1."
      Trên lưng này chúng cày ngang bới dọc,
      Đào bới những luống thực sâu,
      Nhưng Chúa công bình đã chặt đứt
      chão thừng của lũ ác nhân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Như bao ngọn cỏ mọc trên mái nhà,
	    Chẳng bứt cũng héo tàn thôi,
	    Mong những quân thù Si -- on đó
	    cúi đần nhục nhã tháo lui.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ai đi gặt chẳng lượm chi thứ này,
	    Người bó cũng chẳng thèm gom,
	    Bao khách qua đướng chẳng cầu chúc:
	    Chúa đổ hồng phúc xuống ngươi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  page-count = #1
}

TongNhip = {
  \key f \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
