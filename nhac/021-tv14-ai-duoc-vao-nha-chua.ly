% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Ai Được Vào Nhà Chúa" }
  composer = "Tv. 14"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 f8. g16 |
  d8 c4 f8 |
  e (f) g f16 (g) |
  a4 r8 f |
  bf8. a16 g8 g |
  c4 c8 c |
  f,4 r8 \bar "||" \break
  
  a8 |
  e8. e16 g (a) e8 |
  d8. c16 d8 f |
  g4 r8 g |
  c c a16 (g) c8 |
  e,8. g16 e (d) c8 |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8. g16 |
  d8 c4 a8 |
  c (d) c [c] |
  f4 r8 ef |
  d8. f16 f8 f |
  e4 e8 e |
  f4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Ai sẽ được vào cư ngụ trong nhà Chúa,
  Lạy Chúa, ai được ở trên núi thánh Ngài?
  <<
    {
      \set stanza = "1."
      Đó là người sống vẹn toàn làm điều thẳng ngay,
      lòng trí nghĩ suy chính trực,
      nói năng thực tâm
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Chẳng hề trù tính hại người
	    hoặc nhục mạ ai,
	    Trọng kẻ kính tin Chúa Trời,
	    ghét ai tà tâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lỡ thề mà có bị thiệt chẳng hề đơn sai
	    Chẳng có thiết ăn hối lội khiến hại người ngay.
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
