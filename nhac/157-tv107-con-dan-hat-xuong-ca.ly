% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Đàn Hát Xướng Ca" }
  composer = "Tv. 107"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8. a16 f8 g |
  e4. c8 |
  a'4 \tuplet 3/2 { a8 a g } |
  fs4. g8 |
  e c'4 c8 |
  b4 r8 b16 c |
  c4 \tuplet 3/2 { c8 e c } |
  a4. a16 a |
  g4. d'8 |
  d
  \afterGrace b4 ({
    \override Flag.stroke-style = #"grace"
    a16)}
  \revert Flag.stroke-style
  g8 |
  c2 ~ |
  c8 \bar "||"
  
  c g a |
  a4 g8 g |
  e4. f8 |
  d2 ~ |
  d8 c d e |
  f4 e8 d |
  a'4. a8 |
  g2 ~ |
  g4 g8 g |
  a (c) d4 ~ |
  d8 d e c |
  b2 ~ |
  b4 b8 d |
  c (a) g4 ~ |
  g8 e' d b |
  c2 ~ |
  c4 r \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  R2*11
  r8
  c8 g a |
  a4 e8 e |
  c4. d8 |
  b2 ~ |
  b8 c b c |
  d4 c8 c |
  f4. f8 |
  e2 ~ |
  e4 e8 e |
  f (e) g4 ~ |
  g8 g c a |
  g2 ~ |
  g4 g8 g |
  a (f) e4 ~ |
  e8 [c] f g |
  e2 ~ |
  e4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Con vững dạ an lòng,
      lạy Chúa, với hết tâm hồn con đàn hát xướng ca,
      Dậy đi thôi cung sắt cung cầm
      Cho ta còn đánh thức cả bình minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Xin chiếu tỏa uy quyền, lạy Chúa,
	    sáng chói cung trời,
	    lan tràn khắp thế gian,
	    Và ra tay bênh đỡ hộ phù,
	    Xin nghe lời, cứu thoát kẻ Ngài thương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ai dắt dìu con vào thành thánh,
	    nếu Chúa cam lòng xua từ hết chúng con,
	    Phàm nhân đâu bênh đỡ ra gì,
	    Van xin Ngài trấn đánh kẻ thù cho.
    }
  >>
  \set stanza = "ĐK:"
  Trước mặt chư dân con dâng lời cảm tạ,
  Từ trong muôn nước con đàn hát xướng ca,
  Vì tình thương Chúa cao lút cung trời,
  Lòng tín trung Ngài vút trên ngàn mây.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  page-count = 1
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
