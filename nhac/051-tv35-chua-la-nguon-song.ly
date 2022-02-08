% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Là Nguồn Sống" }
  composer = "Tv. 35"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 c8 |
  f8 d d4 ~ |
  d8 g e f |
  \slashedGrace { a16 ( } g4) r8 g |
  c4. a8 |
  d c4 d8 |
  e2 |
  e8 c d16 (c) a8 |
  a4 a8 c |
  g4. g8 |
  b d4 b8 |
  c2 ~ |
  c4 \bar "||" \break
  
  g8 c, |
  c8. f16 e8 d |
  g4 r8 g |
  e'16 (f) e8 e c |
  d4 b8 d |
  c2 |
  a8 b4 c8 |
  g2 ~ |
  g4 f |
  f4. g8 |
  e8. d16 c8 a' |
  a4 r8 g |
  d' d4 e8 |
  a, (b4) a8 |
  g4 b8 d |
  c2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r8 |
  R2*11
  r4
  
  g8 c, |
  c8. f16 e8 d |
  g4 r8 g |
  c16 (d) c8 c a |
  b4 g8 b |
  a2 |
  f8 d4 c8 |
  b2 ~ |
  b4 d |
  d4. b8 |
  c8. b16 a8 c |
  f4 r8 e |
  f g4 g8 |
  fs (g4) f!8 |
  e4 d8 f |
  e2 ~ |
  e4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Tội ác thì thầm trong lòng kẻ dữ:
      Cần chi phải tôn sợ Thiên Chúa,
      chúng tự cao tự đại,
      đâu biết mình cần chê ghét tội khiên.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Tình Chúa trổi vượt cung trời cao ngất,
	    thành tín vượt muôn tầng mây biếc,
	    Đức công chính của Ngài,
	    sâu thăm thẳm mà vươn lút đỉnh non.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Thực quá trọng đại ân tình của Chúa,
	    phàm nhân cùng trông tìm nương náu,
	    Nếm say yến tiệc Ngài,
	    bên suối ngàn, Ngài cho uống thỏa thuê.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Đừng phó mạng này cho phướng gian ác,
	    đừng để bọn hung tàn xông đánh,
	    chúng nhào xuống cả rồi,
	    đã ngã quỵ, đừng trông đứng dậy đâu.
    }
  >>
  \set stanza = "ĐK:"
  Chúa là nguồn chưa chan sự sống,
  nhờ ánh tôn nhan rạng soi
  đời chúng con bừng lên sáng ngời.
  Xin thương những ai luôn mộ mến Chúa,
  Và công minh xét xử cho người luôn tín trung.
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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
