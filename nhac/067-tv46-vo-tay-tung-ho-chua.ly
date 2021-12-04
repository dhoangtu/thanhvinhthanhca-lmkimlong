% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Vỗ Tay Tung Hô Chúa"
  composer = "Tv. 46"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4. c8 e,16 (f) g8 |
  g4 bf8 bf |
  a4 g8 g |
  a8. f16 g8 d |
  c2 ~ |
  c8 c a'16 (bf) a8 |
  g4 c8 c |
  e,4. e8 |
  f g d16 (e) c8 |
  f2 ~ |
  f4 \bar "||"
  
  a16 (c) f,8 |
  g4. e8 |
  f f4 c8 |
  a'2 ~ |
  a4 r8 a |
  bf8. c16 d8 d |
  c c r g |
  g8. a16 bf8 a |
  f g r a |
  f d4 d16 (e) |
  c8 f e (g) |
  a2 ~ |
  a8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  c8 e,16 (f) g8 |
  g4 g8 g |
  f4 e8 e |
  f8. d16 bf8 bf |
  c2 ~ |
  c8 c f16 (g) f8 |
  e4 e8 d |
  c4. c8 |
  d c bf [bf] |
  a2 ~ |
  a4
  
  a'16 (c) f,8 |
  g4. e8 |
  f f4 c8 |
  a'2 ~ |
  a4 r8 f |
  g8. a16 bf8 bf |
  a a r e |
  e8. f16 g8 f |
  d c r a' |
  f d4 d16 (e) |
  c8 f e (g) |
  a2 ~ |
  a8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hết thảy chư dân hãy vỗ tay tung hô Chúa
  giữa tiếng reo mừng,
  Vì Chúa cao trọng đáng kính sợ,
  là Vua khắp cõi trần gian.
  <<
    {
      \set stanza = "1."
      Chúa ngự lên lời reo vui dậy đất,
      Kèn trổi theo tiếng sao âm vang,
      Mừng Ngài vinh sáng lên trời cao,
      Hãy gảy đàn, gảy đàn lên mừng Chúa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Hãy đàn ca, đàn ca lên mừng Chúa,
	    Đàn ca lên kính Đức Vua ta,
	    Ngài là vua khắp cõi trần gian,
	    Hãy dâng Ngài khúc đàn ca tuyệt mỹ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa quyền uy, Ngài trông coi vạn quốc,
	    Ngự trên ngai chí thánh vinh quang,
	    cùng hàng khanh tướng vây chầu quanh,
	    Chúa siêu việt, các hoang vương phục kính.
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
  %page-count = #1
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
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
