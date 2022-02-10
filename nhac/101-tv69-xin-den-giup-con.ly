% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Đến Giúp Con" }
  composer = "Tv. 69"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 c |
  a'8. a16 bf8 a |
  g4 g8 g |
  e8. f16 f8 g |
  c,4 r8 f |
  d8. c16 d8 f |
  a g4 g8 |
  c bf4 g8 |
  f4 r8 \bar "||" \break
  
  c' |
  a g16 g g (f) a8 |
  d,4. c8 ( |
  d) f a16 (g) f8 |
  g4 r8 bf |
  bf g16 bf
  \afterGrace g8 ({
    \override Flag.stroke-style = #"grace"
    f16)}
  \revert Flag.stroke-style
  g (bf) |
  c4. a8 ( |
  g) c bf g |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c8 c |
  f8. f16 g8 f |
  c4 b!8 b |
  c8. d16 d8 b! |
  c4 r8 a |
  bf8. a16 bf8 d |
  f e4 c8 |
  a' g4 e8 |
  f4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Vạn lạy Chúa, xin đến giúp con,
  Muôn tâu Ngài xin thương cứu trợ.
  Cho kẻ tìm hại mạng sống con phải nhuốc nhơ thẹn thùng.
  <<
    {
      \set stanza = "1."
      Ước chi ai mong con mắc họa
      phải quay gót thảm thê,
      Cho ai cưởi ha hả nhạo con
      phải tháo lui ê chề.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ước chi ai luôn trông kiếm Ngài
	    được trong Chúa mừng vui,
	    Ai yêu ơn cứu độ hãy nói:
	    Ôi Chúa bao vĩ đại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa ơi thân con đây khó hèn,
	    nguyện mau đến cùng con,
	    Chính Chúa nguồn cứu độ giải thoát,
	    đừng hoãn khoan chi hoài.
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
