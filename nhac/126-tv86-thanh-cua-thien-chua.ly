% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Thành Của Thiên Chúa"
  composer = "Tv. 86"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 f8 g |
  g4. c,8 |
  d (f) g g |
  a4 d8 c |
  bf c16 (bf) g8. e16 |
  d8 c f g |
  a4 r8 \bar "||" \break
  
  c8 |
  f, (e) f8 g |
  a2 |
  c8 bf d c16 (bf) |
  g4. e16 (d) |
  c8. c16 g'8 e |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thành Si -- on được lập trên núi thánh,
      Chúa yêu chuộng cửa thành
      hơn mọi nà của Gia -- cóp.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Về Si -- on, người người luôn sẽ nói,
	    Chúa thương củng cố thành
	    với bao người sinh tại đó.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Và ai ai được hạ sinh chốn đó.
	    Múa vui và hát rằng:
	    chính cội nguồn của tôi đấy.
    }
  >>
  \set stanza = "ĐK:"
  Hỡi thành của Thiên Chúa,
  Thiên hạ nói bao điều,
  bao điều hiển hách về ngươi.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
  bottom-margin = 15\mm
  left-margin = 10\mm
  right-margin = 10\mm
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
